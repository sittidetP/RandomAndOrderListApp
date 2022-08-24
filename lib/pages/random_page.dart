import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollControllerInput = ScrollController();
  final ScrollController _scrollControllerResult = ScrollController();

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

      Set newNamesSet = {};
      for (int i = 0; i < _results.length; ++i) {
        newNamesSet.add(_results[i]);
      }
      // print(names);
      // print(newNamesSet);
      _results = newNamesSet.toList();
      _results.shuffle();
      // print(_results);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            _buildResultBoard(scrollControllerResult: _scrollControllerResult, results: _results),
            _buildInputPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputPanel() {
    //ที่ใส่เลข
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              //เมื่อกดปุ่ม
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
                  controller: _scrollControllerInput,
                  child: TextField(
                    //ช่องใส่ชื่อ
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: GoogleFonts.kanit(
                        fontSize: 24.0,
                        color: Colors.white
                    ),
                    cursorColor: Colors.white,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                        )),
                        hintText: 'Enter the Names here',
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
      ),
    );
  }
}

class _buildResultBoard extends StatelessWidget {
  const _buildResultBoard({
    Key? key,
    required ScrollController scrollControllerResult,
    required List results,
  }) : _scrollControllerResult = scrollControllerResult, _results = results, super(key: key);

  final ScrollController _scrollControllerResult;
  final List _results;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            width: MediaQuery.of(context).size.width * 0.6,
            constraints: const BoxConstraints(maxHeight: 500),
            child: SingleChildScrollView(
              controller: _scrollControllerResult,
              child: Column(
                children: [
                  for (int i = 0; i < _results.length; ++i)
                    Text(
                      "${i + 1}. ${_results[i]}",
                      style: GoogleFonts.kanit(
                        fontSize: 24.0,
                        color: Colors.black
                      ),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
