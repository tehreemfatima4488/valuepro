import 'package:flutter/material.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          title: const Text(
            "D E S K T O P",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purple,
        ),
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AspectRatio(
                      aspectRatio: 20 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple[600],
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.purple[600],
                                  borderRadius: BorderRadius.circular(25)),
                              height: 100,
                            ),
                          );
                        },
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.purple[600],
                    borderRadius: BorderRadius.circular(25)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
