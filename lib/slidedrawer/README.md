# flutter_slide_drawer

A slide menu widget like QQ.

[Flutter：手把手教你实现一个仿QQ侧滑菜单的功能](https://www.jianshu.com/p/8ef323cb2726)

The drawer can open from left,right,top or bottom. You can use ```slideDirection: SlideDirection.top,``` to control the direction. Use ```_slideKey.currentState.openOrClose();```to open or close drawer freely.

Usage:
```
SlideStack(
      child: SlideContainer(
        key: _slideKey,
        child: Container(
         /// widget mian.
        ),
        slideDirection: SlideDirection.top,
        onSlide: onSlide,
        drawerSize: maxSlideDistance,
      ),
      drawer: Container(
        /// widget drawer.
      ),
    );
```



from left  
![from left](https://gitee.com/yumi0629/ImageAsset/raw/master/slide_drawer/slide01.gif)

![from left](https://gitee.com/yumi0629/ImageAsset/raw/master/slide_drawer/slide02.gif)

from top  
![from top](https://gitee.com/yumi0629/ImageAsset/raw/master/slide_drawer/slide03.gif)