import 'package:flutter/material.dart';

class AddBoardTitle extends StatelessWidget {
  const AddBoardTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: const BoxDecoration(color: Color(0xAA09746A), boxShadow: [
        BoxShadow(
            spreadRadius: 1,
            color: Color(0xAA09746A),
            blurRadius: 5,
            offset: Offset(0, 3))
      ]),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
            cursorColor: Colors.white,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                isDense: true,
                border: InputBorder.none,
                fillColor: Color(0xAA09746A),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                )),
          ),
        ),
      ),
    );
  }
}
