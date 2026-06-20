# 开发指南

## 项目结构

```
index.html          ← 整个 App 唯一文件，约 5400 行
manifest.json       ← PWA 配置
supabase-schema.sql ← 数据库建表 SQL（仅在 Supabase SQL Editor 执行一次）
icon-*.png          ← PWA 桌面图标
about-icon.jpg      ← 设置页关于区图片
avatar-*.png        ← 小人状态头像
mango.png           ← 通用吉祥物
```

## 核心原则

### 1. 只加不删

所有改动在现有代码上「加」和「挪」，**不删、不重写已有功能**。以下功能和行为必须 100% 保留：

- 所有分类的芒狗手绘贴纸图标（IMG 映射），禁止用 emoji 或任何其它图替换
- `showDayDetail()` — 点某天看当天明细
- `showCategoryDetail()` — 点分类看日期分布
- AI 对话查询、搜索、语音输入、结算仪式、月度复盘、年度报告
- 连续打卡、每日预算、数据导入导出
- 配色与字体沿用 `:root` 现有 token

### 2. 本地优先

- 数据永远先写 localStorage，再后台同步到 Supabase
- 同步是 fire-and-forget，绝不阻塞记账
- 未登录时所有功能正常用本地数据

### 3. Git 规范

- 提交者：`dlxdjj`
- Commit message 用中文，简洁描述改了什么
- 不要 `Co-Authored-By` 署名
- 每个独立改动单独提交

## 设计约束

### 颜色 Token（`:root`，勿改）

```
--bg: #FFFAF0    --mango: #FFD56B    --income: #7CB85F
--paper: #FFFFFF  --mango-deep: #F5BA3A  --expense: #E66565
--ink: #6B5544    --sprout: #B8DD8E
```

### 字体

```
--font-cute: 'ZCOOL KuaiLe'    ← 标题/数字
--font-body: 'PingFang SC'     ← 正文
```

### 吉祥物命名

- 顶栏主标题：**小小塔**
- AI 对话人设：**小芒狗**
- 设置页签名：**小小雷记账 V3.0**
- 日常文案中自称：**小芒狗**

三者互不冲突，各司其职。

## 添加新功能检查清单

- [ ] 数据先写 localStorage 了吗？
- [ ] sync 调用在 `saveBillsToStorage()` **之后**吗？
- [ ] sync 是 fire-and-forget（不加 `await`）吗？
- [ ] 新 HTML 元素在设置页 `page-settings`、统计页 `page-stats`、首页 `page-home` 哪个页面里？
- [ ] CSS 用了 `:root` 里的 token 变量吗？
- [ ] 用了 `formatMoney()` / `formatMoneyShort()` / `formatDate()` 这些已有工具函数吗？
- [ ] 用到芒狗贴纸时用的是 `IMG[cfg.img]` 而不是 emoji 吗？
- [ ] 新按钮加了 `haptic()` 触感反馈吗？
- [ ] 同步相关的函数变量名是 `sb`（不是 `supabase`）吗？

## Supabase 配置

```javascript
// index.html 顶部，由仓库作者手动填入
const SUPABASE_URL = 'https://xxx.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGci...';
```

- Anon Key 可公开，安全靠 RLS
- Service Role Key **禁止**出现在前端代码
- SQL 变更去 Supabase SQL Editor 执行，不要写在代码里

## iOS PWA 注意事项

- PWA 和 Safari 的 localStorage **完全隔离**
- 登录必须先在 Safari 完成，再添加到主屏幕
- PWA 桌面图标：`icon-192.png` + `icon-512.png`

## 部署

```bash
git add index.html
git commit -m "改动说明"
git push origin main
# GitHub Pages 自动从 main 分支部署
```
