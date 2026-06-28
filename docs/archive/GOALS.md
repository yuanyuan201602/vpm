> 已归档 · 此为 v0.1 旧规划(建仓库/装套件的 M0-M3),已被 v1 架构(三人团队 + 五段流程)取代。仅作历史记录。

# VPM 目标清单 v0.1

## 当前里程碑：M0 · 本地配置

### 目标 M0-1：Claude Code 完整安装验证
- 核心点：安装脚本在真实 ~/.claude 环境运行，SessionStart 注入可见，PreToolUse 闸门生效
- 完成判据：新会话看到预检；Bash 动作前 check_gates.sh 自动运行
- 状态：落地套件已生成（沙盒验证通过），待真实环境验证

### 目标 M0-2：Superpowers 安装与接线确认
- 核心点：两层钩子并行不冲突，AGENTS.md 优先级高于 Superpowers skill
- 完成判据：/plugin install 成功；新会话两段注入都出现；AGENTS.md 规则不被 Superpowers 覆盖
- 状态：待执行

### 目标 M0-3：AGENTS.md 占位填写
- 核心点：把 <fill: ...> 换成 VPM 项目自身的确切命令
- 完成判据：check_gates.sh 闸门 2 取消注释并运行通过
- 状态：待执行

---

## 下一里程碑：M1 · GitHub 仓库

### 目标 M1-1：仓库结构设计
- 核心点：让陌生人能在 30 分钟内 fork + 安装 + 理解
- 交付物：仓库骨架 + 每个目录的 README

### 目标 M1-2：README 主文档
- 核心点：以东方名片失败案例为核心故事，sim:user 12/12 vs test:experience 0/8 是主 hook
- 交付物：英文 README.md + 中文 README_ZH.md

### 目标 M1-3：落地套件整理发布
- 核心点：把现有 install.sh + AGENTS.md + check_gates.sh 整理成仓库的 /install 目录
- 交付物：可直接 curl | bash 安装的发布版本

### 目标 M1-4：复盘案例文档（东方名片）
- 核心点：原始复盘数据 + VPM 视角的分析 + "如果用了 VPM 会怎样"的对照
- 交付物：/cases/dongfang-namecard/README.md

### 目标 M1-5：贡献模板
- 核心点：让第一次贡献者知道该提交什么
- 交付物：CONTRIBUTING.md + /cases/TEMPLATE.md

---

## 一致性记忆层

### 术语表（GLOSSARY.md）
| 术语 | 定义 |
|------|------|
| 工程健康线 | 能跑/能构建/能通过烟测——必要条件，不是完成判据 |
| 产品价值线 | 是否实现了 PRD 承诺的价值——唯一闸门 |
| 目标漂移 | agent 在执行中静默改变目标方向的失败模式 |
| 冻结旧线 | PRD 变更时，把旧 schema/产物标记 legacy 的强制动作 |
| 验收锁定 | PRD 与验收标准共享版本号、捆绑改版 |
| VPM | Verified Project Management，本框架全称 |

### 不变量表（INVARIANTS.md）
1. 框架所有规则必须来自真实复盘，不从理论推导
2. 每条规则必须有对应的可执行检查项
3. VPM 是外层治理，不替代 Harness/Loop Engineering
4. 框架本身用自己的规则开发（验收标准对准 VPM 自身承诺的价值）
