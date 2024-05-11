import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(25),
        child: Row(children: [
        Icon(Icons.person, color: Theme.of(context).colorScheme.inversePrimary),
         const SizedBox(width: 20,),
          Text(text, style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.inversePrimary),)
        ],),
      ),
    );
  }
}