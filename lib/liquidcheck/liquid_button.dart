import 'package:flutter/material.dart';
import 'package:flutter_ui/liquidcheck/liquid_check_painter.dart';

class LiquidButton extends StatefulWidget {
  final Size size;
  final double progress;
  final VoidCallback onDownLoadStart;
  final VoidCallback onDownLoadEnd;

  const LiquidButton({
    Key key,
    @required this.progress,
    this.onDownLoadStart,
    this.onDownLoadEnd,
    @required this.size,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LiquidButtonState();
}

class LiquidButtonState extends State<LiquidButton>
    with TickerProviderStateMixin {
  PainterStatus paintStatus = PainterStatus.download;
  AnimationController _controller;
  AnimationController _controllerStart;
  AnimationController _controllerEnd;
  Animation<double> _finishScale;
  Animation<double> _finishBubbles;
  Animation<double> _wave;
  Animation<double> _download;

  @override
  void initState() {
    super.initState();
    _initDownload();
    _initWave();
    _initFinishAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerStart.dispose();
    _controllerEnd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (paintStatus == PainterStatus.wave) _controller.value = widget.progress;

    return GestureDetector(
      onTap: () {
        _onTap();
      },
      child: Transform.scale(
        scale: paintStatus == PainterStatus.download
            ? _download.value
            : (paintStatus == PainterStatus.tick ? _finishScale.value : 1.0),
        child: CustomPaint(
          size: widget.size,
          painter: WavePainter(
            painterStatus: paintStatus,
            waveProgress: _wave.value,
            finishBubblesProgress: _finishBubbles.value,
          ),
        ),
      ),
    );
  }

  void resetStatus() {
    paintStatus = PainterStatus.download;
    _controllerStart.reset();
    setState(() {});
  }

  void _onTap() {
    if (_controllerStart.isAnimating ||
        _controller.isAnimating ||
        _controllerEnd.isAnimating) {
      return;
    }
    if (paintStatus == PainterStatus.download) {
      _controllerStart.reset();
      _controllerStart.forward();
    }
  }

  void _initDownload() {
    _controllerStart = new AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        duration: Duration(milliseconds: 250),
        vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.onDownLoadStart != null) widget.onDownLoadStart();
          paintStatus = PainterStatus.wave;
          _controller.reset();
          _controller.forward();
        }
      });
    _download = new Tween<double>(
      begin: 0.8,
      end: 0.0,
    ).animate(
      new CurvedAnimation(
        parent: _controllerStart,
        curve: Curves.linear,
      ),
    );
  }

  void _initWave() {
    _controller = new AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          paintStatus = PainterStatus.tick;
          _controllerEnd.reset();
          _controllerEnd.forward();
        }
      });
    _wave = new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  void _initFinishAnimation() {
    _controllerEnd = new AnimationController(
        animationBehavior: AnimationBehavior.preserve,
        duration: Duration(milliseconds: 500),
        vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.onDownLoadEnd != null) widget.onDownLoadEnd();
        }
      });
    _finishBubbles = new Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      new CurvedAnimation(
        parent: _controllerEnd,
        curve: Curves.linear,
      ),
    );
    _finishScale = new Tween<double>(
      begin: 1.1,
      end: 0.8,
    ).animate(
      new CurvedAnimation(
        parent: _controllerEnd,
        curve: Curves.bounceOut,
      ),
    );
  }
}
