import 'package:flutter/material.dart';

void main() {
  runApp(const MiCard());
}

class MiCard extends StatelessWidget {
  const MiCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: const Text(
          "Contact Card",
          style: TextStyle(fontFamily: "Schyler", fontSize: 26),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundImage: AssetImage("assets/me.jpeg"),
                backgroundColor: Colors.transparent,
                radius: 80,
              ),
              Text(
                "Nguyễn Hữu Dương",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Text(
                "FullStack Developer",
                style: TextStyle(fontSize: 30, letterSpacing: 3),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  thickness: 1,
                  color: Colors.blueAccent,
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text("Nguyễn Hữu Dương"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                  ),
                  title: Text("duongnh.23it@vku.udn.vn"),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text("nguyen huu duong "),
                ),
              )
            ]),
      ),
    ));
  }
}