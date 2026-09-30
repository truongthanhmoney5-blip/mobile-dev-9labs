import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Text('I Am Rich'),
          backgroundColor: Colors.blueGrey[900],
        ),
        body: Center(
          child: Image(
            // Đảm bảo bạn đã thêm file ảnh vào thư mục assets và khai báo trong pubspec.yaml
            image: AssetImage('images/diamond.png'), 
          ),
        ),
      ),
    ),
  );
}