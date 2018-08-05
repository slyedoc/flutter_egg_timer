import 'package:egg_timer/egg_timer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EggTimerTimeDisplay extends StatefulWidget {
  final EggTimerState eggTimerState;
  final Duration selectionTime;
  final Duration countdownTime;

  EggTimerTimeDisplay(
      {Key key,
      this.eggTimerState,
      this.selectionTime = const Duration(seconds: 0),
      this.countdownTime = const Duration(seconds: 0)})
      : super(key: key);

  @override
  _EggTimerTimeDisplayState createState() => _EggTimerTimeDisplayState();
}

class _EggTimerTimeDisplayState extends State<EggTimerTimeDisplay> with TickerProviderStateMixin {
  final DateFormat selectionTimeFormat = DateFormat('mm');
  final DateFormat countdownTimeFormat = DateFormat('mm:ss');

  AnimationController selectionTimeSlideController;
  AnimationController countdownTimeFadeController;
  
  

  @override
  void initState() {
    super.initState();

    selectionTimeSlideController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync:  this,
    )
    ..addListener(() {
      setState(() {});
    });

    countdownTimeFadeController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync:  this,
    )
    ..addListener(() {
      setState(() {});
    });
    countdownTimeFadeController.value = 1.0;
  }

  
  @override
  void dispose() {
    selectionTimeSlideController.dispose();
    countdownTimeFadeController.dispose();

    super.dispose();
  }

  get formattedSelectionTime {
    DateTime dateTime = DateTime(DateTime.now().year, 0, 0,0,0, widget.selectionTime.inSeconds);
    return selectionTimeFormat.format(dateTime);
  }

  get formattedCountdownTime {
    DateTime dateTime = DateTime(DateTime.now().year, 0, 0,0,0, widget.countdownTime.inSeconds);
    return countdownTimeFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {

    if (widget.eggTimerState == EggTimerState.ready) {
      selectionTimeSlideController.reverse();
      countdownTimeFadeController.forward();
    } else {
      selectionTimeSlideController.forward();
      countdownTimeFadeController.reverse();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform(
            transform: Matrix4.translationValues(
              0.0,
              -200.0 * selectionTimeSlideController.value,
              0.0),
            child: Text(
              formattedSelectionTime,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'BebasNeue',
                fontSize: 150.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 10.0,
              ),
            ),
          ),
          Opacity(
            opacity: 1 - countdownTimeFadeController.value,
            child: Text(
              formattedCountdownTime,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'BebasNeue',
                fontSize: 150.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 10.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
