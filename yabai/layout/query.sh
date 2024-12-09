#!/usr/bin/env bash

# cols='[
#   "id",
#   "app",
#   "display",
#   "space",
#   "level",
#   "sub-level",
#   "split-type",
#   "split-child",
#   "stack-index",
#   "can-move",
#   "can-resize",
#   "is-floating"
# ]'

cols='[
  "id",
  "app",
  "split-type",
  "split-child",
  "stack-index",
  "can-move",
  "can-resize",
  "is-floating"
]'

jq -r --argjson cols "$cols" '
  ($cols), (.[] | [ $cols[] as $col | .[$col] ]) | @tsv
' socials.json | column -t
