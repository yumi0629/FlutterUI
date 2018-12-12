import 'package:flutter/material.dart';
import 'dart:math';

typedef MenuToggled<state> = void Function(MenuState state);
typedef MenuSelected<index> = void Function(int index);

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);

enum MenuState {
  OPEN,
  CLOSE,
}

class CircleFloatingMenu extends StatefulWidget {
  final Widget floatingButton;
  final List<Widget> subMenus;
  final double startAngle;
  final double endAngle;
  final Duration duration;
  final MenuToggled menuToggled;
  final MenuSelected menuSelected;

  const CircleFloatingMenu({
    Key key,
    @required this.floatingButton,
    @required this.subMenus,
    this.startAngle = 180 * (pi / 180.0),
    this.endAngle = 270 * (pi / 180.0),
    this.duration = const Duration(milliseconds: 400),
    this.menuToggled,
    this.menuSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CircleFloatingState();
}

class CircleFloatingState extends State<CircleFloatingMenu>
    with TickerProviderStateMixin {
  final double translateLength = 100.0;
  MenuState _menuState = MenuState.CLOSE;
  AnimationController _controller;
  Map<String, Animation<double>> animations;

  @override
  void initState() {
    _controller =
        new AnimationController(duration: widget.duration, vsync: this)
          ..addListener(() {
            setState(() {});
          });
    _initAnimations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < widget.subMenus.length; i++) {
      Widget sub = Transform.scale(
        scale: animations["scale"].value,
        child: Transform.translate(
          offset: _getOffset(i),
          child: Transform.rotate(
            angle: degToRad(animations["rotate"].value * 360.0),
            child: GestureDetector(
              child: widget.subMenus[i],
              onTap: () {
                print('onTap');
                if (widget.menuSelected != null) widget.menuSelected(i);
                toggleMenu();
              },
              onPanStart: (_) {
                print('onPanStart');
              },
            ),
          ),
        ),
      );
      widgets.add(sub);
    }
    widgets.add(
      GestureDetector(
        child: widget.floatingButton,
        onTap: toggleMenu,
      ),
    );
    return Stack(
      alignment: AlignmentDirectional.center,
      children: widgets,
    );
  }

  void toggleMenu() {
    if (_controller.isAnimating) return;
    if (_menuState == MenuState.OPEN) {
      _controller.animateTo(0.0);
      _menuState = MenuState.CLOSE;
    } else if (_menuState == MenuState.CLOSE) {
      _controller.forward();
      _menuState = MenuState.OPEN;
    }
    if (widget.menuToggled != null) widget.menuToggled(_menuState);
  }

  void _initAnimations() {
    animations = {
      'scale': _generateScaleAnimation(),
      'rotate': _generateRotateAnimation(),
      'translate': _generateTranslateAnimation(),
    };
  }

  Offset _getOffset(int index) {
    if (widget.subMenus.length == 0) return Offset(0.0, 0.0);
    if (widget.subMenus.length == 1)
      return Offset(cos(widget.startAngle) * translateLength,
          sin(widget.startAngle) * translateLength);
    double curAngle = (widget.endAngle - widget.startAngle) /
            (widget.subMenus.length - 1) *
            index +
        widget.startAngle;
    return Offset(
        cos(curAngle) * translateLength, sin(curAngle) * translateLength);
  }

  Animation<double> _generateScaleAnimation() {
    return new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: new Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  Animation<double> _generateRotateAnimation() {
    return new Tween<double>(begin: 0.6, end: 1.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: new Interval(
          0.0,
          1.0,
          curve: Curves.linear,
        ),
      ),
    );
  }

  Animation<double> _generateTranslateAnimation() {
    return new Tween<double>(begin: 0.0, end: 1.0).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: new Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }
}
