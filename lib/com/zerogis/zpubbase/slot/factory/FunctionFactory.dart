/*
 * 类描述：方法注册集合类
 * 作者：郑朝军 on 2019/5/31
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/31
 * 修改备注：
 */

/// A界面调用B界面的函数  传递参数调用B界面的函数且返回数据给A界面
///
typedef FunctionCallback<T> = dynamic Function(T value);

class FunctionFactory
{
  static FunctionFactory instance;

  Map<String, FunctionCallback> stateListStack = {};

  static FunctionFactory getInstance()
  {
    if (instance == null)
    {
      instance = new FunctionFactory();
    }
    return instance;
  }

  void add(String key, FunctionCallback listener)
  {
    stateListStack[key] = listener;
  }

  FunctionCallback get(String key)
  {
    return stateListStack[key];
  }

  void remove(FunctionCallback listener)
  {
    stateListStack.remove(listener);
  }

  /*
   * 执行函数异步返回
   * @param key 注册函数的key
   * @param value 调用函数传递的参数
   */
  Future<dynamic> executorAsy(key, [value])
  async
  {
    FunctionCallback functionCallback = stateListStack[key];
    if (functionCallback == null)
    {
      return null;
    }
    return functionCallback(value);
  }


  /*
   * 执行函数同步返回
   * @param key 注册函数的key
   * @param value 调用函数传递的参数
   */
  dynamic executor(key, [value])
  {
    FunctionCallback functionCallback = stateListStack[key];
    if (functionCallback == null)
    {
      return null;
    }
    return functionCallback(value);
  }
}
