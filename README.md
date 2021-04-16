# FinderToolset

## 介绍

FinderToolset是一款`Finder`扩展插件，为了解决每次都要打开终端才能使用[LYBTools](https://github.com/liyb93/LYBTools.git), 所有就对[LYBTools](https://github.com/liyb93/LYBTools.git)进行修改。

![preview](https://raw.githubusercontent.com/liyb93/FinderToolset/master/preview.png)

## 功能列表

- xml/json转plist
- plist/xml转json
- plist/json转xml
- 图片裁剪圆角，默认尺寸为`20px`
- APP图标生成，支持`iPhone`、`iPad`、`Mac`、`Carplay`、`Watch`、`Android`平台，默认勾选全部平台。
- Xcode缓存清理，只会清理`DerivedData`与`Archives`路径下的文件
- 新建文件，支持`txt`、`rtf`、`plist`、`markdown`文件类型
- 拷贝路径
- 打开终端：支持`iTerm2`、`Terminal`、`Hyper`

## 安装说明

1. 下载项目，进行编译，把生成app移动到应用程序中。
2. 打开`设置`->`扩展`->`Finder扩展`->`FinderToolsetExtension`。
3. 最后，选择需要处理的文件就可以尽情的使用我们的小工具了🥳。

## 使用说明

- 主程序主要用于配置圆角尺寸、图标平台、xcode清理是否移除到废纸篓；无需配置可以关闭。

- xml/plist/json转换：直接选中需要转换的文件，右键菜单点击相关功能即可。

- 裁剪圆角：选择需要裁剪的图片，右键菜单点击切圆角，会根据配置的尺寸进行裁剪在当前路径下生成新图片。

- APP图标生成：选择需要图片，右键菜单点击APP图标生成，会根据配置的平台在当前路径下生成以下结构的文件夹

  ```ruby
  |-- AppIcon
  	|-- Android		// 存放Android平台图标
  		|-- xxx		// 图标及配置文件
  	|-- AppIcon.appiconset	// 存放iPhone、iPad、Mac、Carplay、Watch平台图标
  		|-- xxx		// 图标及配置文件
  ```

- Xcode缓存清理：根据配置会将`DerivedData`与`Archives`移除到废纸篓或直接删除。

- 新建文件：当前文件夹下生成选择的文件

- 拷贝路径：拷贝当前路径或选择文件的路径，支持多选

- 打开终端：从Finder快速打开终端

## 常见问题

- 勾选扩展后，右键菜单未显示。

  - 尝试重新勾选扩展
  - 尝试重启Finder
  - 重启电脑

  

## 参考

[FinderGo:从Finder快速打开终端](https://github.com/onmyway133/FinderGo)