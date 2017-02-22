# easeui-ios


环信iOS easeui  CocoaPod repo

从3.1.1开始, 小伙伴们可以使用 Cocoapods 来集成环信3.0SDK版本的easeui啦, 集成方法如下:

1. Podfile 文件添加如下代码

		pod 'EaseUI', :git =>'https://github.com/easemob/easeui-ios-hyphenate-cocoapods.git'
		
2. 使用时, 需要引入头文件, 在 pch 预编译文件中, 引入头文件如下:

		#import <EaseUI/EaseUI.h>
		
接下来, 就可以正常使用环信的所有功能啦.
具体的使用步骤可以参考我们的官方文档: [集成文档](http://docs.easemob.com/im/300iosclientintegration/85easeuiguide)

注意: 由于SDK改成了动态库,EaseUI引入的头文件Full版本和Lite版本不同,导致集成EaseUI失败,所以如果集成Lite版本SDK,建议使用

		pod 'EaseUILite', :git =>'https://github.com/easemob/easeui-ios-hyphenate-cocoapods.git'
		
		//引入头文件
		#import <EaseUILite/EaseUI.h>