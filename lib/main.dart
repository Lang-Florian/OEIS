import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Sequence {
  final String number;
  final List<String> data;
  final String name;
  final List<String> comments;
  final List<String> references;
  final List<String> links;
  final List<String> formulas;
  final List<String> examples;
  final List<String> maple;
  final List<String> mathematica;
  final List<String> program;
  final List<String> crossReferences;
  final String offset;
  final String author;
  final List<String> keywords;

  Sequence({
    required this.number,
    required this.data,
    required this.name,
    required this.comments,
    required this.references,
    required this.links,
    required this.formulas,
    required this.examples,
    required this.maple,
    required this.mathematica,
    required this.program,
    required this.crossReferences,
    required this.offset,
    required this.author,
    required this.keywords,
  });

  Widget getWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SequenceScreen(sequence: this),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  title: Text(
                    'A${number.padLeft(6, '0')}',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  subtitle: Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data.join(', '),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (comments.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    comments[0] + (comments.length > 1 ? '\n...' : ''),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  factory Sequence.fromJson(Map<String, dynamic> json) {
    return Sequence(
      number: json['number'].toString(),
      data: json['data'].split(','),
      name: json['name'],
      comments: ((json['comment'] ?? []) as List).map((e) => e.toString()).toList(),
      references: ((json['reference'] ?? []) as List).map((e) => e.toString()).toList(),
      links: ((json['link'] ?? []) as List).map((e) => e.toString()).toList(),
      formulas: ((json['formula'] ?? []) as List).map((e) => e.toString()).toList(),
      examples: ((json['example'] ?? []) as List).map((e) => e.toString()).toList(),
      maple: ((json['maple'] ?? []) as List).map((e) => e.toString()).toList(),
      mathematica: ((json['mathematica'] ?? []) as List).map((e) => e.toString()).toList(),
      program: ((json['program'] ?? []) as List).map((e) => e.toString()).toList(),
      crossReferences: ((json['xref'] ?? []) as List).map((e) => e.toString()).toList(),
      offset: json['offset'] ?? '',
      author: json['author'] ?? '',
      keywords: json['keyword'].toString().split(',')..removeWhere((e) => e.isEmpty),
    );
  }
}

class SequenceScreen extends StatelessWidget {
  final Sequence sequence;

  const SequenceScreen({Key? key, required this.sequence}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('A${sequence.number.padLeft(6, '0')}'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0.0, bottom: 8.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  sequence.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  sequence.data.join(', '),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            if (sequence.comments.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.comments.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.references.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    sequence.references.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.links.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    sequence.links.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.formulas.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.formulas.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.examples.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.examples.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.maple.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.maple.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.mathematica.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.mathematica.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.program.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.program.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.crossReferences.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    sequence.crossReferences.join('\n\n'),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.offset.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    sequence.offset,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.author.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    sequence.author,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            if (sequence.keywords.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    sequence.keywords.join(','),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.dark);

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (_, mode, __) =>
      MaterialApp(
        title: 'OEIS',
        home: const SearchScreen(),
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Color.fromARGB(255, 55, 79, 120),
          brightness: Brightness.light,
          fontFamily: 'SourceCodePro',
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Color.fromARGB(255, 55, 79, 120),
          brightness: Brightness.dark,
          fontFamily: 'SourceCodePro',
        ),
        themeMode: mode,
      )
    );
  }

  switchTheme() async {
    if (_themeMode.value == ThemeMode.dark) {
      _themeMode.value = ThemeMode.light;
    } else if (_themeMode.value == ThemeMode.light) {
      _themeMode.value = ThemeMode.dark;
    }
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final _queryController = TextEditingController();
  List<Sequence> _searchResults = [];
  int _count = -1;
  bool _isSearching = false;
  bool _isLoadingMore = false;
  bool _noResults = false;
  String _currentQuery = '';

  App get app => context.findAncestorWidgetOfExactType<App>()!;

  void _searchSequences() async {
    // show alert dialog
    if (_queryController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Please enter a query.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }
    setState(() {
      _searchResults = [];
      _count = 0;
      _isSearching = true;
      _isLoadingMore = false;
      _noResults = false;
      _currentQuery = '';
    });
    var uri = Uri.https('oeis.org', '/search', {
      'q': _queryController.text,
      'fmt': 'json',
    });
    final response = await http.get(uri);
    setState(() {
      _isSearching = false;
      if (response.statusCode != 200 ||
          response.headers['content-type'] != 'application/json' ||
          jsonDecode(response.body)['count'] == 0 ||
          jsonDecode(response.body)['results'] == null) {
        _noResults = true;
        return;
      }
      _searchResults = (jsonDecode(response.body)['results'] as List).map((e) => Sequence.fromJson(e)).toList();
      _count = jsonDecode(response.body)['count'];
      _currentQuery = _queryController.text;
    });
  }

  void _loadMoreSequences() async {
    if (_isLoadingMore) {
      return;
    }
    _isLoadingMore = true;
    var uri = Uri.https('oeis.org', '/search', {
      'q': _currentQuery,
      'fmt': 'json',
      'start': _searchResults.length.toString(),
    });
    final response = await http.get(uri);
    setState(() {
      _isLoadingMore = false;
      if (response.statusCode != 200 ||
          response.headers['content-type'] != 'application/json' ||
          jsonDecode(response.body)['count'] == 0 ||
          jsonDecode(response.body)['results'] == null) {
        return;
      }
      _searchResults.addAll((jsonDecode(response.body)['results'] as List).map((e) => Sequence.fromJson(e)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OEIS',
          style: TextStyle(
            color: app._themeMode.value == ThemeMode.light ?
              Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: app._themeMode.value == ThemeMode.dark ?
          Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Icon(app._themeMode.value == ThemeMode.light ? Icons.light_mode : Icons.dark_mode),
            onPressed: app.switchTheme,
            color: app._themeMode.value == ThemeMode.light ?
              Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('About this App...'),
                    content: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(text: 'This app is a simple search client for the '),
                          TextSpan(
                            text: 'OEIS',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrl(
                                Uri.https('oeis.org', '/'),
                                mode: LaunchMode.externalApplication,
                              )
                          ),
                          const TextSpan(text: ' (On-Line Encyclopedia of Integer Sequences).\n'),
                          const TextSpan(text: 'It is not affiliated with the OEIS in any way.\n\n'),
                          const TextSpan(text: 'The Font is Source Code Pro by Paul D. Hunt.\n\n'),
                          const TextSpan(text: 'The source code for this app is available on '),
                          TextSpan(
                            text: 'GitHub',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrl(
                                Uri.https('github.com', '/n3u1r0n/oeis'),
                                mode: LaunchMode.externalApplication,
                              )
                          ),
                          const TextSpan(text: '.\n\nMade with '),
                          TextSpan(
                            text: '❤',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const TextSpan(text: ' by '),
                          TextSpan(
                            text: 'n3u1r0n',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => launchUrl(
                                Uri.https('github.com', '/n3u1r0n'),
                                mode: LaunchMode.externalApplication,
                              )
                          ),
                          const TextSpan(text: '.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cool Story Bro'),
                      ),
                    ],
                  );
                },
              );
            },
            color: app._themeMode.value == ThemeMode.light ?
              Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            floating: true,
            snap: true,
            pinned: _isSearching || _noResults,
            title: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefix: Text('Seq. '),
                    ),
                    onSubmitted: (value) => _searchSequences(),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  ),
                ),
                ElevatedButton(
                  onPressed: _searchSequences,
                  child: const Text('Search'),
                ),
              ],
            )
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= _searchResults.length) {
                  _loadMoreSequences();
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return _searchResults[index].getWidget(context);
              },
              childCount: _count > _searchResults.length ? _searchResults.length + 1 : _searchResults.length,
            ),
          ),
          if (_isSearching)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          if (_noResults)
            const SliverFillRemaining(
              child: Center(
                child: Text('No Results!'),
              ),
            ),
        ],
      ),
      bottomSheet: Row(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                _isSearching ? 'Searching...' : (_count == -1 ? 'Search a Sequence.' : 'Found $_count results'),
                textAlign: TextAlign.center,
              ),
            )
          ),
        ],
      ),
    );
  }
}
