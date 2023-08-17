import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Model class
class Language {
  final int srno;
  final String defaultLang;
  final String english;
  final String tamil;
  final String hindi;
  final String kannada;
  final String malayalam;
  final String telugu;

  Language({
    required this.srno,
    required this.defaultLang,
    required this.english,
    required this.tamil,
    required this.hindi,
    required this.kannada,
    required this.malayalam,
    required this.telugu,
  });
}

// Database Helper class
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'language.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE language (
        srno INTEGER PRIMARY KEY,
        defautlang TEXT,
        english TEXT,
        tamil TEXT,
        hindi TEXT,
        kannada TEXT,
        malayalam TEXT,
        telugu TEXT
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('language', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query('language');
  }
}

// ViewModel class
class LanguageViewModel extends ChangeNotifier {
  List<Language> _languages = [];
  List<Language> get languages => _languages;
  bool _isDataLoaded = false;
  bool get isDataLoaded => _isDataLoaded;

  Future<void> fetchLanguages() async {
    if (!_isDataLoaded) {
      final List<Map<String, dynamic>> languageMaps =
          await DatabaseHelper.instance.queryAllRows();
      print('languageMaps');
      print(languageMaps);
      if (languageMaps.isEmpty) {
        final apiData = await fetchDataFromAPI(); // Replace with your API call
        for (var apiEntry in apiData) {
          await DatabaseHelper.instance.insert(apiEntry);
        }
        _isDataLoaded = true;
      } else {
        _languages = languageMaps
            .map((map) => Language(
                  srno: map['srno'],
                  defaultLang: map['defautlang'],
                  english: map['english'],
                  tamil: map['tamil'],
                  hindi: map['hindi'],
                  kannada: map['kannada'],
                  malayalam: map['malayalam'],
                  telugu: map['telugu'],
                ))
            .toList();
        print('-lang$_languages');
        _isDataLoaded = true;
      }
      notifyListeners();
    }
  }

  // Replace this with your actual API call
  Future<List<Map<String, dynamic>>> fetchDataFromAPI() async {
    // Simulated API response
    await Future.delayed(Duration(seconds: 0));
    return [
      {
        'srno': 1,
        'defautlang': 'English',
        'english': 'English',
        'tamil': 'Tamil',
        'hindi': 'Hindi',
        'kannada': 'Kannada',
        'malayalam': 'Malayalam',
        'telugu': 'Telugu',
      }
    ];
  }
}

// UI code
class LanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LanguageViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Languages'),
        ),
        body: LanguageListView(),
      ),
    );
  }
}

class LanguageListView extends StatefulWidget {
  @override
  _LanguageListViewState createState() => _LanguageListViewState();
}

class _LanguageListViewState extends State<LanguageListView> {
  late BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();
    //   Provider.of<LanguageViewModel>(_scaffoldContext, listen: false)
    //      .fetchLanguages();
    // LanguageViewModel.fetchfetchLanguages();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LanguageViewModel>(context, listen: false).fetchLanguages();
    return Consumer<LanguageViewModel>(
      builder: (context, viewModel, child) {
        if (!viewModel.isDataLoaded) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (viewModel.languages.isEmpty) {
          return Center(
            child: Text('No data available.'),
          );
        } else {
          return ListView.builder(
            itemCount: viewModel.languages.length,
            itemBuilder: (context, index) {
              final language = viewModel.languages[index];
              print(viewModel.languages.length);
              print(viewModel.languages);
              return ListTile(
                title: Text(language.defaultLang),
                // Add other fields here
              );
            },
          );
        }
      },
    );
  }
}
