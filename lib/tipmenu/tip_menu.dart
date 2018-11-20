import 'package:flutter/material.dart';
import 'package:flutter_ui/tipmenu/model.dart';

typedef OnMenuSelected = void Function(IMenu menu);

class TipMenu extends StatefulWidget {
  final Color normalTextColor;
  final Color pressedTextColor;
  final Color normalBackground;
  final Color pressedBackground;
  final Color dividerColor;
  final double textSize;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final double radius;
  final double divideWidth;
  final double dividerHeight;
  final List<IMenu> menus;
  final OnMenuSelected onMenuSelected;

  const TipMenu({
    Key key,
    @required this.menus,
    this.normalTextColor = Colors.white,
    this.pressedTextColor = Colors.white,
    this.normalBackground = const Color(-0x34000000),
    this.pressedBackground = const Color(-0x18888889),
    this.textSize = 14.0,
    this.radius = 8.0,
    this.dividerColor = const Color(-0x65000001),
    this.divideWidth = 0.5,
    this.dividerHeight = 20.0,
    this.paddingLeft = 15.0,
    this.paddingRight = 15.0,
    this.paddingTop = 10.0,
    this.paddingBottom = 10.0,
    this.onMenuSelected,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TipMenuState();
}

class _TipMenuState extends State<TipMenu> {
  BoxDecoration _buildBoxDecoration(int index, Color background) {
    BorderRadius borderRadius = BorderRadius.zero;
    if (index == 0) {
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(widget.radius),
        bottomLeft: Radius.circular(widget.radius),
      );
    } else if (index == widget.menus.length - 1) {
      borderRadius = BorderRadius.only(
        topRight: Radius.circular(widget.radius),
        bottomRight: Radius.circular(widget.radius),
      );
    }
    return BoxDecoration(
      borderRadius: borderRadius,
      color: background,
    );
  }

  BoxDecoration _buildForegroundBoxDecoration(int index, Color background) {
    if (index == widget.menus.length - 1) {
      return BoxDecoration();
    }
    return BoxDecoration(
        border: Border(
            right: BorderSide(
      color: widget.dividerColor,
      width: widget.divideWidth,
    )));
  }

  List<Widget> _buildText() {
    final menus = widget.menus;
    if (menus == null || menus.length == 0) {
      return [Container()];
    }
    List<Widget> widgets = [];
    for (int i = 0; i < menus.length; i++) {
      double rate = 0.8;
      IMenu menu = menus[i];
      Color textColor =
          menu.isPressed ? widget.pressedTextColor : widget.normalTextColor;
      Color bgColor =
          menu.isPressed ? widget.pressedBackground : widget.normalBackground;
      widgets.add(
        GestureDetector(
          child: Container(
            padding: EdgeInsets.fromLTRB(widget.paddingLeft * rate,
                widget.paddingTop * rate, 0.0, widget.paddingBottom * rate),
            child: Container(
              padding: EdgeInsets.fromLTRB(
                widget.paddingLeft * (1 - rate),
                widget.paddingTop * (1 - rate),
                widget.paddingRight,
                widget.paddingBottom * (1 - rate),
              ),
              child: Text(
                menu.getMenuValue(),
                style: TextStyle(fontSize: widget.textSize, color: textColor),
              ),
              foregroundDecoration: _buildForegroundBoxDecoration(i, bgColor),
            ),
            decoration: _buildBoxDecoration(i, bgColor),
          ),
          onTap: () {
            if (widget.onMenuSelected != null) widget.onMenuSelected(menu);
          },
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _buildText(),
    );
  }
}
