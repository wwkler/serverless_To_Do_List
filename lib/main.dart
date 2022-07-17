import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.orange),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 데이터 저장할 list
  List<String> list = [];

  // AlertDialog에 write할 문자열 데이터
  String input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('서버 사용하지 않는 List'),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Additional Menu'),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          // build 함수에 즉시 반영하는 setState()
                          setState(() {
                            list.add(input);
                            Navigator.of(context).pop(); // click하면 바로 창 닫기
                          });
                        },
                        child: Text('데이터 저장하기')),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      // List에 있는 데이터를 ListView 화면에 보여지도록 합니다.
      body: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(list[index]),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  child: ListTile(
                      leading: FlutterLogo(),
                      title: Text('${list[index]}'),
                      trailing: IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // build 함수에 즉시 반영되는 setState()
                          setState(() {
                            list.removeAt(index);
                          });
                        },
                      )),
                ));
          }),
    );
  }
}
