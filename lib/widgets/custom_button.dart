import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width = 140,
  }) : super(key: key);

  final Function() onPressed;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onPressed: onPressed,
        label: Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
