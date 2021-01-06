import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/blog/detail/blog_ui_util.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kingtous_blog/common/service_register.dart';
import 'package:kingtous_blog/common/theme_utils.dart';
import 'package:theme_provider/theme_provider.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends BaseFramePageState<AboutMePage> {

  final String _avatarUrl = "https://file.kingtous.cn/index.php?user/publicLink&fid=36c2lN0jcZr_2TmHGrxwqQr02MsE0fvEEdsb8GgFDbixPCmUtA1k-udv8bx3Ux69qUUzpmqXZrXH0odiKHVVJEKPdr7Q_guLBefoTYLNB5XSRkHq&file_name=/myavatar.jpeg";
  final String _saying = "> 用代码改变世界 \n\nHey，我是金丰，仍然在进化，绝招尚在开发中。\n\n个人目标： "
      "根据Deepin公司招聘的人才要求，去培养自己。在大学中，我应该学习相关知识，考下Linux认证如RHCE等。"
      "同时，我也可以积累工作经验，勇敢的跨出第一步。比如可以去公司实习，学习更深层次的专业知识，了解真正的职场。"
      "毕业后，有了足够的经验，我就能拥有更多的就业机会。同时，我还要培养自己的口才等能力，让我做的事能够化作言语，准确的传达给每一个人。"
      "\n\nBest wishes.";

  @override
  Widget buildContent(BuildContext context) {
    return Stack(
      children: [
        FadeIn(child: Opacity(opacity: 0.7,child: Container(height: double.infinity,width: double.infinity,child: Image.asset("bg/home-bg.jpg",fit: BoxFit.cover)))),
        Container(
          // margin: EdgeInsets.all(42.w),
          padding: EdgeInsets.only(top: 50.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(_avatarUrl),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100.h,),
                Container(
                  margin: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                  border: Border.all(color:ThemeProvider.themeOf(context).data.backgroundColor)
                ),height: 450.h,child: getMarkdownWidget(context, _saying)),
                // Text(_saying,style: GoogleFonts.notoSans(),)
                SizedBox(height: 100.h,),
                KCard(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            alignment: WrapAlignment.spaceAround,
                            runAlignment: WrapAlignment.spaceAround,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            // runSpacing: 3,
                            children: [
                              InkWell(
                                onTap: ()=>invokeHrefOpen("https://github.com/Kingtous"),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(FontAwesomeIcons.github,size: 50,color: ThemeProvider.themeOf(context).data.accentColor,),
                                    const SizedBox(height: 8,),
                                    Text("Github",style: GoogleFonts.notoSans(textStyle: TextStyle(
                                      fontSize: 14)),)
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: ()=>invokeContactMeByEmail(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(FontAwesomeIcons.envelopeOpen,size: 50,color: ThemeProvider.themeOf(context).data.accentColor),
                                    const SizedBox(height: 8,),
                                    Text("Contact",style: GoogleFonts.notoSans(textStyle: TextStyle(
                                        fontSize: 14
                                    )))
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: ()=>invokeHrefOpen("http://cv.kingtous.cn"),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(FontAwesomeIcons.file,size: 50,color: ThemeProvider.themeOf(context).data.accentColor),
                                    const SizedBox(height: 8,),
                                    Text("CV",style: GoogleFonts.notoSans(textStyle: TextStyle(
                                        fontSize: 14
                                    )))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
