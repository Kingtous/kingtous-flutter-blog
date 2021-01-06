/*
 * @Author: Kingtous
 * @Date: 2020-10-14 23:13:00
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-14 23:47:49
 * @Description: Kingtous' Code
 */
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kingtous_blog/bean/blog_entity.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:kingtous_blog/common/theme_utils.dart';
import 'package:provider/provider.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:universal_html/js.dart' as js;
import 'package:theme_provider/theme_provider.dart';

Widget getMarkdownWidget(BuildContext context, String _markdownData,
    {ScrollController scrollController}) {
  return FadeInUp(
      child: Markdown(
          padding: EdgeInsets.all(16.w),
          controller: scrollController,
          selectable: true,
          data: _markdownData,
          physics: BouncingScrollPhysics(),
          imageDirectory: '',
          onTapLink: (text, href, title) {
            js.context.callMethod('open', [href]);
          },
          imageBuilder: getMarkdownImageBuilder(),
          styleSheet: MarkdownStyleSheet.fromTheme(
              ThemeUtils.isDarkMode(context)
                  ? ThemeData(
                      brightness: Brightness.dark,
                      textTheme: GoogleFonts.notoSansTextTheme(
                          TextTheme(bodyText2: TextStyle(fontSize: 16))))
                  : ThemeData(
                      brightness: Brightness.light,
                      textTheme: GoogleFonts.notoSansTextTheme(
                          TextTheme(bodyText2: TextStyle(fontSize: 16))))),
          styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
          listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
          extensionSet:
              md.ExtensionSet(md.ExtensionSet.gitHubWeb.blockSyntaxes, [
            md.CodeSyntax(),
            md.AutolinkSyntax(),
            md.AutolinkExtensionSyntax(),
            md.ImageSyntax(),
            md.EmojiSyntax(),
            ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
          ])));
}

Widget getBlogHeader(BuildContext context, BlogContent e) {
  return Opacity(
    opacity: 0.9,
    child: Container(
      decoration: BoxDecoration(
          color: ThemeUtils.isDarkMode(context) ? Colors.grey : Colors.white),
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                e.title.toString(),
                style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 24)),
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
                style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16)),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            children: [
              Text(
                "创建于 ${e.createDate.year}年${e.createDate.month}月${e.createDate.day}日 ${e.createDate.hour}:${e.createDate.minute}",
                style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16)),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget getBlogDescWidget(BuildContext context, BlogContent e) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    key: ValueKey(e.pageId),
    children: [
      // Line(),
      SizedBox(
        height: 4.h,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
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
            Wrap(
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
            Opacity(
              opacity: 0.5,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: ThemeUtils.isDarkMode(context)
                            ? Colors.white
                            : Colors.black),
                    color: ThemeUtils.isDarkMode(context)
                        ? Colors.black
                        : Colors.white),
                child: Wrap(
                  children: [MarkdownBody(data: e.content)],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Wrap(
              children: [
                Text(
                  "创建于 ${e.createDate.year}年${e.createDate.month}月${e.createDate.day}日 ${e.createDate.hour}:${e.createDate.minute}",
                  style:
                      GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 16)),
                  overflow: TextOverflow.clip,
                ),
              ],
            )
          ],
        ),
      ),
    ],
  );
}

MarkdownImageBuilder getMarkdownImageBuilder() {
  return (Uri uri, String title, String alt) {
    if (uri.hasAuthority) {
      // 网图
      // print("loading network image:$uri");
      return Center(child: Image.network(uri.toString()));
    } else {
      // 可能是assets里面的图
      return Center(child: Image.asset(uri.toString()));
    }
  };
}
