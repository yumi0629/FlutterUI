import 'package:flutter/material.dart';
import 'package:flutter_ui/circlefloatingmenu/circle_floating_menu.dart';
import 'package:flutter_ui/circlefloatingmenu/floating_button.dart';

class FloatingMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CircleFloatingMenu'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CircleFloatingMenu(
              startAngle: degToRad(-90.0),
              endAngle: degToRad(90.0),
              floatingButton: FloatingButton(
                icon: Icons.add,
                size: 30.0,
                color: Colors.redAccent,
              ),
              subMenus: <Widget>[
                FloatingButton(
                  icon: Icons.widgets,
                ),
                FloatingButton(
                  icon: Icons.book,
                ),
                FloatingButton(
                  icon: Icons.translate,
                ),
                FloatingButton(
                  icon: Icons.alarm_add,
                ),
                FloatingButton(
                  icon: Icons.bluetooth,
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Center(
              child: CircleFloatingMenu(
                floatingButton: FloatingButton(
                  color: Colors.green,
                  icon: Icons.add,
                  size: 30.0,
                ),
                subMenus: <Widget>[
                  FloatingButton(
                    icon: Icons.widgets,
                    elevation: 0.0,
                  ),
                  FloatingButton(
                    icon: Icons.translate,
                    elevation: 0.0,
                  ),
                  FloatingButton(
                    icon: Icons.alarm_add,
                    elevation: 0.0,
                  ),
                  FloatingButton(
                    icon: Icons.bluetooth,
                    elevation: 0.0,
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
