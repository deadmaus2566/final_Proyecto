import 'package:flutter/material.dart';

class FireBaseUIButton extends StatelessWidget {
  final BuildContext? context;
  final String? title;
  final Function? onTap;
  final bool isIcon;
  final IconData? icon;
  const FireBaseUIButton({
    Key? key,
    this.context,
    this.title,
    this.onTap,
    this.isIcon = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(
        0,
        10,
        0,
        20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          90,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          onTap!();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isIcon)
              Icon(
                isIcon ? icon : null,
                color: Colors.red,
              ),
            Text(
              title!,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
