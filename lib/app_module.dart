// /*
//  * @Author: Kingtous
//  * @Date: 2020-10-14 23:06:33
//  * @LastEditors: Kingtous
//  * @LastEditTime: 2020-10-14 23:36:38
//  * @Description: Kingtous' Code
//  */
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:kingtous_blog/blog/detail/blog_detail.dart';
// import 'package:kingtous_blog/main.dart';
//
// import 'blog/pages/main_frame_page.dart';
//
// class AppModule extends MainModule {
//
//   @override
//   List<Bind> get binds => [
//
//   ];
//
//   @override
//   Widget get bootstrap => MyApp();
//
//   @override
//   List<ModularRouter> get routers => [
//     ModularRouter("/",child: (context,args) => MainFramePage()),
//   ];
//
// }
//
// class FrameModule extends MainModule {
//
//   @override
//   List<Bind> get binds => [
//
//   ];
//
//   @override
//   Widget get bootstrap => MyApp();
//
//   @override
//   List<ModularRouter> get routers => [
//     ModularRouter("/index",child: (context,args) => BlogDetailPage()),
//     ModularRouter("/note",child: (context,args) => BlogDetailPage()),
//   ];
//
// }