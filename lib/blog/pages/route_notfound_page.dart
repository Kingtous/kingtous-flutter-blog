import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/common/theme_utils.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RouteNotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor:
          ThemeUtils.isDarkMode(context) ? Colors.white : Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "404 Not Found\n访问的页面不存在~",
          style: GoogleFonts.notoSans(
              textStyle: TextStyle(fontSize: 43.sp, color: Colors.black)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final Object err;

  ErrorPage({this.err = ""});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor:
          ThemeUtils.isDarkMode(context) ? Colors.black : Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Something Error happened emm...",
              style: GoogleFonts.notoSans(
                  textStyle: TextStyle(fontSize: 43.sp, color: ThemeUtils.isDarkMode(context) ? Colors.white : Colors.black)),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h,),
            Card(
              elevation: 4,
              child: Container(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  err.toString(),
                  style: GoogleFonts.notoSans(
                      textStyle: TextStyle(fontSize: 16.sp, color: Colors.redAccent)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor:
          ThemeUtils.isDarkMode(context) ? Colors.black : Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Text(
          "Loading...",
          style: GoogleFonts.notoSans(
              textStyle: TextStyle(fontSize: 43.sp, color: ThemeUtils.isDarkMode(context) ? Colors.white : Colors.black)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}