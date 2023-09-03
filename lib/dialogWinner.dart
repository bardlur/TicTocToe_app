import 'package:flutter/material.dart';

class CongratulationsDialogO extends StatefulWidget {
  final VoidCallback onPressed;

  CongratulationsDialogO({required this.onPressed});

  @override
  _CongratulationsDialogOState createState() => _CongratulationsDialogOState();
}

class _CongratulationsDialogOState extends State<CongratulationsDialogO>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: _animation.value,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              title: Text(
                '!تبریک', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              content: Text(
                'برنده شد O بازیکن',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      'تایید',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      widget.onPressed(); 
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CongratulationsDialogX extends StatefulWidget {
  final VoidCallback onPressed;

  CongratulationsDialogX({required this.onPressed});

  @override
  _CongratulationsDialogXState createState() => _CongratulationsDialogXState();
}

class _CongratulationsDialogXState extends State<CongratulationsDialogX>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: _animation.value,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              title: Text(
                '!تبریک', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              content: Text(
                'برنده شد X بازیکن',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      'تایید',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      widget.onPressed(); 
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CongratulationsDialogEqual extends StatefulWidget {
  final VoidCallback onPressed;

  CongratulationsDialogEqual({required this.onPressed});

  @override
  _CongratulationsDialogEqualState createState() => _CongratulationsDialogEqualState();
}

class _CongratulationsDialogEqualState extends State<CongratulationsDialogEqual>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: _animation.value,
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              content: Text(
                '!بازی مساوی شد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              actions: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text(
                      'تایید',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      widget.onPressed(); 
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}