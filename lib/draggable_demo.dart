import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:zflutter/zflutter.dart';
import 'constants.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ZDragDetector(
      builder: (context, controller) {
        return ZIllustration(
          zoom: 100,
          children: [
            ZPositioned(
              rotate: controller.rotate,
              child: ZGroup(
                children: const <Widget>[
                  // ZPositioned(
                  //     // rotate: ZVector.only(x: tau / 4),
                  //     child: ZPolygon(
                  //   stroke: 0.1,
                  //   sides: 6,
                  //   radius: 1,
                  //   color: Color.fromARGB(255, 90, 90, 90),
                  // )),
                  Icosahedron(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class Icosahedron extends StatelessWidget {
  const Icosahedron({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZGroup(sortMode: SortMode.inherit, children: <Widget>[
      ZPositioned(
          translate: ZVector.only(z: capApothem),
          child: ZGroup(children: const <Widget>[
            CapFace(
              iteration: 0,
              color: Color.fromARGB(255, 255, 3, 3),
              number: "1",
            ),
            CapFace(
              iteration: 1,
              color: Color.fromARGB(255, 8, 8, 255),
              number: "7",
            ),
            CapFace(
              iteration: 2,
              color: Color.fromARGB(255, 3, 219, 100),
              number: "15",
            ),
            CapFace(
              iteration: 3,
              color: Color.fromARGB(255, 208, 215, 4),
              number: "5",
            ),
            CapFace(
              iteration: 4,
              color: Color.fromARGB(255, 140, 2, 232),
              number: "13",
            ),
          ])),
      ZPositioned(
          translate: ZVector.only(z: capApothem),
          child: ZGroup(children: const <Widget>[
            SideFace(
              iteration: 0,
              color: Color.fromARGB(255, 255, 3, 3),
              number: "19",
            ),
            SideFace(
              iteration: 1,
              color: Color.fromARGB(255, 8, 8, 255),
              number: "17",
            ),
            SideFace(
              iteration: 2,
              color: Color.fromARGB(255, 3, 219, 100),
              number: "12",
            ),
            SideFace(
              iteration: 3,
              color: Color.fromARGB(255, 208, 215, 4),
              number: "18",
            ),
            SideFace(
              iteration: 4,
              color: Color.fromARGB(255, 140, 2, 232),
              number: "11",
            ),
          ])),
      ZPositioned(
          translate: ZVector.only(z: capApothem * -1),
          rotate: ZVector.only(x: tau / 2),
          child: ZGroup(children: const <Widget>[
            SideFace(
              iteration: 0,
              color: Color.fromARGB(255, 255, 3, 3),
              number: "2",
            ),
            SideFace(
              iteration: 1,
              color: Color.fromARGB(255, 8, 8, 255),
              number: "10",
            ),
            SideFace(
              iteration: 2,
              color: Color.fromARGB(255, 3, 219, 100),
              number: "3",
            ),
            SideFace(
              iteration: 3,
              color: Color.fromARGB(255, 208, 215, 4),
              number: "9",
            ),
            SideFace(
              iteration: 4,
              color: Color.fromARGB(255, 140, 2, 232),
              number: "4",
            ),
          ])),
      ZPositioned(
          // BOTTOM
          translate: ZVector.only(z: -capApothem),
          rotate: ZVector.only(x: tau / 2),
          child: ZGroup(children: const <Widget>[
            CapFace(
              iteration: 0,
              color: Color.fromARGB(255, 255, 3, 3),
              number: "20",
            ),
            CapFace(
              iteration: 1,
              color: Color.fromARGB(255, 8, 8, 255),
              number: "8",
            ),
            CapFace(
              iteration: 2,
              color: Color.fromARGB(255, 3, 219, 100),
              number: "16",
            ),
            CapFace(
              iteration: 3,
              color: Color.fromARGB(255, 208, 215, 4),
              number: "6",
            ),
            CapFace(
              iteration: 4,
              color: Color.fromARGB(255, 140, 2, 232),
              number: "14",
            ),
          ])),
    ]);
  }
}

class SideFace extends StatelessWidget {
  final int iteration;
  final Color color;
  final String number;
  const SideFace({
    Key? key,
    required this.iteration,
    required this.color,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: ZVector.only(y: (tau / 5) * -iteration),
      translate: ZVector.only(y: sideHeight / 2 * -1, z: capApothem * -1),
      child: ZGroup(
        children: <Widget>[
          ZPositioned(
            //MAIN DIFFERENCE TO CAPS
            rotate: ZVector.only(x: -sideTilt),
            translate: ZVector.only(z: capApothem * -1 /*, y: faceRadius / 2*/),
            child: ZGroup(
              children: <Widget>[
                ZPositioned(
                    //Other DIFFERENCE TO CAPS
                    rotate: const ZVector.only(x: tau / 2),
                    translate: ZVector.only(
                        y: faceRadius /
                            2.0), // not really sure but fR needs to be + not -ve
                    child: Face(color: color)),
                ZPositioned(
                    // rotate: const ZVector.only(z: 0.1), //for wobble
                    translate: ZVector.only(y: faceRadius / 2),
                    child: Number(numb: number)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CapFace extends StatelessWidget {
  final int iteration;
  final String number;
  final Color color;
  const CapFace(
      {Key? key,
      required this.iteration,
      required this.color,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPositioned(
      rotate: ZVector.only(y: (tau / 5) * -iteration),
      translate: ZVector.only(y: sideHeight / 2 * -1, z: capApothem * -1),
      child: ZGroup(
        children: <Widget>[
          ZPositioned(
            rotate: ZVector.only(x: -capTilt),
            translate: ZVector.only(z: capApothem * -1),
            child: ZGroup(
              sortMode: SortMode.stack, // stops render flicker
              children: <Widget>[
                ZPositioned(
                    translate: ZVector.only(y: -faceRadius / 2),
                    child: Face(color: color)),
                // ZPositioned(
                //     translate: ZVector.only(y: -faceRadius / 2),
                //     child: ZShape(
                //       path: [
                //         ZMove.only(x: -0.4),
                //         ZLine.only(x: 0.4),
                //       ],
                //       closed: false,
                //       stroke: 0.1,
                //       color: Color.fromARGB(255, 194, 50, 194),
                //     ))
                ZPositioned(
                    translate: ZVector.only(y: -faceRadius / 2),
                    // rotate: ZVector.only(z: 0.1),//only to introduce wobble
                    child: Number(numb: number)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Face extends StatelessWidget {
  final Color color;

  const Face({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZPolygon(
      stroke: 0.0,
      sides: 3,
      radius: faceRadius,
      color: color,
      fill: true,
    );
  }
}

class Number extends StatelessWidget {
  const Number({Key? key, required this.numb}) : super(key: key);
  final String? numb;

  @override
  Widget build(BuildContext context) {
    return ZToBoxAdapter(
      height: 0.3,
      width: 0.34,
      child: Container(
        // color: Color.fromARGB(125, 246, 246, 246),
        child: Image.asset(
          'assets/$numb.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
