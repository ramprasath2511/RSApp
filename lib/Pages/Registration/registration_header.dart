import 'package:flutter/material.dart';

class RegistrationHeader extends StatefulWidget {
  final double _height;

  const RegistrationHeader(this._height, {Key? key}) : super(key: key);

  @override
  _RegistrationHeaderState createState() => _RegistrationHeaderState(_height);
}

class _RegistrationHeaderState extends State<RegistrationHeader> {
  double _height;

  _RegistrationHeaderState(this._height);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).accentColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: new ShapeClipper(
                [
                  Offset(width / 5, _height),
                  Offset(width / 10 * 5, _height - 60),
                  Offset(width / 5 * 4, _height + 20),
                  Offset(width, _height - 18)
                ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).accentColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: new ShapeClipper(
                [
                  Offset(width / 3, _height + 20),
                  Offset(width / 10 * 8, _height - 60),
                  Offset(width / 5 * 4, _height - 60),
                  Offset(width, _height - 20)
                ]
            ),
          ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                ),
              ),
            ),
            clipper: new ShapeClipper(
                [
                  Offset(width / 5, _height),
                  Offset(width / 2, _height - 40),
                  Offset(width / 5 * 4, _height - 80),
                  Offset(width, _height - 20)
                ]
            ),
          ),

        ],
      ),
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height-20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(_offsets[0].dx, _offsets[0].dy, _offsets[1].dx,_offsets[1].dy);
    path.quadraticBezierTo(_offsets[2].dx, _offsets[2].dy, _offsets[3].dx,_offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();


    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}