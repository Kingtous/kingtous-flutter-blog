import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/bean/blog_entity.dart';
import 'package:kingtous_blog/blog/detail/blog_ui_util.dart';
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
                _buildBlogListItem(context, data.content[index],index),
            itemCount: data.content.length,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
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
          ),
        )
      ],
    );
  }

  Widget _buildBlogListItem(BuildContext context, BlogContent e, int index) {
    return FadeInRight(
      duration: const Duration(milliseconds: 500),
      child: KCard(
        child: GestureDetector(
          onTap: ()=>_goToDetail(context,e),
          child: getBlogDescWidget(context, e),
        ),
      ),
    );
  }

  _goToDetail(BuildContext context, BlogContent e) {
    Get.toNamed("/note/${e.pageId}");
  }
}
