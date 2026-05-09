import 'package:flutter/material.dart';
import '../models/timezone_search.dart';
import '../l10n/app_localizations.dart';

// Full-screen timezone search, returns selected IANA zone string or null.
class TimezoneSearchScreen extends StatefulWidget {
  const TimezoneSearchScreen({super.key});

  @override
  State<TimezoneSearchScreen> createState() => _TimezoneSearchScreenState();
}

class _TimezoneSearchScreenState extends State<TimezoneSearchScreen> {
  final _controller = TextEditingController();
  List<TzEntry> _results = tzDatabase;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String query) {
    final q = query.trim();
    if (q.isEmpty) {
      setState(() => _results = tzDatabase);
      return;
    }
    // Try offset search first (UTC+05:30 etc).
    final byOffset = searchByOffset(q, tzDatabase);
    if (byOffset.isNotEmpty) {
      setState(() => _results = byOffset);
      return;
    }
    setState(() =>
    _results = tzDatabase.where((e) => e.matches(q)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectTimezone),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: l10n.timezoneSearchHint,
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
      body: _results.isEmpty
          ? Center(child: Text(l10n.timezoneNoResults))
          : ListView.builder(
        itemCount: _results.length,
        itemBuilder: (context, index) {
          final entry = _results[index];
          return ListTile(
            title: Text(entry.cityName),
            subtitle: Text(
              '${entry.ianaZone}  ·  ${entry.offsetLabel}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            onTap: () => Navigator.pop(context, entry.ianaZone),
          );
        },
      ),
    );
  }
}