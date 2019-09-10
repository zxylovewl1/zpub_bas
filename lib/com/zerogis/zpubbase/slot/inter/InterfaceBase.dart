import 'package:flutter/material.dart';

/*
 * 类描述：插件，组件公共接口
 * 作者：郑朝军 on 2019/5/31
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/31
 * 修改备注：
 */
abstract class InterfaceBase
{
  /*
   * 执行插件带有回调(可夸级)
   */
  Future<T> runPlugin<T extends Object>(State state, {dynamic initPara});

  /*
   * 执行组件
   */
  Widget runWidget({dynamic initPara});
}
