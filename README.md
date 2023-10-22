# zflutter shapetest - icosahedron and also cube dice

This is a port of a codepen for Zdog - https://codepen.io/tomesparon/pen/GRzRNea?editors=0010

In this, the aim was to just get a working icosahedral dice. There may be ways to improve and make code more DRY but still learning how to use flutter so will have to do for now.

## Getting Started

All the code for icosahedron is in main.dart file so run as with any other flutter project. There is also the cube - which can be ran with a few tweaks to uncomment main method / move into main.dart.

For Flutter 3, we need to use the updated version of zflutter package which is not on pub.dev so use this below in pubspec:
```
  zflutter:
    git:
      url: https://github.com/CarGuo/zflutter.git
      path: zflutter/
```

flutter run
