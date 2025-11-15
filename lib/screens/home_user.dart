import 'package:flutter/material.dart';

class HomeUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('Home User Screen'),
      ),
        body: ListView(children: [
          AddressFrame(),
        ]),
    );
  }
}
class AddressFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 59,
          height: 58,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 59,
                  height: 58,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF043915),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              Positioned(
            bottom: 20,  // Cách dưới 20px
            right: 20,   // Cách phải 20px
            child: Icon(Icons.star, size: 50, color: Colors.yellow),
          ),
            ],
          ),
        ),
      ],

    );
  }
}