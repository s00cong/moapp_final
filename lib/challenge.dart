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
    todos.add("저녁 6시 이후에 안먹기");
    todos.add("휴대폰 2시간 이상 보지않기");
    todos.add("금연30일");
    todos.add("일주일에 3번씩 45분 운동하기");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.blueGrey)),
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('챌린지 시작하기' , style : TextStyle(
            color : Colors.white
        )),
        backgroundColor: Color(0xFFA4D178),

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