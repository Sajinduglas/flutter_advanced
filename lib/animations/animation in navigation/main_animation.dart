import 'package:flutter/material.dart';
import 'package:flutter_advanced/animations/animation%20in%20navigation/second%20page%20_animation.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(MaterialApp(
    home: Main_animation(),
  ));
}

class Main_animation extends StatelessWidget {
  const Main_animation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondary_animation) {
                            return Second_page();
                          },
                          transitionsBuilder:
                              (context, animation, animation2, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration:
                              const Duration(milliseconds: 1000)));
                },
                child: Text("Fade animation")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return Second_page();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: const Offset(0.0, 0.0),
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ));
                },
                child: Text("slide animation")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondary_animation) {
                            return Second_page();
                          },
                          transitionsBuilder:
                              (context, animation, animation2, child) {
                            return ScaleTransition(
                              // opacity: animation,
                              scale: animation,
                              child: child,
                            );
                          },
                          transitionDuration:
                              const Duration(milliseconds: 1000)));
                },
                child: Text("scale animation")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: Duration(seconds: 1),
                          childCurrent: this,
                          child: Second_page(),
                          type: PageTransitionType.topToBottomPop));
                },
                child: Text("Using package"))
          ],
        ),
      ),
    );
  }
}
