import 'package:flutter/material.dart';

class Drawhorizontalline extends CustomPainter {

  Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
_paint = Paint()
..color = Colors.cyan
..strokeWidth = 2.5
..strokeCap = StrokeCap.round;
}

  @override
  void paint(Canvas canvas, Size size) {
    if(!reverse){
canvas.drawLine(Offset(-180.0, 0.0), Offset(170.0, 0.0), _paint);
    }
    else
{
canvas.drawLine(Offset(-100.0, 0.0), Offset(-10.0, 0.0), _paint);
}
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
}
  
}
class Drawhorizontallinee extends CustomPainter {

  Paint _paint;
  bool reverse;

  Drawhorizontallinee(this.reverse) {
_paint = Paint()
..color = Colors.cyan
..strokeWidth = 1.5
..strokeCap = StrokeCap.round;
}

  @override
  void paint(Canvas canvas, Size size) {
    if(!reverse){
canvas.drawLine(Offset(40.0, 0.0), Offset(120.0, 0.0), _paint);
    }
    else
{
canvas.drawLine(Offset(-100.0, 0.0), Offset(-10.0, 0.0), _paint);
}
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
}
  
}
class Drawhorizontallineee extends CustomPainter {

  Paint _paint;
  bool reverse;

  Drawhorizontallineee(this.reverse) {
_paint = Paint()
..color = Colors.cyan
..strokeWidth = 1.5
..strokeCap = StrokeCap.round;
}

  @override
  void paint(Canvas canvas, Size size) {
    if(!reverse){
canvas.drawLine(Offset(8.0, 0.0), Offset(90.0, 0.0), _paint);
    }
    else
{
canvas.drawLine(Offset(-100.0, 0.0), Offset(-10.0, 0.0), _paint);
}
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
}
  
}
class Drawhorizontalline4 extends CustomPainter {

  Paint _paint;
  bool reverse;

  Drawhorizontalline4(this.reverse) {
_paint = Paint()
..color = Colors.grey[200]
..strokeWidth = 1.5
..strokeCap = StrokeCap.round;
}

  @override
  void paint(Canvas canvas, Size size) {
    if(!reverse){
canvas.drawLine(Offset(-210.0, 0.0), Offset(205.0, 0.0), _paint);
    }
    else
{
canvas.drawLine(Offset(-100.0, 0.0), Offset(-10.0, 0.0), _paint);
}
}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
}
  
}