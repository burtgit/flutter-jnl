#!/bin/sh

# 1. 返回到项目根目录
cd ..

# 2. 下载并安装 Flutter (Xcode Cloud 默认没装 Flutter)
git clone https://github.com/flutter/flutter.git -b stable $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

# 3. 预下载 Flutter 依赖
flutter precache --ios

# 4. 获取项目依赖
flutter pub get

# 5. 安装 CocoaPods 依赖
# Xcode Cloud 默认路径在项目根目录，我们需要进入 ios 文件夹执行 pod
cd ios
pod install

exit 0