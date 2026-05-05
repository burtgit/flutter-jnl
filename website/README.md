# 领券中心官网

这是领券中心应用的官方网站，展示应用的功能特色、优惠分类和下载链接。

## 功能特色

- 🎨 **现代化设计**: 采用渐变色彩和流畅动画
- 📱 **响应式布局**: 完美适配桌面端和移动端
- ⚡ **性能优化**: 使用 Intersection Observer API 和防抖技术
- 🎯 **用户体验**: 平滑滚动、动画效果和交互反馈
- 📞 **客服集成**: 一键复制微信号功能

## 网站结构

```
website/
├── index.html          # 主页面
├── styles.css          # 样式文件
├── script.js           # JavaScript 功能
├── README.md           # 说明文档
└── favicon.ico         # 网站图标（需要添加）
```

## 页面内容

### 1. 导航栏
- 固定顶部导航
- 响应式移动端菜单
- 平滑滚动到对应部分

### 2. 首页横幅 (Hero Section)
- 吸引人的标题和描述
- 手机模型展示应用界面
- 统计数据动画
- 下载按钮

### 3. 功能特色 (Features)
- 6个核心功能介绍
- 图标和描述
- 悬停动画效果

### 4. 优惠分类 (Categories)
- 4个主要分类：饿了么、美团、出行服务、生活服务
- 每个分类的特色标签
- 不同的主题色彩

### 5. 下载区域 (Download)
- Android APK 下载
- iOS App Store（即将上线）
- 二维码下载

### 6. 联系我们 (Contact)
- 微信客服（可复制微信号）
- 邮箱联系
- 工作时间

### 7. 页脚 (Footer)
- 品牌信息
- 相关链接
- 版权信息

## 自定义配置

### 修改联系信息
在 `index.html` 和 `script.js` 中修改以下内容：

```html
<!-- 微信号 -->
<p>YourWeChatID</p>

<!-- 邮箱 -->
<p>contact@example.com</p>
```

```javascript
// 微信号
const wechatId = 'YourWeChatID';
```

### 修改下载链接
在 `script.js` 中修改下载按钮的处理逻辑：

```javascript
androidBtn.addEventListener('click', function(e) {
    e.preventDefault();
    // 替换为实际的下载链接
    window.open('your-apk-download-link', '_blank');
});
```

### 添加网站图标
将 `favicon.ico` 文件放在 `website` 目录下，或者修改 HTML 中的图标链接。

### 修改颜色主题
在 `styles.css` 中修改 CSS 变量或直接修改颜色值：

```css
/* 主色调 */
.nav-brand { color: #ff6b35; }
.btn-primary { background: #ff6b35; }

/* 渐变色 */
.hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
```

## 部署说明

### 1. 静态网站托管
可以部署到以下平台：
- GitHub Pages
- Netlify
- Vercel
- 阿里云 OSS
- 腾讯云 COS

### 2. 服务器部署
将所有文件上传到服务器的 web 目录即可。

### 3. CDN 加速
建议使用 CDN 来加速静态资源的加载。

## 浏览器兼容性

- Chrome 60+
- Firefox 55+
- Safari 12+
- Edge 79+
- 移动端浏览器

## 性能优化

- 使用了 Intersection Observer API 进行懒加载
- 防抖技术优化滚动事件
- CSS 动画使用 transform 和 opacity
- 图片懒加载支持（需要添加图片时）

## 开发建议

1. **添加真实图片**: 替换手机模型中的应用截图
2. **SEO 优化**: 添加更多 meta 标签和结构化数据
3. **分析工具**: 集成 Google Analytics 或其他分析工具
4. **A/B 测试**: 测试不同的 CTA 按钮和布局
5. **多语言支持**: 如需要可添加国际化支持

## 维护更新

定期更新以下内容：
- 应用截图和功能介绍
- 下载统计数据
- 联系方式
- 新功能介绍

## 技术栈

- HTML5
- CSS3 (Flexbox, Grid, Animations)
- Vanilla JavaScript (ES6+)
- Font Awesome 图标
- Google Fonts

## 许可证

本项目仅供学习和参考使用。
