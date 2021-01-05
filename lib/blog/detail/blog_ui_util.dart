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

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

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
      imageBuilder: (uri, title, alt) {
        print("loading image:$uri");
        return Center(child: Image.network(uri.toString()));
      },
      // styleSheet: MarkdownStyleSheet.fromTheme(ThemeProvider.themeOf(context).data),
      styleSheetTheme: ThemeUtils.isDarkMode(context)
          ? MarkdownStyleSheetBaseTheme.material
          : MarkdownStyleSheetBaseTheme.cupertino,
      // blockSyntaxes: md.ExtensionSet.gitHubWeb.blockSyntaxes,
      // inlineSyntaxes: md.ExtensionSet.gitHubWeb.inlineSyntaxes,
      extensionSet: md.ExtensionSet(md.ExtensionSet.gitHubWeb.blockSyntaxes, [
        md.CodeSyntax(),
        md.AutolinkSyntax(),
        md.AutolinkExtensionSyntax(),
        md.ImageSyntax(),
        md.EmojiSyntax(),
        ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
      ]),
    ),
  );
}

Widget getBlogHeader(BuildContext context, BlogContent e) {
  return Container(
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
