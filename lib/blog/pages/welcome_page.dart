/*
 * @Author: Kingtous
 * @Date: 2020-10-28 16:34:20
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-11-12 18:28:07
 * @Description: 带搜索条的欢迎页
 */
import 'package:animate_do/animate_do.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/bean/blog_entity.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:kingtous_blog/blog/pages/route_notfound_page.dart';
import 'package:kingtous_blog/common/service_register.dart';
import 'package:kingtous_blog/common/theme_utils.dart';
import 'package:kingtous_blog/network/api_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with AutomaticKeepAliveClientMixin {
  var _searchTextController = TextEditingController();

  Future<BlogEntity> data;
  var searchKeyWords;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      showSimpleNotification(Text("欢迎~"),
          position: NotificationPosition.bottom);
    });
  }

  void _search(content,{int offset = 0}) {
    searchKeyWords = content;
    setState(() {
      data = getIt<ApiService>().searchPage(offset,content);
    });
    // showSimpleNotification(Text("正在光速搜索中..."),
    //     position: NotificationPosition.bottom);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: BoxDecoration(
          color: ThemeProvider.themeOf(context).id == 'light'
              ? Color(0xFF217FCC)
              : Colors.black),
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: FlareActor(
              "assets/flrs/welcome.flr",
              animation: ThemeProvider.themeOf(context).id == 'light'
                  ? "welcome"
                  : 'welcome_dark',
              fit: BoxFit.fitWidth,
              callback: (s) {
                Get.log("animation ended");
              },
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SlideInUp(
                        child: Container(
                          margin: EdgeInsets.all(200.w),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: "搜索内容",
                              hintStyle: TextStyle(color: Colors.white),
                              // prefixIcon:
                              //     Icon(Icons.search, color: Colors.white)
                            ),
                            controller: _searchTextController,
                            onSubmitted: (s) {
                              if (s.trim().isNotEmpty) {
                                _search(s);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                data != null
                    ? Expanded(
                      child: FutureBuilder(
                          future: data, builder: (context, snapshot) {
                            if (snapshot.hasError){
                              return ErrorPage();
                            } else {
                              if (snapshot.hasData){
                                return _buildBlogList(context, snapshot.data);
                              } else {
                                return LoadingPage();
                              }
                            }
                }),
                    )
                    : SizedBox(
                        width: 0,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildBlogList(BuildContext context, BlogEntity data) {
    return SlideInUp(
      child: Container(
        color: ThemeUtils.isDarkMode(context)?Colors.black:Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: Icon(Icons.delete), onPressed: () {
                  setState(() {
                    this.data = null;
                  });
                },)
              ]
            ),
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
                Text(data.totalElements == 0 ? "啥都没有搜索到..." : "${data.pageable.pageNumber + 1}/${data.totalPages}"),
                FlatButton(
                  onPressed: data.last
                      ? null
                      : () {
                    setState(() {
                      this.data = getIt<ApiService>()
                          .searchPage(data.pageable.pageNumber + 1,searchKeyWords);
                    });
                  },
                  child: Text("下一页"),
                ),
              ],
            )
          ],
        ),
      ),
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
                  child: Wrap(
                    children: [
                      Text(e.content.toString(),overflow: TextOverflow.clip,),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Wrap(
                  children: [
                    Text(
                      "创建于 ${e.createDate.toString()}",
                      style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16)),
                      overflow: TextOverflow.clip,
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
