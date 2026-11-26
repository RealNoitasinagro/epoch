/// Mini markup of info texts: `**bold**`, `*italic*`, `` `code` ``. Markers
/// that are not closed, or enclose nothing, stay literal; styles do not nest.
enum InfoStyle { plain, bold, italic, code }

typedef InfoSegment = ({String text, InfoStyle style});

const _markers = <(String, InfoStyle)>[
  ('**', InfoStyle.bold), // before '*': the longer marker wins
  ('*', InfoStyle.italic),
  ('`', InfoStyle.code),
];

List<InfoSegment> parseInfoMarkup(String markup) {
  final segments = <InfoSegment>[];
  final plainText = StringBuffer();

  void flushPlainText() {
    if (plainText.isEmpty) return;
    segments.add((text: plainText.toString(), style: InfoStyle.plain));
    plainText.clear();
  }

  var index = 0;
  while (index < markup.length) {
    var consumedMarker = false;
    for (final (marker, style) in _markers) {
      if (!markup.startsWith(marker, index)) continue;
      final contentStart = index + marker.length;
      final closingIndex = markup.indexOf(marker, contentStart);
      if (closingIndex <= contentStart) continue; // not closed, or empty
      flushPlainText();
      segments.add((
        text: markup.substring(contentStart, closingIndex),
        style: style,
      ));
      index = closingIndex + marker.length;
      consumedMarker = true;
      break;
    }
    if (consumedMarker) continue;
    plainText.write(markup[index]);
    index++;
  }
  flushPlainText();
  return segments;
}

/// Paragraphs are separated by an empty line ("\n\n" in the ARB files).
List<String> splitParagraphs(String text) => text
    .split('\n\n')
    .map((paragraph) => paragraph.trim())
    .where((paragraph) => paragraph.isNotEmpty)
    .toList();
