# Verified Project Management (VPM) — PRD v0.1

## 一句话定位

VPM 是 AI agent 协作项目的目标层可信化框架：让"验收线对准真实价值"这件事变成可安装、可执行、可被社区持续完善的工程规范。

## 背景与问题

Harness Engineering 解决"agent 需要什么运行环境"，Loop Engineering 解决"循环怎么收敛"，但两者都假设目标已经是对的。现实中项目失败的最常见模式不是执行失败，而是：

- 工程健康线全绿，但产品价值线从未被定义或执行
- PRD 升级了，验收标准没跟着升级，一直对旧目标打分
- 核心还没站稳，外壳已经做完了

VPM 填补这个空白。来源：三个真实项目复盘（东方名片·失败、K12课程·成功、Lite DL Studio·成功）。

## 目标用户

- 用 Claude Code / Codex / Cursor 等 agent 工具做复杂项目的独立开发者
- 管理 AI 协作团队的技术负责人
- 对 agent 工程方法论感兴趣的研究者和贡献者

## 四个里程碑

### M0 · v0 本地配置（当前）
- AGENTS.md + check_gates.sh + /start-project skill + 一键安装脚本
- 在 Claude Code + Codex 上验证可运行
- 产出：可安装的落地套件

### M1 · GitHub 仓库建立
- 仓库结构：框架文档 + 落地套件 + 复盘案例 + 贡献模板
- README 以东方名片案例为核心故事
- 产出：可被他人 fork、安装、贡献的开源仓库

### M2 · 理论文档
- 核心论文/文章：为什么 agent loop 跑得很好但项目还是偏
- 三层嵌套模型（Harness / Loop / VPM）的正式描述
- 真实案例数据支撑（sim:user 12/12 vs test:experience 0/8）
- 产出：英文 + 中文双语理论文档

### M3 · 发布推广
- 渠道：GitHub + X/Twitter + HN + 中文社区（即刻/少数派）
- 与 Superpowers 社区的对话切入
- 产出：社区讨论、贡献者、框架迭代

## 核心不变量

1. VPM 不替代 Harness 或 Loop Engineering，它是外层治理
2. 所有规则必须来自真实项目复盘，不从理论推导
3. 每条规则必须有对应的可执行检查项，不能只是建议
4. 框架本身用自己的规则开发（吃自己的狗粮）
