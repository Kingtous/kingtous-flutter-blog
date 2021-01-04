import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/bean/blog_entity.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:kingtous_blog/blog/pages/route_notfound_page.dart';
import 'package:kingtous_blog/common/service_register.dart';
import 'package:kingtous_blog/common/theme_utils.dart';
import 'package:kingtous_blog/main.dart';
import 'package:kingtous_blog/network/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends BaseFramePageState<BlogPage> {
  Future<BlogEntity> data;

  @override
  void initState() {
    super.initState();
    data = getIt<ApiService>().getPages(0);
  }

  @override
  Widget buildContent(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          debugPrint(snapshot.connectionState.toString());
          debugPrint(snapshot.hasData.toString());
          if (!snapshot.hasError) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              BlogEntity data = snapshot.data;
              return _buildBlogList(context, data);
            } else {
              return LoadingPage();
            }
          } else {
            print(snapshot.error);
            return ErrorPage(
              err: snapshot.error,
            );
          }
        });
  }

  Widget _buildBlogList(BuildContext context, BlogEntity data) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) =>
                _buildBlogListItem(context, data.content[index]),
            itemCount: data.content.length,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: data.first
                  ? null
                  : () {
                      setState(() {
                        this.data = getIt<ApiService>()
                            .getPages(data.pageable.pageNumber - 1);
                      });
                    },
              child: Text("上一页"),
            ),
            Text("${data.pageable.pageNumber + 1}/${data.totalPages}"),
            FlatButton(
              onPressed: data.last
                  ? null
                  : () {
                      setState(() {
                        this.data = getIt<ApiService>()
                            .getPages(data.pageable.pageNumber + 1);
                      });
                    },
              child: Text("下一页"),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBlogListItem(BuildContext context, BlogContent e) {
    return GestureDetector(
      onTap: ()=>_goToDetail(context,e),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        key: ValueKey(e.pageId),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Divider(
              height: 8.h,
              indent: 1.w,
              endIndent: 1.w,
            ),
          ),
          SizedBox(height: 4.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 主标题
                Divider(
                  height: 8.h,
                  indent: 1.w,
                  endIndent: 1.w,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      e.title.toString(),
                      style:
                          GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 24)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Text(
                      e.subtitle.toString(),
                      style:
                          GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: ThemeUtils.isDarkMode(context)?Colors.black:Colors.white
                  ),
                  child: Row(
                    children: [
                      Text(e.content.toString()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Text(
                      "创建于 ${e.createDate.toString()}",
                      style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _goToDetail(BuildContext context, BlogContent e) {
    Get.toNamed("/note/${e.pageId}");
  }
}