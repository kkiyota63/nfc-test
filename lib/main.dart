import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('NFC Card Balance Checker'),
        ),
        body: NfcReader(),
      ),
    );
  }
}

class NfcReader extends StatefulWidget {
  @override
  _NfcReaderState createState() => _NfcReaderState();
}

class _NfcReaderState extends State<NfcReader> {
  String _tagInfo = 'カードをかざしてください';

  void _readNfc() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final id = tag.data['id']; // NFCタグのIDを取得
      setState(() {
        _tagInfo = 'Tag ID: $id';
      });
      NfcManager.instance.stopSession();
    });
  }

  @override
  void initState() {
    super.initState();
    _readNfc();
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_tagInfo),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _readNfc,
            child: Text('再読み取り'),
          ),
        ],
      ),
    );
  }
}
