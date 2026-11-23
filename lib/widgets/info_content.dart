import 'package:flutter/material.dart';
import '../app/layout_constants.dart';
import '../formatting/info_markup.dart';
import '../formatting/value_info.dart';
import 'link_text.dart';
import 'section_header.dart';

/// Renders the blocks of [buildInfoBlocks].
class InfoContent extends StatelessWidget {
  final List<InfoBlock> blocks;

  const InfoContent({super.key, required this.blocks});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final block in blocks)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: switch (block) {
              InfoParagraph(:final markup) => _markupText(context, markup),
              InfoHeading(:final text) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SectionHeader(label: text),
              ),
              InfoLinkBlock(:final url) => LinkText(url: url),
            },
          ),
      ],
    );
  }

  Widget _markupText(BuildContext context, String markup) {
    return Text.rich(TextSpan(children: [
      for (final segment in parseInfoMarkup(markup))
        TextSpan(text: segment.text, style: _styleOf(segment.style)),
    ]));
  }

  TextStyle? _styleOf(InfoStyle style) => switch (style) {
    InfoStyle.plain => null,
    InfoStyle.bold => const TextStyle(fontWeight: FontWeight.bold),
    InfoStyle.italic => const TextStyle(fontStyle: FontStyle.italic),
    InfoStyle.code => const TextStyle(fontFamily: fontFamilyDefault),
  };
}
