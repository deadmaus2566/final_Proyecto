import 'package:flutter/material.dart';

class FireBaseUIButton extends StatefulWidget {
  final BuildContext? context;
  final String? title;
  final Function? onTap;
  const FireBaseUIButton({
    Key? key,
    this.context,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  State<FireBaseUIButton> createState() => _FireBaseUIButtonState();
}

class _FireBaseUIButtonState extends State<FireBaseUIButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          widget.onTap!();
        },
        child: Text(
          widget.title!,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black26;
              }
              return Colors.white;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)))),
      ),
    );
  }
}
