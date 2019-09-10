import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:weui/weui.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/core/SysWidgetCreator.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/listener/HttpListener.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/manager/StateManager.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/resource/ColorRes.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/util/CxTextUtil.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/util/Log.dart';

/*
 * 功能：FuctionStateFul基类
 * 备注：StatelessWidget由父组件控制状态转换，StatefulWidget由自身管理控制状态
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
abstract class FuctionStateFulBase extends StatefulWidget
{
  FuctionStateFulBase({Key key}) : super(key: key);
}

/*
 * 功能：FuctionStateBase基类,标题栏函数化,路由跳转
 * 需要传入的键：
 * 传入的值类型：
 * 传入的值含义：
 * 是否必传 ：
 * 作者：郑朝军 on 2019/4/7 23:23
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 */
abstract class FuctionStateBase<T extends StatefulWidget> extends State<T> implements HttpListener
{
  //右边按钮标识
  final key_btn_right = GlobalKey();

  //侧边按钮标识
  final key_btn_border = GlobalKey();

  //左边按钮标识
  final key_btn_leading = GlobalKey();

  //窗口
  MaterialApp mApp;

  //body上下文
  BuildContext mBodyContext;

  //标题
  String mTitle;

  //右边按钮与侧边按钮
  IconButton btn_right, btn_border;

  //leading
  Widget mLeading;

  //标题栏背景
  Color mTitleBarBg;

  //网络进度栏
  Widget mProgressBar = SysWidgetCreator.createCommonProgressBar();

  //是否显示网络进度栏
  bool mShowProgress = false;

  //是否显示底部导航拦
  bool mShowNavigationBar = false;

  //是否显示标题栏
  bool mIsShowTitleBar = true;

  //背景颜色
  Color mWindowBackgroundColor = ColorRes.windowBackground;

  /*
   * 异步绑定Frame
   */
  void schedulerBindingPostFrame(FrameCallback callback)
  {
    SchedulerBinding.instance.addPostFrameCallback(callback);
  }

  /*
   * 创建内容栏
   */
  Widget buildBody(BuildContext context, Widget body)
  {
    AppBar appBar = createCommonAppBar();
    mApp = new MaterialApp(
      home: new Scaffold(
        appBar: new PreferredSize(
          preferredSize: appBar.preferredSize,
          child: new Offstage(
            child: appBar,
            offstage: !mIsShowTitleBar,
          ),
        ),
        body: new Builder(builder: (BuildContext context)
        {
          this.mBodyContext = context;
          return new Stack(
            children: <Widget>[
              body == null ? new Container() : body,
              new Offstage(
                child: new Container(
                  margin: mIsShowTitleBar
                      ? EdgeInsets.only(top: 0)
                      : EdgeInsets.only(top: appBar.preferredSize.height),
                  child: new Center(
                    child: mProgressBar,
                  ),
                ),
                offstage: !mShowProgress,
              )
            ],
          );
        }),
        backgroundColor: mWindowBackgroundColor,
        bottomNavigationBar: mShowNavigationBar
            ? createBottomNavigationBar()
            : new Container(width: 0, height: 0),
      ),
    );
    return mApp;
  }

  /*
   * 创建标题栏<br/>
   */
  AppBar createCommonAppBar()
  {
    return new AppBar(
      leading: mLeading ??
          new IconButton(
            key: key_btn_leading,
            icon: new Icon(Icons.arrow_back),
            onPressed: ()
            {
              _onClickLeadingButton(mLeading);
            },
          ),
      title: new Text(mTitle ?? 'FlutterDesign'),
      centerTitle: true,
      actions: <Widget>[
        btn_border ?? new Container(width: 0, height: 0),
        btn_right ?? new Container(width: 0, height: 0),
      ],
      backgroundColor: mTitleBarBg ?? Colors.blue,
    );
  }

  /*
   * 隐藏标题栏<br/>
   */
  void hideTitleBar()
  {
    mIsShowTitleBar = false;
  }

  /*
   * 显示标题栏<br/>
   */
  void showTitleBar()
  {
    mIsShowTitleBar = true;
  }

