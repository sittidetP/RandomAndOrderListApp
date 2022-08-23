import 'package:flutter/material.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final TextEditingController _controller = TextEditingController();

  List _results = [];

  void _checkInputAndProcess() {
    //ตรวจสอบข้อมูลเข้า แล้วนำไปประมวลผล
    setState(() {
      if (_results.isNotEmpty) {
        _results.clear();
      }

      List names = _controller.value.text.split("\n");
      _results = names.where((element) {
        String name = element as String;
        // print("${name} : ${name.length}, ${name.isNotEmpty}");
        return name.trim().isNotEmpty;
      }).toList();
      // print(names);
      _results.shuffle();
      print(_results);

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        for (int i = 0; i < _results.length; ++i)
                          Text("${i + 1}. ${_results[i]}"),
                      ],
                    ),
                  )
                ],
              ),
              _buildInputPanel(),
            ],
          ),
      ),
    );
  }

  Widget _buildInputPanel() { //ที่ใส่เลข
    return Column(
      children: [
        ElevatedButton(
          onPressed: () { //เมื่อกดปุ่ม
            _checkInputAndProcess();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Random!',
              style: TextStyle(fontSize: 22.0, color: Colors.yellow),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),

          ),
          width: MediaQuery.of(context).size.width * 0.35,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              child: SingleChildScrollView(
                child: TextField( //ช่องใส่ชื่อ

                  onSubmitted: (value) {
                    //เมื่อกด enter
                    // _checkInputAndProcess();
                  },
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                  cursorColor: Colors.white,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white.withOpacity(0.5),
                          )),
                      hintText: 'Enter the positive integer here',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 20.0,
                      )),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
