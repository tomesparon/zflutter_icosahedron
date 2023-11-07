import 'package:flutter/material.dart';
import 'package:zflutter/zflutter.dart';

// void main() {
//   runApp(const MyApp());
// }

class Number extends StatelessWidget {
  const Number({Key? key, required this.numb}) : super(key: key);
  final String? numb;

  @override
  Widget build(BuildContext context) {
    return ZToBoxAdapter(
      height: 20,
      width: 10,
      child: Text(
        '$numb',
        textDirection: TextDirection.ltr,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class Face extends StatelessWidget {
  final double zoom;
  final Color color;

  const Face({Key? key, this.zoom = 1, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZRect(
      stroke: 2 * zoom,
      width: 50,
      height: 50,
      color: color,
      fill: true,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ZDragDetector(
      builder: (context, controller) {
        return ZIllustration(
          zoom: 3,
          children: [
            ZPositioned(
              rotate: controller.rotate,
              child: ZGroup(
                sortMode: SortMode.inherit,
                children: const <Widget>[
                  ZPositioned(
                      translate: ZVector.only(z: 25), // FRONT
                      child: Face(
                          zoom: 1, color: Color.fromARGB(248, 14, 45, 216))),
                  ZPositioned(
                      translate: ZVector.only(z: 26), // FRONT NUMBER
                      child: Number(numb: "3")),
                  ZPositioned(
                      translate: ZVector.only(z: -25), //BACK
                      child: Face(
                          zoom: 1, color: Color.fromARGB(255, 218, 16, 16))),
                  ZPositioned(
                      translate: ZVector.only(z: -26), // BACK NUMBER
                      rotate: ZVector.only(y: tau / 2),
                      child: Number(numb: "4")),
                  ZPositioned(
                      translate: ZVector.only(y: 25), // BOTTOM
                      rotate: ZVector.only(x: tau / 4),
                      child: Face(
                          zoom: 1, color: Color.fromARGB(255, 1, 255, 98))),
                  ZPositioned(
                      translate: ZVector.only(y: 26), // BOTTOM NUMBER
                      rotate: ZVector.only(x: tau / -4),
                      child: Number(numb: "2")),
                  ZPositioned(
                      translate: ZVector.only(y: -25),
                      rotate: ZVector.only(x: tau / 4), // TOP
                      child: Face(
                          zoom: 1, color: Color.fromARGB(255, 200, 255, 0))),
                  ZPositioned(
                      translate: ZVector.only(y: -26),
                      rotate: ZVector.only(x: tau / 4), // TOP NUMBER
                      child: Number(numb: "5")),
                  ZPositioned(
                      translate: ZVector.only(x: 25),
                      rotate: ZVector.only(y: tau / 4), //RIGHT SIdE
                      child: Face(
                          zoom: 1, color: Color.fromARGB(255, 217, 10, 224))),
                  ZPositioned(
                      translate: ZVector.only(x: 26), //Right side number
                      rotate: ZVector.only(
                          y: tau / -4), //right  SIde 5 flip tau neg
                      child: Number(numb: "6")),
                  ZPositioned(
                      translate: ZVector.only(x: -25),
                      rotate: ZVector.only(y: tau / 4), //left SIde
                      child: Face(
                          zoom: 1, color: Color.fromARGB(255, 217, 10, 224))),
                  ZPositioned(
                      translate: ZVector.only(x: -26),
                      rotate: ZVector.only(y: tau / 4), //left SIde Number
                      child: Number(numb: "1")),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
