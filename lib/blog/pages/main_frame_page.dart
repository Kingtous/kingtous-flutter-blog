/*
 * @Author: Kingtous
 * @Date: 2020-10-28 16:36:31
 * @LastEditors: Kingtous
 * @LastEditTime: 2020-10-28 18:35:12
 * @Description: 主要框架
 */
import 'package:flutter/material.dart';
import 'package:kingtous_blog/blog/pages/welcome_page.dart';
import 'package:theme_provider/theme_provider.dart';

class MainFrameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}

/// 主框架Page
class MainFramePage extends StatefulWidget {
  @override
  _MainFramePageState createState() => _MainFramePageState();
}

class _MainFramePageState extends State<MainFramePage>{
  var _pageController = PageController();
  var _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: ThemeProvider.themeOf(context).data.primaryColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildNavigationButton(context),
          ),
        ),
        Expanded(
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              // 首页
              WelcomePage(),
              // 文章
              WelcomePage(),
              // 标签
              WelcomePage(),
              // 关于
              WelcomePage()
            ],
          ),
        )
      ],
    );
  }

  List<Widget> _buildNavigationButton(BuildContext context) {
    List<String> btnName = ["首页", "文章", "标签", "关于"];
    Map<String, Widget> m = {
      "首页": Icon(
        Icons.home,
        color: Colors.white,
        size: 25,
      ),
      "文章": Icon(
        Icons.pages,
        color: Colors.white,
        size: 25,
      ),
      "标签": Icon(
        Icons.tag,
        color: Colors.white,
        size: 25,
      ),
      "关于": Icon(
        Icons.people,
        color: Colors.white,
        size: 25,
      ),
    };
    List<Widget> btnWidgets = List();
    for (var i = 0; i < btnName.length; i++) {
      btnWidgets.add(Container(
        height: MediaQuery.of(context).size.height / 5,
        child: FlatButton(
          disabledColor: ThemeProvider.themeOf(context).data.hoverColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              m[btnName[i]],
              Text(
                btnName[i],
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: _currentIndex == i ? null:() {
            setState(() {
              _currentIndex = i;
              _pageController.animateToPage(i, duration: Duration(seconds: 1),curve: Curves.easeInOutBack);
            });
          },
        ),
      ));
    }
    return btnWidgets;
  }
}
