import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/circlefloatingmenu/circle_floating_menu_page.dart';
import 'package:flutter_ui/circleprogressbar/progress_bar_page.dart';
import 'package:flutter_ui/draglike/drag_like.dart';
import 'package:flutter_ui/home_page.dart';
import 'package:flutter_ui/likebutton/like_button_page.dart';
import 'package:flutter_ui/liquidcheck/liquid_check_page.dart';
import 'package:flutter_ui/route.dart';
import 'package:flutter_ui/scrawl/content_page.dart';
import 'package:flutter_ui/sharedelement/shared_element_shop.dart';
import 'package:flutter_ui/slidedrawer/slide_drawer_page.dart';
import 'package:flutter_ui/sliver/sliver_menu.dart';
import 'package:flutter_ui/tipmenu/tip_menu_page.dart';
import 'package:flutter_ui/verificationcode/Verification_code_paget.dart';
import 'package:flutter_ui/webview/webview.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return OKToast(
        textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
        backgroundColor: Colors.grey..withAlpha(200),
        radius: 8.0,
        child: MaterialApp(
          title: 'Flutter YMUI',
          theme: ThemeData(
            primarySwatch: Colors.pink,
          ),
          home: MyHomePage(title: 'Flutter YMUI'),
          localizationsDelegates: [
            //此处
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            //此处
            const Locale('zh', 'CH'),
            const Locale('en', 'US'),
          ],
          routes: {
            UIRoute.webView: (_) => WebViewPage(),
            UIRoute.slideDrawer: (_) => SlideDrawerPage(),
//        UIRoute.sharedElement: (_) => SharedElementPage(),
            UIRoute.sharedElement: (_) => ShopPage(),
            UIRoute.sliver: (_) => SliverPage(),
            UIRoute.dragLike: (_) => DragLikePage(),
            UIRoute.circleProgressBar: (_) => ProgressBarPage(),
            UIRoute.likeButton: (_) => LikeButtonPage(),
            UIRoute.tipMenu: (_) => TipMenuPage(),
            UIRoute.scrawl: (_) => ContentPage(),
            UIRoute.circleFloatingMenu: (_) => FloatingMenuPage(),
            UIRoute.liquidCheck: (_) => LiquidCheckPage(),
            UIRoute.verificationCode: (_) => VerificationCodePage(),
          },
        ));
  }
}
