/*
 * @Author: Kingtous
 * @Date: 2020-10-14 23:13:00
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-14 23:47:49
 * @Description: Kingtous' Code
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:provider/provider.dart';
import 'package:markdown/markdown.dart' as md;
import 'dart:js' as js;

import 'package:theme_provider/theme_provider.dart';

Widget getMarkdownWidget(BuildContext context,String _markdownData,{ScrollController scrollController}) {
  return Markdown(
    controller: scrollController,
    selectable: true,
    data: _markdownData,
    physics: BouncingScrollPhysics(),
    imageDirectory: '',
    onTapLink: (text,href,title){
      js.context.callMethod('open',[href]);
    },
    imageBuilder: (uri,title,alt){
      print("loading image:$uri");
      return Center(child: Image.network(uri.toString()));
    },
    // styleSheet: MarkdownStyleSheet.fromTheme(ThemeProvider.themeOf(context).data),
    styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
    // blockSyntaxes: md.ExtensionSet.gitHubWeb.blockSyntaxes,
    // inlineSyntaxes: md.ExtensionSet.gitHubWeb.inlineSyntaxes,
    extensionSet:
      md.ExtensionSet(md.ExtensionSet.gitHubWeb.blockSyntaxes, [
      md.CodeSyntax(),
      md.AutolinkSyntax(),
      md.AutolinkExtensionSyntax(),
      md.ImageSyntax(),
      md.EmojiSyntax(),
      ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
    ]),
  );
}
