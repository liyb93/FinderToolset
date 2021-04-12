# aToolset
## 介绍

aToolset是一款Mac端简单的右键小工具，是根据[LYBTools](https://github.com/liyb93/LYBTools.git)命令行工具进行修改。

![preview](https://raw.githubusercontent.com/liyb93/aToolset/master/preview.png)

## 功能列表

- xml/json转plist
- plist/xml转json
- plist/json转xml
- 图片裁剪圆角，默认尺寸为`20px`
- APP图标生成，支持`iPhone`、`iPad`、`Mac`、`Carplay`、`Watch`、`Android`平台，默认勾选全部平台。
- Xcode项目缓存清理，只会清理`DerivedData`与`Archives`路径下的文件

## 安装说明

1. 下载项目，进行编译，把生成app移动到应用程序中。
2. 打开设置->扩展->"Finder扩展"->勾选aToolset。
3. 最后，选择需要处理的文件就可以尽情的使用我们的小工具了🥳。

## 使用说明

- xml/plist/json转换直接选中需要转换的文件，右键菜单点击相关功能即可。
- 裁剪圆角如果需要指定圆角尺寸需要在aToolset偏好设置中进行配置，然后选择需要裁剪的图片，右键菜单点击切圆角。
- APP图标生成自定义平台同切圆角一致，需要在偏好设置中进行配置，然后选择需要图片，右键菜单点击APP图标生成。
- Xcode项目缓存清理，快捷清理Xcode编译与打包生成数据。

## 常见问题

- 勾选扩展后，右键菜单未显示。

  可以尝试重启Finder，如果还是不行可以重启电脑进行尝试.

  