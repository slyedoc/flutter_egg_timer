import 'package:flutter/material.dart';

class EggTimerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onPressed;

  EggTimerButton({Key key, this.icon, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: const Color(0x22000000),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Icon(
                this.icon,
                color: Colors.black,
              ),
            ),
            Text(
              this.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 3.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
