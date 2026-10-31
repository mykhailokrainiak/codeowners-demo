#!/usr/bin/env bash
# Показує власника кожного файлу за правилами .github/CODEOWNERS (спрощено: останнє збіжне правило)
set -euo pipefail
rules=$(grep -vE '^\s*(#|$)' .github/CODEOWNERS)
git ls-files | while read -r f; do
  owner="(немає)"; rule="-"
  while read -r pat owners; do
    p="${pat#/}"
    case "$pat" in
      \*) match=1 ;;
      */) [[ "$f" == "$p"* ]] && match=1 || match=0 ;;
      \*.*) [[ "$f" == *"${pat#\*}" ]] && match=1 || match=0 ;;
      *) [[ "$f" == "$p" ]] && match=1 || match=0 ;;
    esac
    [ "$match" = 1 ] && { owner="$owners"; rule="$pat"; }
  done <<< "$rules"
  printf '%-32s %-12s %s\n' "$f" "$rule" "$owner"
done
