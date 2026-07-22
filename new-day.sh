#!/usr/bin/env bash
# 오늘 날짜 스터디 로그 파일을 생성하고 README 진행 현황 표에 행을 추가한다.
set -euo pipefail
cd "$(dirname "$0")"

DATE=$(date +%F)                # 2026-07-14
MONTH=$(date +%Y-%m)            # 2026-07
DAYNAMES=(월 화 수 목 금 토 일)
DOW=${DAYNAMES[$(($(date +%u) - 1))]}
FILE="$MONTH/$DATE.md"

if [[ -f "$FILE" ]]; then
  echo "이미 오늘 파일이 있어요: $FILE"
  exit 0
fi

# Day 번호 = 시작일(2026-07-13 = Day 1)부터의 경과일 + 1
# 로그 개수로 세면 하루라도 건너뛰었을 때 실제 날짜와 어긋난다.
START=2026-07-13
START_EPOCH=$(date -j -f "%Y-%m-%d" "$START" "+%s")
TODAY_EPOCH=$(date -j -f "%Y-%m-%d" "$DATE" "+%s")
N=$(( (TODAY_EPOCH - START_EPOCH) / 86400 + 1 ))

mkdir -p "$MONTH"

cat > "$FILE" <<EOF
# Day $N — $DATE ($DOW)

- ⏱️ 공부 시간: HH:MM ~ HH:MM (00분)
- 📚 강의: 하네스 강의 — 섹션 0. 제목

## 오늘 배운 것

-
EOF

echo "| $N | $DATE ($DOW) |  |  | [📝]($FILE) |" >> README.md

echo "생성 완료: $FILE (Day $N)"
