import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../layout_constants.dart';
import '../main.dart';
import '../models/app_settings.dart';
import '../models/timezone_search.dart';
import '../models/timezone_search_normalize.dart';
import '../models/timezone_search_zones.dart';
import '../time_utils.dart';
import '../time_value_formatter.dart';

// Full-screen timezone search, returns selected IANA zone string or null.
class TimezoneSearchScreen extends StatefulWidget {
  const TimezoneSearchScreen({super.key});

  @override
  State<TimezoneSearchScreen> createState() => _TimezoneSearchScreenState();
}

// Sources whose hit is another city / another country of this zone.
const _citySources = {
  'iana_links', 'cldr_exemplar_cities', 'wikidata_capitals', 'major_cities',
};
const _countrySources = {
  'iso3166_names_EN', 'cldr_country_names_EN', 'country_names_DE',
  'country_aliases_EN', 'country_aliases_DE',
};

class _TimezoneSearchScreenState extends State<TimezoneSearchScreen> {
  final _controller = TextEditingController();
  String _query = '';

  // The result list is derived state: it depends on the query AND on the
  // locale, which is only available in build(). Memoized so that unrelated
  // rebuilds do not search again.
  String? _memoKey;
  List<TzResult> _memoResults = const [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final entry in tzDatabase) { entry.normalizedCandidates; }
    });
  }

  // TextField.onChanged is a ValueChanged<String>: the field calls it with
  // its current text, which is where [query] comes from.
  void _onQueryChanged(String query) => setState(() => _query = query.trim());

  List<TzResult> _resultsFor(String locale) {
    final key = '$locale|$_query';
    if (key != _memoKey) {
      //_memoResults = searchTimezonesRanked(_query, tzDatabase, locale: locale);
      final stopwatch = Stopwatch()..start();
      _memoResults = searchTimezonesRanked(_query, tzDatabase, locale: locale);
      debugPrint('search "$_query": ${stopwatch.elapsedMilliseconds} ms, ${_memoResults.length} hits');
      _memoKey = key;
    }
    return _memoResults;
  }

  // Why does this zone show up, if the reason is not already in the title?
  String? _matchHint(TzResult result, String locale, AppLocalizations l10n) {
    final match = result.match;
    if (match == null || (match.rule != 'exact' && match.rule != 'prefix')) {
      return null;
    }
    final isCity = _citySources.contains(match.source);
    final isCountry = _countrySources.contains(match.source);
    if (!isCity && !isCountry) return null;
    final ownNames = {
      result.entry.displayCity(locale),
      ...result.entry.ownCountryNames,
    }.map(normalize);
    if (ownNames.contains(normalize(match.term))) return null;
    return isCity
        ? l10n.hintMatchAlsoCity(match.term)
        : l10n.hintMatchAlsoCountry(match.term);
  }

  Widget _buildTile(BuildContext context, TzResult result, String locale,
      AppLocalizations l10n, EpochAppState app, DateTime nowUtc) {
    final entry = result.entry;
    final hint = _matchHint(result, locale, l10n);
    final local = TimeUtils.inZone(nowUtc, entry.ianaZoneId);
    final time = TimeValueFormatter.formatTime(
        app.hourFormat24, local.hour, local.minute, 0,
        pattern: kTimePatternNoSeconds);
    return ListTile(
      title: Text(entry.displayTitle(locale),
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${hint ?? entry.ianaZoneId}  ·  ${entry.offsetLabel}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall),
      trailing: Text(time, style: const TextStyle(fontFamily: fontFamilyDefault)),
      onTap: () => Navigator.pop(context, entry.ianaZoneId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final app = EpochApp.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final results = _resultsFor(locale);
    final nowUtc = DateTime.now().toUtc();
    return Scaffold(
      appBar: AppBar(
        title: Text('${l10n.hintSelectTimezone} (${results.length})'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: l10n.hintTimezoneSearch,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    _onQueryChanged('');
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                isDense: true,
                filled: true,
              ),
              onChanged: _onQueryChanged,
            ),
          ),
        ),
      ),
      body: results.isEmpty
          ? Center(child: Text(l10n.messageNoTimezone))
          : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) => _buildTile(
            context, results[index], locale, l10n, app, nowUtc),
      ),
    );
  }
}
