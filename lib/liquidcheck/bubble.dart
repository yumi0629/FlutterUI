import 'dart:math';
import 'dart:ui';
import 'base_provider.dart' show Point;

// Bezier Curve B(t)=(1-t)^2*P0+2t(1-t)*P1+t^2P2
double doBezier(
    double time, double timeLeft, double start, double control, double end) {
  return timeLeft * timeLeft * start +
      2.0 * time * timeLeft * control +
      time * time * end;
}

class Bubble {
  Point start, end, control, current;
  int alpha;
  double radius;
  int duration;

  Bubble._({
    this.start,
    this.end,
    this.control,
    this.current,
    this.alpha,
    this.radius,
    this.duration,
  });

  Bubble.generate(BubbleGenerator generator) {
    this.start = generator.start;
    this.control = generator.control;
    this.end = generator.end;
    this.radius = generator.radius;
    this.duration = generator.duration;
    current = start;
    alpha = 255;
  }

  void evaluate(double interpolatedTime) {
    double timeLeft = 1.0 - interpolatedTime;
    alpha = ((1.0 - interpolatedTime) * 255).round();
    current = Point(
        doBezier(interpolatedTime, timeLeft, start.x, control.x, end.x),
        doBezier(interpolatedTime, timeLeft, start.y, control.y, end.y));
  }

  void draw(Canvas canvas, Paint paint, double progress) {
    evaluate(progress);
    var color = paint.color.withAlpha(alpha);
    paint..color = color;
    canvas.drawCircle(Offset(current.x, current.y), radius, paint);
  }
}

class BubbleGenerator {
  Random random;
  Point start = Point(0.0, 0.0),
      end = Point(0.0, 0.0),
      control = Point(0.0, 0.0);
  double radius;
  int duration;

  BubbleGenerator(double startX, double startY) {
    random = new Random();
    this.start = new Point(startX, startY);
  }

  void generateBubbleX(double origin, double range, double offset) {
    int side = random.nextInt(32);
    double dx;
    //generate bubbles
    if (side % 2 == 0) {
      dx = origin - (random.nextDouble() * range) - offset;
    } else {
      dx = origin + (random.nextDouble() * range) + offset;
    }
    this.control.x = dx;
    this.end.x = control.x + (control.x - start.x) * random.nextDouble();
  }

  void generateBubbleY(double origin, double range) {
    this.control.y = origin - range * (random.nextDouble() + 0.2);
    this.end.y = origin - (0.5 * (start.y - control.y));
  }

  void generateRadius(double range) {
    this.radius = nextInt(3, range.round()).toDouble();
  }

  void generateDuration(int min, int range) {
    this.duration = random.nextInt(range) + min;
  }

  int nextInt(int min, int max) => min + random.nextInt((max - min).abs());
}
