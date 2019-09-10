
解析JSON：json_serializable: ^2.1.0
网站：https://pub.dartlang.org/packages/
命令：flutter packages pub run build_runner build 或者 flutter packages pub run build_runner build --delete-conflicting-outputs

打包：flutter打包
网站：https://pub.dartlang.org/packages/
命令：flutter build apk 或 flutter build ios --release

打包：flutter插件上传
网站：https://www.jianshu.com/p/f60ed73fb936
命令：flutter packages pub publish --server=https://pub.dartlang.org

用法：插件组件写法
网站：1：拷贝 2：修改名称 3：注册 4：增加脚本

用法：格式化SQL脚本
网站：java -jar /Users/zcj/D/work_zbcx/JAVA/工具相关/PackTools.jar formatsql /Users/zcj/D/work_zbcx/Flutter/code/oa/code/zmoa/assets/sql/ zbcx.sql

用法：上传svn删除哪些东西？
网站：1：.dart_tool 2：.gradle 3：build 4：ios/App.framework 5：ios/Flutter.framework 6：ios/.symlinks 7：ios/Pods


用法：Android端修改
网站：修改Android目录下app目录build.gradle中的signingConfigs签名文件存储位置





代办：
 1:网络图片使用需要优化下，需要封装下
 2:firebase(收集崩溃日志)
 10:日历：https://pub.dev/packages/table_calendar#-readme-tab-
 https://github.com/Solido/awesome-flutter
网站：
命令：flutter packages pub publish --server=https://pub.dartlang.org


此种配置为了解决跳转多个插件的时候key是一样的冲突，但是需要传递不同的值
构造参数编写规则？
举例：这个是内存中的值
{
  "hideBackButton": 1,
  "showNavigationBar": 1,
  "bottomIconText": {
    "businessKey": [
      [
        {
          "businessKey": "数组中的值",
          "数组中的值": "xx",
          "bg": "bg",
          "wd": "我的"
        },
        {
          "businessKey": "数组中的值2",
          "数组中的值": "xx",
          "bg": "bg",
          "wd": "我的"
        }
      ],
      [
        {
          "businessKey": "数组中的值",
          "数组中的值": "xx",
          "bg": "bg",
          "wd": "我的"
        },
        {
          "businessKey": "数组中的值2",
          "数组中的值": "xx",
          "bg": "bg",
          "wd": "我的"
        }
      ]
    ]
  }
}

plugin表字段initpara配置规则
举例：
{
  "hideBackButton": "?,[{组件(插件)名称,初始化参数的key}]",
  "showNavigationBar": "?,[{组件(插件)名称,初始化参数的key}]",
  "bottomIconText": {
    "businessKey": [
      [
        {
          "businessKey": "?,[{组件(插件)名称,初始化参数的key}]"
        }
      ]
    ]
  }
}
注意事项：1：不能在list里面配置?号,因为不知道去list中哪个位置上的值



  启动插件的service层需要做的事情
   /**
   * 1：启动插件的时候哪些是必须要有的值：是做什么用的
   * 2：哪些是可以要可以不需要传递的：分别有什么效果
   * 3：启动插件的时候最好用map类型因为我这个插件不需要A插件关联的对象对象只是A插件中东西
   * 4：最好是可以配置哪些是必须要传递的做一个判断是否为空，这样避免在插件内100个地方用到了去做判断，哪些值可以传空的
   * 5：配置校验的值（相当于我启动这个插件需要的值），配置取值，配置子插件需要的值
   */


1:启动dialog参数回调 需要解决：比如部门，比如disptyep=9
