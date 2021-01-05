import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/common/theme.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeUtils {
  /// 是否是黑暗模式
  static bool isDarkMode(BuildContext context) {
    return ThemeProvider.themeOf(context).id == "dark";
  }

  static bool systemIsDarkMode() {
    return SchedulerBinding.instance.window.platformBrightness == Brightness.dark;
  }

  static AppTheme getAppLightTheme() {
    return AppTheme(
      data: ThemeData(
          brightness: Brightness.light,
          textTheme: GoogleFonts.notoSansTextTheme()),
      id: "light",
      description: "Android Default Light Theme",
    );
  }

  static AppTheme getAppDarkTheme() {
    return AppTheme(
      data: myTheme,
      id: "dark",
      description: "Android Default Light Theme",
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.h,
        decoration: BoxDecoration(
            color:
                ThemeUtils.isDarkMode(context) ? Colors.white : Colors.black),
      ),
    );
  }
}

/// 统一Card类型
class KCard extends StatefulWidget {
  final Widget child;

  KCard({this.child});

  @override
  State<StatefulWidget> createState() => _KCardState();
}

class _KCardState extends State<KCard> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // print("init kcard state");
    _controller = AnimationController(
      value: 16,
        lowerBound: 8,
        upperBound: 16,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
        vsync: this);
    // _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return MouseRegion(
          onEnter: (e) {
            // print("mouse entered");
            setState(() {
              _controller.reverse(from: _controller.value);
            });
          },
          onExit: (e) {
            // print("mouse exit");
            setState(() {
              _controller.forward();
            });
          },
          child: Container(
            margin: EdgeInsets.all(_controller.value),
            child: Card(
              elevation: 10,
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: this.widget.child,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
