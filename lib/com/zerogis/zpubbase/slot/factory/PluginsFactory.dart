import 'package:zpub_bas/com/zerogis/zpubbase/slot/inter/InterfaceBase.dart';

/*
 * 类描述：插件集合类
 * 作者：郑朝军 on 2019/5/31
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/31
 * 修改备注：
 */
class PluginsFactory
{
  static PluginsFactory instance;

  Map<String, InterfaceBase> stateListStack = {};

  static PluginsFactory getInstance()
  {
    if (instance == null)
    {
      instance = new PluginsFactory();
    }
    return instance;
  }

  void add(String key, InterfaceBase listener)
  {
    stateListStack[key] = listener;
  }

  InterfaceBase get(String key)
  {
    return stateListStack[key];
  }

  void remove(InterfaceBase listener)
  {
    stateListStack.remove(listener);
  }
}
