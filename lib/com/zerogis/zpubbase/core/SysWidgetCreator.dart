import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/util/CxTextUtil.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/resource/StringRes.dart';

/*
 * 功能：组件库,用于创建常用的组件：类似Android中layout文件中common_progressbar.xml相关
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
class SysWidgetCreator
{
  /*
   * 创建公有网络进度栏<br/>
   */
  static Widget createCommonProgressBar({String text = StringRes.progressbar_text})
  {
    Widget progressBar = new Container(
      width: 198,
      height: 63,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 110),
      decoration: BoxDecoration(
          color: Color.fromARGB(127, 127, 127, 127),
          border: Border.all(color: Colors.blue, width: 0.1),
          borderRadius: BorderRadius.circular(4)),
      child: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Container(
            width: 115,
            child: new Text(
              CxTextUtil.isEmpty(text) ? StringRes.progressbar_text : text,
              textScaleFactor: 1.1,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );

    return progressBar;
  }

  /*
   * 创建一条横线<br/>
   */
  static Widget createCommonDevider()
  {
    return new Divider(height: 1, color: Colors.grey);
  }

  /*
   * 创建一条竖线<br/>
   */
  static Widget createCommonVerticalDevider()
  {
    Widget devider = new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.grey.withOpacity(0.5),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
    return devider;
  }

  static Widget createCommonVerticalDeviderOld()
  {
    return new VerticalDivider(color: Colors.grey);
  }

  /*
   * 创建暂无数据<br/>
   */
  static Widget createCommonNoData({String text = StringRes.no_data, GestureTapCallback onTap})
  {
    Widget devider = new GestureDetector(onTap: onTap, child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: new Align(alignment: Alignment.center, child: new Text(text))));
    return devider;
  }

  /*
   * 创建暂无数据<br/>
   */
  static List<Widget> createCommonNoDataList({String text = StringRes.no_data})
  {
    List<Widget> list = <Widget>[];
    Widget devider = new Container(
      margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child: new Align(alignment: Alignment.center, child: new Text(text)),
    );
    list.add(devider);
    return list;
  }

  /*
   * 创建公共可以缩放的图片<br/>
   */
  static GridView createCommonGridViewWrap(List<Widget> children)
  {
    return new GridView.count(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        children: children);
  }

  /*
   * 创建公共可以缩放的图片<br/>
   */
  static GridView createMiddleGridViewWrap(List<Widget> children)
  {
    return new GridView.count(
        shrinkWrap: true,
        physics: new NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        children: children);
  }
}
