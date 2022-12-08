import 'package:flutter/material.dart';

class challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<challenge> {
  List todos = [];
  String input = "";

  @override
  void initState() {
    super.initState();
    todos.add("Item1");
    todos.add("Item2");
    todos.add("Item3");
    todos.add("Item4");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("mytodos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: Text("목표입력"),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),

                    actions: <Widget>[

                      OutlinedButton(
                          onPressed: (){
                        setState(() {
                          todos.add(input);
                        });
                        Navigator.of(context).pop();	// input 입력 후 창 닫히도록
                      },
                          child: Text("Add")
                      )

                    ]

                );
              });
        },

        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(	// 삭제 버튼 및 기능 추가
                key: Key(todos[index]),
                child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)
                    ),
                    child: ListTile(
                      title: Text(todos[index]),
                      trailing: IconButton(icon: Icon(
                          Icons.delete,
                          color: Colors.red
                      ),
                          onPressed: () {
                            setState(() {
                              todos.removeAt(index);
                            });
                          }),
                    )
                ));
          }),
    );
  }
}