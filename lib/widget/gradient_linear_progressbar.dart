import 'package:flutter/material.dart';

class GradientLinearProgressBar extends StatelessWidget {

  final bool strokeCapRound;//是否需要圆角
  final double strokeWidth;//画笔的宽度，其实是进度条的高度
  final double value;//进度值
  final Color backgroundColor;//进度条背景色
  final List<Color>? colors;//渐变的颜色列表

  GradientLinearProgressBar({
    this.strokeCapRound = false,
    this.strokeWidth = 2.0,
    this.value = 0,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: _GradientLinearProgressPainter(
          strokeWidth: strokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          colors: _colors
      ),
    );
  }
}

class _GradientLinearProgressPainter extends CustomPainter{

  final double strokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;

  final List<double>? stops;
  final p = Paint();

  _GradientLinearProgressPainter({
    this.strokeWidth = 2.0,
    required this.colors,
    this.value = 0.0,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.strokeCapRound = false,
    this.stops
  });

  @override
  void paint(Canvas canvas, Size size) {
    p.strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt;
    p.style = PaintingStyle.fill;
    p.isAntiAlias = true;
    p.strokeWidth = strokeWidth;

    double _offset = strokeWidth / 2;//留一定的偏移量
    var start = Offset(_offset, _offset);//画笔起点坐标
    var end = Offset(size.width, _offset);//画笔终点坐标

    // 画背景
    if (backgroundColor != Colors.transparent) {
      p.color = backgroundColor;
      canvas.drawLine(start, end, p);
    }

    // 画进度条
    if (value > 0) {
      var valueEnd = Offset(value * size.width + _offset, _offset);//计算进度的长度
      Rect rect = Rect.fromPoints(start, valueEnd);
      p.shader = LinearGradient(colors: colors, stops: stops).createShader(rect);
      // p.color = Colors.amber;
      canvas.drawLine(start, valueEnd, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => oldDelegate !=this;

}