  /*
   * 设置内容背景颜色<br/>
   */
  void setContentBackground(Color backgroundColor)
  {
    mWindowBackgroundColor = backgroundColor;
  }

  /*
   * 设置内容背景颜色<br/>
   */
  void setContentBackgroundARGB(int a, int r, int g, int b)
  {
    mWindowBackgroundColor = Color.fromARGB(a, r, g, b);
  }

  /*
   * 设置标题栏背景颜色<br/>
   */
  void setTitleBarGgARGB(int a, int r, int g, int b)
  {
    mTitleBarBg = Color.fromARGB(a, r, g, b);
  }

  /*
   * 设置右边按钮
   */
  void setRightButtonFromAsset(String path)
  {
    btn_right = new IconButton(
      key: key_btn_right,
      icon: new Image.asset(path),
      onPressed: ()
      {
        onClick(btn_right);
      },
    );
  }

  /*
   * 设置右边按钮
   */
  void setRightButtonFromIcon(IconData iconData)
  {
    btn_right = new IconButton(
      key: key_btn_right,
      icon: new Icon(iconData),
      onPressed: ()
      {
        onClick(btn_right);
      },
    );
  }

  /*
   * 设置右边按钮
   */
  void setRightButtonFromText(String text)
  {
    btn_right = new IconButton(
      key: key_btn_right,
      icon: new Text(
        text,
      ),
      onPressed: ()
      {
        onClick(btn_right);
      },
    );
  }

  /*
   * 设置侧边按钮
   */
  void setBorderButtonFromAsset(String path)
  {
    btn_border = new IconButton(
      key: key_btn_border,
      icon: new Image.asset(path),
      onPressed: ()
      {
        onClick(btn_border);
      },
    );
  }

  /*
   * 设置侧边按钮
   */
  void setBorderButtonFromIcon(IconData iconData)
  {
    btn_border = new IconButton(
      key: key_btn_border,
      icon: new Icon(iconData),
      onPressed: ()
      {
        onClick(btn_border);
      },
    );
  }

  /*
   * 设置侧边按钮
   */
  void setBorderButtonFromText(String text)
  {
    btn_border = new IconButton(
      key: key_btn_border,
      icon: new Text(text),
      onPressed: ()
      {
        onClick(btn_border);
      },
    );
  }

  /*
   * 设置左边按钮
   */
  void setLeadingButtonFromAsset(String path, {bool selfHandle = true})
  {
    mLeading = new IconButton(
      key: key_btn_leading,
      icon: new Image.asset(path),
      onPressed: ()
      {
        if (selfHandle)
        {
          onClick(mLeading);
        }
        else
        {
          _onClickLeadingButton(mLeading);
        }
      },
    );
  }

  /*
   * 设置左边按钮
   */
  void setLeadingButtonFromIcon(IconData iconData, {bool selfHandle = true})
  {
    mLeading = new IconButton(
      key: key_btn_leading,
      icon: new Icon(iconData),
      onPressed: ()
      {
        if (selfHandle)
        {
          onClick(mLeading);
        }
        else
        {
          _onClickLeadingButton(mLeading);
        }
      },
    );
  }

  /*
   * 控件点击
   */
  void onClick(Widget widget)
  {
    showSnackBar('正在开发中');
  }

  /*
   * 返回按钮点击
   */
  void _onClickLeadingButton(Widget widget)
  {
    finish();
  }

  /*
   * 显示Toast
   */
  void showToast(String msg)
  {
    if (!CxTextUtil.isEmpty(msg) && context != null)
    {
      WeToast.info(context)(msg, align: WeToastInfoAlign.center);
    }
  }

  /*
   * 显示Toast
   */
  void showToastShort(String msg)
  {
    if (!CxTextUtil.isEmpty(msg) && context != null)
    {
      WeToast.info(context)(msg, align: WeToastInfoAlign.center);
    }
  }

  /*
   * 显示SnackBar
   */
  void showSnackBar(String msg, {String label = '确定'})
  {
    final snackBar = new SnackBar(
      content: new Text(msg),
      action: new SnackBarAction(label: label, onPressed: onSnackBarPressed),
    );
    Scaffold.of(mBodyContext).showSnackBar(snackBar);
  }

