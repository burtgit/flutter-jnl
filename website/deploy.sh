#!/bin/bash

# 领券中心官网部署脚本

echo "🚀 开始部署领券中心官网..."

# 检查必要文件是否存在
if [ ! -f "index.html" ]; then
    echo "❌ 错误: index.html 文件不存在"
    exit 1
fi

if [ ! -f "styles.css" ]; then
    echo "❌ 错误: styles.css 文件不存在"
    exit 1
fi

if [ ! -f "script.js" ]; then
    echo "❌ 错误: script.js 文件不存在"
    exit 1
fi

echo "✅ 所有必要文件检查完成"

# 创建部署目录
DEPLOY_DIR="dist"
if [ -d "$DEPLOY_DIR" ]; then
    echo "🗑️  清理旧的部署目录..."
    rm -rf "$DEPLOY_DIR"
fi

echo "📁 创建新的部署目录..."
mkdir -p "$DEPLOY_DIR"

# 复制文件到部署目录
echo "📋 复制文件到部署目录..."
cp index.html "$DEPLOY_DIR/"
cp styles.css "$DEPLOY_DIR/"
cp script.js "$DEPLOY_DIR/"
cp README.md "$DEPLOY_DIR/"

# 如果存在 favicon.ico，也复制过去
if [ -f "favicon.ico" ]; then
    cp favicon.ico "$DEPLOY_DIR/"
    echo "✅ favicon.ico 已复制"
fi

# 如果存在 netlify.toml，也复制过去
if [ -f "netlify.toml" ]; then
    cp netlify.toml "$DEPLOY_DIR/"
    echo "✅ netlify.toml 已复制"
fi

echo "✅ 文件复制完成"

# 检查是否安装了 http-server 用于本地测试
if command -v http-server &> /dev/null; then
    echo "🌐 启动本地服务器进行测试..."
    echo "📍 访问地址: http://localhost:8080"
    echo "⏹️  按 Ctrl+C 停止服务器"
    cd "$DEPLOY_DIR" && http-server -p 8080
else
    echo "💡 提示: 安装 http-server 可以本地测试网站"
    echo "   npm install -g http-server"
    echo "   然后在 $DEPLOY_DIR 目录下运行: http-server"
fi

echo "🎉 部署准备完成！"
echo "📁 部署文件位于: $DEPLOY_DIR 目录"
echo ""
echo "🚀 部署选项:"
echo "1. 上传 $DEPLOY_DIR 目录到你的服务器"
echo "2. 使用 Netlify: 拖拽 $DEPLOY_DIR 目录到 netlify.com"
echo "3. 使用 Vercel: vercel --prod $DEPLOY_DIR"
echo "4. 使用 GitHub Pages: 推送到 gh-pages 分支"
