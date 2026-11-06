#!/usr/bin/env bash
# 把 claude-config/ 里的文件安装到 ~/.claude/
# 用法：bash claude-config/install.sh
set -euo pipefail

src="$(cd "$(dirname "$0")" && pwd)"
dst="${HOME}/.claude"

mkdir -p "$dst/skills/self-improve"

copy() {
  local from="$1" to="$2"
  if [ -e "$to" ] && ! cmp -s "$from" "$to"; then
    cp "$to" "$to.bak"
    echo "已有 $to，旧版本备份为 $to.bak"
  fi
  cp "$from" "$to"
  echo "已安装 $to"
}

copy "$src/CLAUDE.md" "$dst/CLAUDE.md"
copy "$src/skills/self-improve/SKILL.md" "$dst/skills/self-improve/SKILL.md"

# feedback.md 是日志，已存在就不覆盖
if [ -e "$dst/feedback.md" ]; then
  echo "已有 $dst/feedback.md，保留不动"
else
  cp "$src/feedback.md" "$dst/feedback.md"
  echo "已安装 $dst/feedback.md"
fi
