import 'package:flutter/material.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Carregando...",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 15),
            CircularProgressIndicator(),
          ],
        ),
      );
  }
}