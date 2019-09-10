import 'package:flutter/src/widgets/framework.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/slot/inter/InterfaceBase.dart';

/*
 * 类描述：注册中心服务基类
 * 作者：郑朝军 on 2019/6/12
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/6/12
 * 修改备注：
 */
class InterfaceBaseImpl implements InterfaceBase
{
  @override
  Future<T> runPlugin<T extends Object>(State<StatefulWidget> state, {dynamic initPara})
  {
  }

  @override
  Widget runWidget({initPara})
  {
    return null;
  }
}
