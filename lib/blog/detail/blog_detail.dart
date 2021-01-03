/*
 * @Author: Kingtous
 * @Date: 2020-10-14 23:13:00
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-14 23:47:49
 * @Description: Kingtous' Code
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:kingtous_blog/blog/detail/providers/blog_detail_provider.dart';
import 'package:kingtous_blog/blog/pages/base/base_frame_page.dart';
import 'package:provider/provider.dart';
import 'package:markdown/markdown.dart' as md;

Widget getMarkdownWidget(String _markdownData,{ScrollController scrollController}) {
  return Markdown(
    controller: scrollController,
    selectable: true,
    data: _markdownData,
    physics: BouncingScrollPhysics(),
    imageDirectory: '',
    extensionSet:
        md.ExtensionSet(md.ExtensionSet.gitHubFlavored.blockSyntaxes, [
      md.CodeSyntax(),
      md.AutolinkSyntax(),
      md.ImageSyntax(),
      md.EmojiSyntax(),
      ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
    ]),
  );
}
