import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/util/Log.dart';

/*
 * 类描述： activity自定义栈<br/>
 * 主要用于跨级返回的需求<br/>
 * stack本身会存在重复添加同一个activity的现象<br/>
 * 其里功能需要在任何activity的创建，返回同步到自定义栈的前提下才能正常运行<br/>
 * 同步添加，移除后，则不会出现重复activity的现象<br/>
 * 能够在任何位置直接获取当前activity对象<br/>
 * 
 * 作者：郑朝军 on 2019/4/27
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/4/27
 * 修改备注：
 */
class StateManager
{
  List<State> mStateListStack = <State>[];

  static StateManager mInstance;

  static StateManager getInstance()
  {
    if (mInstance == null)
    {
      mInstance = new StateManager();
    }
    return mInstance;
  }

  /*
   * 添加新的State<br/>
   */
  void pushState(State state)
  {
    mStateListStack.add(state);
    outputStackInfo();
  }

  /*
   * 移除State<br/>
   * 仅限在框架上层State监听到调用finish后同步移除栈信息<br/>
   */
  void removeWidegtState(State currentState)
  {
    mStateListStack.remove(currentState);
    outputStackInfo();
  }

  /*
   * 跳转到新的state<br/>
   * 不需要持有Context对象<br/>
   */
  Future<T> startWidegtState<T extends Object>(StatefulWidget scene,
      State state)
  {
    return Navigator.push(state.context, new MaterialPageRoute(
      builder: (context)
      {
        return scene;
      },
    ));
  }

  /*
   * 跳转到新的state,并且杀死上一个组件<br/>
   * 不需要持有Context对象<br/>
   */
  void startWidegtStateAndRemove(StatefulWidget scene, State state)
  {
    Navigator.pushAndRemoveUntil(
        state.context,
        new MaterialPageRoute(builder: (BuildContext context)
        => scene),
            (route)
        => route == null);
  }

  /*
   * 移除到指定的widget(不包含指定)
   * 用于跨级返回<br/>
   * @param index 移动位置 值是从1开始 比如：内存中有3个index传值为1就一直移除到第一个1为止
   */
  void popToWidegtState(int index, {dynamic result})
  {
    if (index <= 0 && index > mStateListStack.length)
    {
      return;
    }
    while (true)
    {
      State state = currentState();
      if (state == null)
      {
        break;
      }
      if (mStateListStack.length == index)
      {
        break;
      }
      else
      {
        mStateListStack.remove(state);
        Navigator.pop(state.context, result);
      }
    }
  }

  /*
   * 移除到指定的widget(不包含指定)
   * 用于跨级返回<br/>
   * @param destRuntimeType 目标运行类型字符串
   */
  void popToWidegtStates(String destRuntimeType, {dynamic result})
  {
    destRuntimeType = convertDestRuntimeType(destRuntimeType);
    if (!contains(destRuntimeType))
    {
      return;
    }
    while (true)
    {
      State state = currentState();
      if (state == null)
      {
        break;
      }
      if (state.runtimeType.toString() == destRuntimeType)
      {
        break;
      }
      else
      {
        mStateListStack.remove(state);
        Navigator.pop(state.context, result);
      }
    }
  }

  /*
   * 获取当前的activity<br/>
   */
  State currentState()
  {
    if (mStateListStack.isEmpty)
    {
      return null;
    }
    State state = mStateListStack.last;
    return state;
  }

  /*
   * 输出栈信息<br/>
   */
  void outputStackInfo()
  {
    Log.i("stack", mStateListStack);
  }

  /*
   * 移除所有Widget<br/>
   */
  void popAllWidget()
  {
    while (true)
    {
      if (mStateListStack.length != 0)
      {
        popWidegtState();
      }
      else
      {
        break;
      }
    }
  }

  /*
   * 移除当前State<br/>
   */
  void popWidegtState({dynamic result})
  {
    State state = currentState();
    if (state == null)
    {
      return;
    }
    mStateListStack.remove(state);
    Navigator.pop(state.context, result);
  }

  /*
   * 判断栈中是否有该元素<br/>
   * @param destRuntimeType 目标运行类型字符串
   */
  bool contains(String destRuntimeType)
  {
    bool contains = false;
    Iterator<State> iterator = mStateListStack.iterator;
    while (iterator.moveNext())
    {
      if (iterator.current.runtimeType.toString() == destRuntimeType)
      {
        contains = true;
        break;
      }
    }
    return contains;
  }

  /*
   * 目标组件运行类型转换<br/>
   */
  String convertDestRuntimeType(String destRuntimeType)
  {
    return destRuntimeType + "State";
  }

  //------需要优化------------------------------------------------

  Future test(State state, String newRouteName, {Object arguments,})
  {
    return Navigator.pushNamedAndRemoveUntil(
        state.context, newRouteName, (route)
    => route == null);
  }

  void test2(State state, String routeName)
  {
    Navigator.pushNamed(state.context, routeName);
  }
}