  /*
   * SnackBarAction点击回调
   */
  void onSnackBarPressed()
  {}

  /*
   * 显示网络进度栏及关闭软键盘<br/>
   */
  void showProgressBar({String text})
  {
    mShowProgress = true;
    mProgressBar = SysWidgetCreator.createCommonProgressBar(text: text);
    hideSoftInput();
  }

  /*
   * 显示网络进度栏及关闭软键盘<br/>
   */
  void showProgressBarState({String text})
  {
    setState(()
    {
      showProgressBar(text: text);
    });
  }

  /*
   * 重置网络进度栏<br/>
   */
  void resetProgressBar({String text})
  {
    mShowProgress = true;
    mProgressBar = SysWidgetCreator.createCommonProgressBar(text: text);
  }

  /*
   * 重置网络进度栏<br/>
   */
  void resetProgressBarState({String text})
  {
    setState(()
    {
      resetProgressBar(text: text);
    });
  }

  /*
   * 隐藏并重置网络进度栏<br/>
   */
  void hideProgressBar()
  {
    mShowProgress = false;
    mProgressBar = SysWidgetCreator.createCommonProgressBar();
  }

  /*
   * 隐藏并重置网络进度栏<br/>
   */
  void hideProgressBarState()
  {
    setState(()
    {
      hideProgressBar();
    });
  }

  /*
   * 隐藏标题栏的返回按钮<br/>
   */
  void hideBackButton()
  {
    mLeading = new Container(width: 0, height: 0);
  }

  /*
   * 关闭软键盘<br/>
   */
  void hideSoftInput()
  {
//    FocusScope.of(context).requestFocus(FocusNode());
  }

  /*
   * 返回上一场景
   */
  void finish()
  {
    Navigator.pop(context);
  }

  /*
   * 退出系统
   */
  void exitSystem()
  {
    SystemNavigator.pop();
  }

  /*
   * 初始化
   */
  @override
  void initState()
  {
    super.initState();
    if (usePushStack())
    {
      StateManager.getInstance().pushState(this);
    }
  }

  /*
   * 销毁组件
   */
  @override
  void dispose()
  {
    super.dispose();
    if (usePushStack())
    {
      StateManager.getInstance().removeWidegtState(this);
    }
  }

  void setState(VoidCallback fn)
  {
    if (!mounted)
    {
      return;
    }
    super.setState(fn);
  }

  /*
   * 是否使用入栈操作
   */
  bool usePushStack()
  {
    return true;
  }

  void onDbSucceed(String method, Object values)
  {
    showToast("" + values);
  }

  void onDbFaild(String method, Object values)
  {
    showToast(values);
    Log.e("db", values);
  }

  void onNetWorkSucceed(String method, Object values)
  {
    showToast("" + values.toString());
  }

  void onNetWorkFaild(String method, Object values)
  {
    showToast("" + values);
    Log.e("http", values);
  }

  void onOtherSucceed(String method, Object values)
  {
    showToast("" + values);
  }

  void onOtherFaild(String method, Object values)
  {
    showToast("" + values);
    Log.e("other", values);
  }

  void onException(String method, Object e)
  {
    String error = "网络连接出现异常：" +
        "\n    异常运行窗口：" +
        runtimeType.toString() +
        "\n    捕获异常函数：" +
        method +
        "\n    " +
        e.toString();
    Log.e(Log.TAG, error);
    Log.e("error", error);
    showToast(error);
  }

  void onCancel(String method)
  {}

  //-----------待优化-------------------------------------
  /*
   * 创建内容栏
   */
  Widget buildBodyProgressBar(Widget body)
  {
    return new Stack(
      children: <Widget>[
        body == null ? new Container() : body,
        new Offstage(
          child: new Center(
            child: mProgressBar,
          ),
          offstage: !mShowProgress,
        )
      ],
    );
  }

  Widget createBottomNavigationBar()
  {
    return new Container(width: 0, height: 0);
  }
}
