#!/bin/bash

message=$1
message="${message// /_}"           # prints 'The secret code is XXXXX'
message="${message//Ä/Ae}"
message="${message//Ö/Oe}"
message="${message//Ü/Ue}"
message="${message//ä/ae}"
message="${message//ö/oe}"
message="${message//ü/ue}"
message="${message//ß/ss}"
message="${message//[^0-9a-zA-Z_\-.+]}"
today=$(date +%y%y-%m-%d)
now=$(date +'%y%y-%m-%d %H:%M')
cat > "Content/posts/${today}_${message}.md" << EOL
---
date: ${now}
description:
tags: link
title: $1
detailsTitle: [$1]($2)
---
EOL
editor_path="/Applications/Pine.app/Contents/MacOS/Pine"
editor_cmd="${editor_path} Content/posts/${today}_${message}.md"

if test -f "${editor_path}"; then
    $editor_cmd &
else
    edit "Content/posts/${today}_${message}.md"
fi
