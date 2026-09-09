import 'package:flutter/material.dart';

class A extends StatelessWidget {
  A({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
         child: Column(
          children: [
            Text("1"),
          ],
         ),
         ),
    );
  }
}
