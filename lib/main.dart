// ignore_for_file: library_private_types_in_public_api
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:zflutter/zflutter.dart';

import 'icosahedron.dart';

void main() {
  runApp(const Dices());
}

class Dices extends StatefulWidget {
  const Dices({super.key});

  @override
  _DicesState createState() => _DicesState();
}

class _DicesState extends State<Dices> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late SpringSimulation simulation;
  int num = 1;
  int num2 = 1;
  ZVector rotation = ZVector.zero;
  double zRotation = 0;

  @override
  void initState() {
    super.initState();

    simulation = SpringSimulation(
      const SpringDescription(
        mass: 1,
        stiffness: 20,
        damping: 2,
      ),
      1, // starting point
      0, // ending point
      1, // velocity
    );

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {
        // rotation = rotation + ZVector.all(0.1);
        setState(() {});
      });
  }

  void random() {
    zRotation = Random().nextDouble() * tau;
    num = Random().nextInt(20) + 1;
    num2 = 20 - Random().nextInt(20);
  }

  @override
  Widget build(BuildContext context) {
    final curvedValue = CurvedAnimation(
      curve: Curves.ease,
      parent: animationController,
    );
    final firstHalf = CurvedAnimation(
      curve: const Interval(0, 1),
      parent: animationController,
    );
    final secondHalf = CurvedAnimation(
      curve: const Interval(0, 0.3),
      parent: animationController,
    );

    // Adds simulated movement when used as scalefactor for translate and scale below
    final zoom = (simulation.x(animationController.value)).abs() / 2 + 0.5;

    return GestureDetector(
      onTap: () {
        if (animationController.isAnimating) {
          animationController.reset();
        } else {
          animationController.forward(from: 0);
          random();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: ZIllustration(
          zoom: 1,
          children: [
            ZPositioned(
              translate: ZVector.only(x: 130 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(61.5 * (zoom * 2)),
                    rotate:
                        getRotation(num2).multiplyScalar(curvedValue.value) -
                            ZVector.all((tau / 2) * (firstHalf.value)) -
                            ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(
                            z: -zRotation * 1.9 * (animationController.value)),
                        child: const Icosahedron()),
                  ),
                ],
              ),
            ),
            ZPositioned(
              translate: ZVector.only(x: -130 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(61.5 * (zoom * 2)),
                    rotate: getRotation(num).multiplyScalar(curvedValue.value) -
                        ZVector.all((tau / 2) * (firstHalf.value)) -
                        ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(
                            z: -zRotation * 2.1 * (animationController.value)),
                        child: const Icosahedron()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

//Set the dice to correct face on ending
// tau here is basically 360 degrees but as rad
// Also these are best guesses and may not be exactly
ZVector getRotation(int num) {
  // developer.log('$num', name: 'my.dice.roll');
  switch (num) {
    case 1:
      return const ZVector.only(x: 4 * tau / 6);
    case 2:
      return ZVector.zero; // Always correct
    case 3:
      return const ZVector.only(x: tau / 2, y: tau / 10);
    case 4:
      return const ZVector.only(y: 2 * tau / 10);
    case 5:
      return const ZVector.only(x: -tau / 6, y: tau / 10);
    case 6:
      return const ZVector.only(x: 2 * tau / 6, y: -tau / 10);
    case 7:
      return const ZVector.only(x: -tau / 6, y: -3 * tau / 10);
    case 8:
      return const ZVector.only(x: 2 * tau / 6, y: 3 * tau / 10);
    case 9:
      return const ZVector.only(x: tau / 2, y: -tau / 10);
    case 10:
      return const ZVector.only(y: -2 * tau / 10); //seems correct
    case 11:
      return const ZVector.only(x: tau / 2, y: -2 * tau / 10);
    case 12:
      return const ZVector.only(y: -tau / 10); //seems correct
    case 13:
      return const ZVector.only(x: -tau / 6, y: 3 * tau / 10);
    case 14:
      return const ZVector.only(x: 2 * tau / 6, y: -3 * tau / 10);
    case 15:
      return const ZVector.only(x: -tau / 6, y: -tau / 10);
    case 16:
      return const ZVector.only(x: 2 * tau / 6, y: tau / 10);
    case 17:
      return const ZVector.only(x: tau / 2, y: 2 * tau / 10);
    case 18:
      return const ZVector.only(y: tau / 10); //seems correct
    case 19:
      return const ZVector.only(y: tau / 2);
    case 20:
      return const ZVector.only(x: tau / 6);
  }
  throw ('num $num is not in the dice');
}
