import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CML Instances",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ServerList(),
    );
  }
}

class ServerList extends StatefulWidget {
  @override
  _ServerListState createState() => _ServerListState();
}

class _ServerListState extends State<ServerList> {
  final List<WordPair> _serverList = <WordPair>[];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CML Instances'),
      ),
      body: _buildServerList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushAdd,
      ),
    );
  }

  Widget _buildServerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        final int index = i ~/ 2;
        if (index >= _serverList.length) {
          _serverList.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_serverList[index]);
      },
    );
  }

  Widget _buildRow(WordPair server) {
    return ListTile(
      title: Text(
        server.asLowerCase,
      ),
      leading: Icon(Icons.edit),
    );
  }

  void _pushAdd() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add a server'),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Server Nickname:',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a nickname for this server.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Host name or IP:',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a name or IP address.';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // grab stuff here
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
