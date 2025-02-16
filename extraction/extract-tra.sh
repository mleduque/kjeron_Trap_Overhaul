#!/usr/bin/env bash
set -x

VERSION_SUFFIX='mle'
RED='\033[0;31m'

if ! type "rg" > /dev/null; then
  echo "${RED}This requires ripgrep(rg) on the PATH."
  echo "Either install with your package manager, e.g.\n  sudo apt install ripgrep\nor\nsudo dnf install ripgrep"
  echo "Or use cargo install ripgrep (and mek sure it'son the PATH)"
  exit 1
fi

echo "ripgrep is available"

rm Trap_Overhaul/tra/english/string.tra
rm Trap_Overhaul/setup-Trap_Overhaul.tp2

regex=`cat extraction/regex`

echo "creating Trap_Overhaul/tra/strings.tra"
mkdir -p Trap_Overhaul/tra/english
rg -U --multiline-dotall "$regex" setup-Trap_Overhaul.tp2 -r '${content}' >Trap_Overhaul/tra/english/strings.tra

language=`cat extraction/language-fragment.tpa`

echo "creating Trap_Overhaul/setup-Trap_Overhaul.tp2"
rg -U --multiline-dotall "$regex" setup-Trap_Overhaul.tp2 -r '${before_version}VERSION~${version}-'${VERSION_SUFFIX}'~

	${before_tra}${end_always}'"$language"'

	${first_begin}${rest}' > Trap_Overhaul/setup-Trap_Overhaul.tp2

echo deleting setup-TrapOverhaul.tp2
rm setup-Trap_Overhaul.tp2

