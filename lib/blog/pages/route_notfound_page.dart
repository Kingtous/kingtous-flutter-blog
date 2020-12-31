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
      backgroundColor: ThemeUtils.isDarkMode(context) ? Colors.white : Colors.black,
      body: Container(
        alignment: Alignment.center,
        child: Text("404 Not Found\n访问的页面不存在~",style: GoogleFonts.notoSans(textStyle: TextStyle(
          fontSize: 43.sp
        )),textAlign: TextAlign.center,),
      ),
    );
  }
}
