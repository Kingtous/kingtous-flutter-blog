import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends BaseFramePageState<AboutMePage> {

  final String _avatarUrl = "https://avatars3.githubusercontent.com/u/39793325?s=400&u=f75f8fd298fdfe2ab220064ce6fefc5144d7cda8&v=4";
  final String _saying = "> 用代码改变世界 \n\nHey，我是金丰，仍然在进化，绝招尚在开发中。\n\n个人目标： "
      "根据Deepin公司招聘的人才要求，去培养自己。在大学中，我应该学习相关知识，考下Linux认证如RHCE等。"
      "同时，我也可以积累工作经验，勇敢的跨出第一步。比如可以去公司实习，学习更深层次的专业知识，了解真正的职场。"
      "毕业后，有了足够的经验，我就能拥有更多的就业机会。同时，我还要培养自己的口才等能力，让我做的事能够化作言语，准确的传达给每一个人。"
      "\n\nBest wishes.";

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(42.w),
      padding: EdgeInsets.only(top: 50.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150.w,
                width: 150.w,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_avatarUrl),
                ),
              ),
            ],
          ),
          SizedBox(height: 100.h,),
          Expanded(child: MarkdownBody(data: _saying,selectable: true,))
          // Text(_saying,style: GoogleFonts.notoSans(),)
        ],
      ),
    );
  }
}
