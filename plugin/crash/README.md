一个简易版极光Bugly SDK的Flutter插件，支持Crash和Dart异常消息上报。


使用方法：

```
dependencies:
  crash:
    git:
      url: https://github.com/yanchunlan/fluttersample/plugin/crash.git
```

配置Bugly App：

在[Bugly](https://bugly.qq.com/v2/workbench/apps) 为android、iOS各增加一个App配置，获取对应的app key。


Dart：

```
//初始化
if(Platform.isAndroid){
  Crash.setUp('Android app id');
}else if(Platform.isIOS){
  Crash.setUp('iOS app id');
}

//Dart异常上报
Crash.postException(error, stackTrace);

```

Android：

在android目录下App的`build.gradle`文件中增加下列代码，设置ndk支持架构：

```
 defaultConfig {
     ...
     ndk {
         abiFilters 'armeabi', 'armeabi-v7a', 'arm64-v8a'
    }

  }
```

如果你需要适配Android P，请在res/xml目录下新增network_security_config.xml：

```
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">android.bugly.qq.com</domain>
    </domain-config>
</network-security-config>
```
然后在AndroidManifest.xml中新增网络安全配置：

```
<application
  ...
  android:networkSecurityConfig="@xml/network_security_config"
  ...
  >
</application>

```


iOS：

没有多余的配置工作


