import 'package:flutter/material.dart';
import 'package:flutter_app/dataCountry.dart';
import 'package:flutter_app/notifiers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SingleNotifier>(create: (_) => SingleNotifier()),
        ChangeNotifierProvider<MultipleNotifier>(
            create: (_) => MultipleNotifier([])),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AlertDialog'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('AlertDialog Dialog'),
            onTap: () {
              _showMessageDialog(context);
            },
          ),
          ListTile(
            title: Text('Single Choice Dialog'),
            onTap: () {
              _showSingleDialog(context);
            },
          ),
          ListTile(
            title: Text('Multiple Choice Dialog'),
            onTap: () {
              _showMultipleChoiceDialog(context);
            },
          ),
          ListTile(
            title: Text('TextField Dialog'),
            onTap: () {
              _showAddNoteDialog(context);
            },
          ),
        ],
      ),
    );
  }

  _showMessageDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to delete all items?'),
          actions: [
            FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Yes')),
            FlatButton(
                onPressed: () => Navigator.of(context).pop(), child: Text('No'))
          ],
        ),
      );

  _showSingleDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _singleNotifier = Provider.of<SingleNotifier>(context);
        return AlertDialog(
          title: Text('Select your country'),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: country
                      .map((e) => RadioListTile(
                          title: Text(e),
                          value: e,
                          groupValue: _singleNotifier.currentCountry,
                          selected: _singleNotifier.currentCountry == e,
                          onChanged: (value) {
                            _singleNotifier.updateCountry(value);
                            Navigator.of(context).pop();
                          }))
                      .toList()),
            ),
          ),
        );
      });

  _showMultipleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        final _multipleNotifier = Provider.of<MultipleNotifier>(context);
        return AlertDialog(
          title: Text('Select one country or many countries'),
          content: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: country
                      .map((e) => CheckboxListTile(
                            title: Text(e),
                            onChanged: (value) {
                              value
                                  ? _multipleNotifier.addItem(e)
                                  : _multipleNotifier.removeItem(e);
                            },
                            value: _multipleNotifier.isHaveItem(e),
                          ))
                      .toList(),
                )),
          ),
          actions: [
            FlatButton(
              child: Text('Yes'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });

  _showAddNoteDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add your note"),
        content: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Enter your note',
                      icon: Icon(Icons.note_add)),
                )
              ],
            ),
          ),
        ),
        actions: [
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
