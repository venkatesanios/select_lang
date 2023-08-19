import 'package:flutter/material.dart';
import 'package:select_lang/db/sqlhelper.dart';

class Langsample extends StatelessWidget {
  const Langsample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Language Select',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
    print(_journals);
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
    _Againinsert(); // Loading the diary when the app starts
  }

  final TextEditingController _defaultlangController = TextEditingController();
  final TextEditingController _englishController = TextEditingController();
  final TextEditingController _tamilController = TextEditingController();
  final TextEditingController _hindiController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['id'] == id);
      _defaultlangController.text = existingJournal['defaultlang'];
      _englishController.text = existingJournal['english'];
      _tamilController.text = existingJournal['tamil'];
      _hindiController.text = existingJournal['hindi'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _defaultlangController,
                    decoration:
                        const InputDecoration(hintText: 'defaultlanguage'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _englishController,
                    decoration: const InputDecoration(hintText: 'english'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _tamilController,
                    decoration: const InputDecoration(hintText: 'tamil'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _hindiController,
                    decoration: const InputDecoration(hintText: 'hindi'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _defaultlangController.text = '';
                      _englishController.text = '';
                      _tamilController.text = '';
                      _hindiController.text = '';

                      // Close the bottom sheet
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

  void _Againinsert() async {
    // setState(() async {
    for (var i = 0; i < _journals.length; i++) {
      print('Again.inserts');

      print(_journals.length);
      String defaultval = _journals[i]['defaultlang'];
      String englishval = _journals[i]['english'];
      String tamilval = _journals[i]['tamil'];
      String hindival = _journals[i]['hindi'];

      await SQLHelper.createItem(defaultval, englishval, tamilval, hindival);
    }
    // });

    _refreshJournals();
  }

  void _Reloadall() async {
    // setState(() async {
    print(_journals.length);
    await SQLHelper.deleteAllItems();
    for (var i = 0; i < _journals.length; i++) {
      print('Again.inserts');

      print(_journals.length);
      String defaultval = _journals[i]['defaultlang'];
      String englishval = _journals[i]['english'];
      String tamilval = _journals[i]['tamil'];
      String hindival = _journals[i]['hindi'];

      await SQLHelper.createItem(defaultval, englishval, tamilval, hindival);
    }
    // });

    _refreshJournals();
  }

  void _Deleteall() async {
    CircularProgressIndicator();
    await SQLHelper.deleteAllItems();
    _refreshJournals();
  }

  // Clear the text fields

// Insert a new journal to the database
  Future<void> _addItem() async {
    await SQLHelper.createItem(_defaultlangController.text,
        _englishController.text, _tamilController.text, _hindiController.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await SQLHelper.updateItem(id, 'hello', 'hello', 'வணக்கம்', 'नमस्ते');
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('language selection'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) => Card(
                  color: Colors.orange[200],
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Text('$index'),
                      Text('word:-' + _journals[index]['defaultlang']),
                      Text('English Language:-' + _journals[index]['english']),
                      Text('Tamil Language:-' + _journals[index]['tamil']),
                      Text('Hindi Language:-' + _journals[index]['hindi']),
                      SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showForm(_journals[index]['id']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteItem(_journals[index]['id']),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
      floatingActionButton: Wrap(
          direction: Axis.horizontal, //use vertical to show  on vertical axis
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () => _Reloadall(),
                  child: Icon(Icons.update),
                )), //button first

            Container(
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () => _showForm(null),
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(Icons.add),
                )), // button second
            Container(
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () => _Againinsert(),
                  backgroundColor: Colors.yellow,
                  child: Icon(Icons.restart_alt),
                )),

            Container(
                margin: EdgeInsets.all(10),
                child: FloatingActionButton(
                  onPressed: () => _Deleteall(),
                  backgroundColor: Colors.deepOrangeAccent,
                  child: Icon(Icons.delete_forever),
                )),
          ]),
    );
  }
}
