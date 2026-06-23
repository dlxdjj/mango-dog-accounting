# 小小雷记账 V3.0

和小芒狗一起好好记账～ 🐕

## 简介

单文件 PWA 记账应用，纯 HTML/CSS/JS，零依赖，数据存本地 localStorage，部署在 GitHub Pages。

## 功能

- **语音 / 文字记账** — 自然语言输入，AI 自动区分收支一键记账
- **AI 对话查询** — 问「本月奶茶花了多少」，AI 直接回答
- **日历视图** — 收支双色显示，点某天看当天明细，点分类看日期分布
- **分析视图** — 收支总览 + 储蓄率、近 6 月趋势、分类环比、支付方式 & 信用待还
- **每日预算** — 超支触发体能惩罚，达标可领奖励
- **结算仪式** — 每日结束记账回顾
- **连续打卡** — 3/7/14/30/60/100 天里程碑庆祝
- **月度复盘** — AI 生成朋友聊天风分析报告
- **年度报告** — 全年统计 + AI 年度评语
- **专属小人** — 根据记账状态切换头像（达标/进账/超支/大额消费/日常）
- **数据导入导出** — JSON 格式备份恢复
- **Supabase 云同步** — 登录后自动同步，离线也能记

## 使用方式

### 本地运行

```bash
python -m http.server 8080
# 打开 http://localhost:8080
```

### 部署到 GitHub Pages

推送 `main` 分支，GitHub Pages 自动部署。

### Supabase 云同步

1. 在 [supabase.com](https://supabase.com) 创建项目
2. SQL Editor 执行 `supabase-schema.sql`
3. Authentication → Providers → Email 开启
4. 将 URL 和 Anon Key 填入 `index.html` 顶部的 `SUPABASE_URL` 和 `SUPABASE_ANON_KEY`
5. Authentication → URL Configuration → Redirect URLs 添加你的域名

## 技术架构

| 层 | 技术 |
|---|---|
| 前端 | 单文件 HTML/CSS/JS，约 5200 行 |
| AI | DeepSeek V4-Flash API |
| 存储 | localStorage（本地）+ Supabase（云端） |
| 认证 | Supabase Magic Link |
| 部署 | GitHub Pages |

## 数据安全

- Anon Key 在前端公开，安全靠 Supabase RLS（Row Level Security）
- 每个用户只能访问自己的数据：`auth.uid() = user_id`
- Service Role Key 不在前端代码中
- 本地数据完全由用户控制

## 开发

```bash
git clone https://github.com/dlxdjj/mango-dog-accounting.git
cd mango-dog-accounting
python -m http.server 8080
```
