import 'dart:convert';

import 'package:animate_do/animate_do.dart';
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
import 'package:kingtous_blog/network/api_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogDetailPage extends StatefulWidget {
  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends BaseFramePageState<BlogDetailPage> {

  Future<BlogContent> content;
  bool noPageId = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var id = Get.parameters["page_id"];
    if (id != null) {
      noPageId = false;
      content = getIt.get<ApiService>().getBlogContent(id);
    }
  }

  Widget _buildBlog(BuildContext context, BlogContent data) {
    // decode content
    var contentDecoded = utf8.decode(base64.decode(data.content));
    return Column(
      children: [
        _buildHeader(context,data),
        Expanded(child: Stack(
        children: [
            ThemeUtils.isDarkMode(context)? Opacity(opacity: 0.7,child: Container(height: double.infinity,width: double.infinity,child: Image.asset("bg/markdown-view-bg.jpg",fit: BoxFit.cover))):SizedBox(width: 0,),
            getMarkdownWidget(context,contentDecoded,scrollController: _scrollController)
        ],
        ),
        )]
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return FutureBuilder(
        future: content,
        builder: (context, snapshot) {
          debugPrint(snapshot.connectionState.toString());
          debugPrint(snapshot.hasData.toString());
          if (!noPageId || !snapshot.hasError) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              BlogContent data = snapshot.data;
              return _buildBlog(context, data);
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

  _buildHeader(BuildContext context, BlogContent e) {
    return KCard(
      child: getBlogHeader(context,e),
    );
  }
}
