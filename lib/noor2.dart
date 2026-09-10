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
            Row(
              children: [
                Text("noor"),
                Text("najeeb"),
                Text("alameri"),
                Text("2")
              ],
            )
          ],
         ),
         ),
    );
  }
}
