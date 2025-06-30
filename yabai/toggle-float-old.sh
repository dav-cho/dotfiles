#!/usr/bin/env bash

# float
# --grid <rows>:<cols>:<start-x>:<start-y>:<width>:<height>
# --move abs|rel:<dx>:<dy>
# --resize top|left|bottom|right|top_left|top_right|bottom_right|bottom_left|abs:<dx>:<dy>

floating=$(yabai -m query --windows --window | jq '."is-floating"')

if [ "$floating" = "false" ]; then
  yabai -m window --toggle float
fi

# case "$1" in
# -g | --grid)
#   yabai -m window --grid $2
#   ;;
# --grid=*)
#   yabai -m window --grid ${1#*=}
#   ;;
# -r | --resize)
#   yabai -m window --resize $2
#   ;;
# --resize=*)
#   yabai -m window --resize ${1#*=}
#   ;;
# esac

########################################################################################

if [ $# - eq 0 ]; then
  exit 0
fi

display=$(yabai -m query --displays --window | jq -r '.frame')
# dimensions=$(jq --argjson display "$display" -nr '"\($display.w | floor):\($display.h | floor)"')
# echo $dimensions

# main:  2560:1440
# right: 3440:1440
# right: 1440:3440 (vertical)

# aspect_ratio=$(jq --argjson display "$display" -nr '
#   ($display.w / $display.h) as $ratio |
#   if ($ratio >= 1.77 and $ratio <= 1.78) then "16:9"    # 16:9 aspect ratio
#   elif ($ratio >= 2.33 and $ratio <= 2.34) then "21:9"  # 21:9 aspect ratio
#   elif ($ratio >= 1.33 and $ratio <= 1.34) then "4:3"   # 4:3 aspect ratio
#   else "unknown"                                        # Unknown aspect ratio
#   end
# ')
# echo $aspect_ratio

aspect_ratio=$(
  jq --argjson display "$display" -nr '
  ($display.w / $display.h) as $ratio |
  if $display.h < $display.w then
      if ($ratio >= 1.77 and $ratio <= 1.78) then "16:9"
      elif ($ratio >= 2.33 and $ratio <= 2.34) then "21:9"
      else "unknown-landscape"
      end
  else
      if ($ratio >= 0.41 and $ratio <= 0.42) then "21:9-portrait"
      elif ($ratio >= 0.56 and $ratio <= 0.57) then "16:9-portrait"
      else "unknown-portrait"
      end
  end'
)

# --grid <rows>:<cols>:<start-x>:<start-y>:<width>:<height>
# --move abs|rel:<dx>:<dy>
# --resize top|left|bottom|right|top_left|top_right|bottom_right|bottom_left|abs:<dx>:<dy>

case "$1" in
"grid")
  case "$2:$3:$aspect_ratio" in

  # TODO: combine aspect ratios
  "xl:left:16:9")
    grid="1:6:0:0:4:1"
    ;;
  "xl:left:16:9-portrait")
    grid="6:1:0:0:1:4"
    ;;
  "xl:left:21:9")
    grid="1:15:0:0:7:1"
    ;;
  "xl:left:21:9-portrait")
    grid="15:1:0:0:1:7"
    ;;
  "xl:center:16:9")
    grid="1:6:1:0:4:1"
    ;;
  "xl:center:16:9-portrait")
    grid="6:1:0:1:1:4"
    ;;
  "xl:center:21:9")
    grid="1:15:4:0:7:1"
    ;;
  "xl:center:21:9-portrait")
    grid="15:1:0:4:1:7"
    ;;
  "xl:right:16:9")
    grid="1:6:2:0:4:1"
    ;;
  "xl:right:16:9-portrait")
    grid="6:1:0:2:1:4"
    ;;
  "xl:right:21:9")
    grid="1:15:8:0:7:1"
    ;;
  "xl:right:21:9-portrait")
    grid="15:1:0:8:1:7"
    ;;

  "third:left:16:9" | "third:left:21:9")
    grid="1:3:0:0:1:1"
    ;;
  "third:left:16:9-portrait" | "third:left:21:9-portrait")
    grid="3:1:0:0:1:1"
    ;;
  "third:center:16:9" | "third:center:21:9")
    grid="1:3:1:0:1:1"
    ;;
  "third:center:16:9-portrait" | "third:center:21:9-portrait")
    grid="3:1:0:1:1:1"
    ;;
  "third:right:16:9" | "third:right:21:9")
    grid="1:3:2:0:1:1"
    ;;
  "third:right:16:9-portrait" | "third:right:21:9-portrait")
    grid="3:1:0:2:1:1"
    ;;

  "half:left:16:9" | "half:left:21:9")
    grid="1:2:0:0:1:1"
    ;;
  "half:left:16:9-portrait" | "half:left:21:9-portrait")
    grid="2:1:0:0:1:1"
    ;;
  "half:center:16:9" | "half:center:21:9")
    grid="1:4:1:0:2:1"
    ;;
  "half:center:16:9-portrait" | "half:center:21:9-portrait")
    grid="4:1:0:1:1:2"
    ;;
  "half:right:16:9" | "half:right:21:9")
    grid="1:2:1:0:1:1"
    ;;
  "half:right:16:9-portrait" | "half:right:21:9-portrait")
    grid="2:1:0:1:1:1"
    ;;

  esac
  yabai -m window --grid $grid
  ;;

# # TODO
# "abs")
#   w=$3
#   h=$4
#   case "$2:$3" in
#   "s:landscape")
#     w=1133
#     h=825
#     # resize="abs:1133:825"
#     ;;
#   "m:landscape")
#     w=1333
#     h=1025
#     # resize="abs:1333:1025"
#     ;;
#   "l:landscape")
#     w=1533
#     h=1225
#     # resize="abs:1533:1225"
#     ;;
#   esac
#   coords="$(
#     jq \
#       --argjson window "" \
#       --argjson display "${display}" \
#       -nr '($display.x + ($display.w - $window.w) / 2 | tostring)
#             + ":"
#             + ($display.y + ($display.h - $window.h) / 2 | tostring)'
#   )"
#   yabai -m window --resize $resize
#   ;;

# --grid=*)
#   # TODO
#   ;;
# -r | --resize)
#   yabai -m window --resize $2
#   ;;
# --resize=*)
#   yabai -m window --resize ${1#*=}
#   ;;

esac

## WIP #################################################################################

# aspect_ratio=$(
#   jq --argjson display "$display" -nr '
#   (if $display.w > $display.h then
#       ($display.w / $display.h)
#   else
#       ($display.h / $display.w)
#   end) |
#   (. * 100 | round) / 100 as $ratio |
#   $ratio
#   '
# )

# echo $aspect_ratio

# --grid <rows>:<cols>:<start-x>:<start-y>:<width>:<height>
# --move abs|rel:<dx>:<dy>
# --resize top|left|bottom|right|top_left|top_right|bottom_right|bottom_left|abs:<dx>:<dy>

# case "$1:$aspect_ratio" in
# 'grid:16:9')
#   echo $2 | jq
#   ;;
# 'grid:21:9')
#   echo $2 | jq
#   ;;
# esac

# case "$1" in
# 'grid')
#   shift
#   for template in "$@"; do
#     aspect="${template%%-*}"
#     grid="${template#*-}"
#     echo "$aspect - $grid"
#     # if [ "$aspect_ratio" == *'-portrait']; then
#     # fi
#   done
#   ;;
# esac

# landscape: 1:6:0:0:4:1
# portrait:  6:1:0:0:1:4

# if [ $aspect_ratio == *'-portrait' ]; then
# fi

# input="1:6:0:0:4:1"
# output=$(echo "$input" | awk -F: '{print $2":"$6":"$3":"$4":"$1":"$5}')
# echo "$output"

# yabai -m window --toggle float

# for template in "$@"; do
#   # Split aspect ratio and grid part
#   aspect_grid="${template%%-*}"
#   grid="${template#*-}"
#
#   # If aspect ratio matches
#   if [[ "$aspect_ratio" == "$aspect_grid" ]]; then
#     # Reverse grid coordinates if portrait mode
#     if [[ "$aspect_ratio" == *-portrait ]]; then
#       IFS=":" read -r rows cols start_x start_y width height <<< "$grid"
#       grid="$cols:$rows:$start_y:$start_x:$height:$width"
#     fi
#     yabai -m window --grid "$grid"
#     exit 0
#   fi
# done

# output=$(echo "$input" | cut -d: -f2,6,3,4,1,5 --output-delimiter=":")
# echo "$output"

# grids='{
#   "xl": {
#     "left": {
#       "16:9": "1:6:0:0:4:1",
#       "16:9-portrait": "6:1:0:0:1:4",
#       "21:9": "1:15:0:0:7:1",
#       "21:9-portrait": "15:1:0:0:1:7"
#     },
#     "center": {
#       "16:9": "1:6:1:0:4:1",
#       "16:9-portrait": "6:1:0:1:1:4",
#       "21:9": "1:15:4:0:7:1",
#       "21:9-portrait": "15:1:0:4:1:7"
#     },
#     "right": {
#       "16:9": "1:6:2:0:4:1",
#       "16:9-portrait": "6:1:0:2:1:4",
#       "21:9": "1:15:8:0:7:1",
#       "21:9-portrait": "15:1:0:8:1:7"
#     }
#   },
#   "third": {
#     "left": {
#       "16:9": "1:3:0:0:1:1",
#       "16:9-portrait": "3:1:0:0:1:1",
#       "21:9": "1:3:0:0:1:1",
#       "21:9-portrait": "3:1:0:0:1:1"
#     },
#     "center": {
#       "16:9": "1:3:1:0:1:1",
#       "16:9-portrait": "3:1:0:1:1:1",
#       "21:9": "1:3:1:0:1:1",
#       "21:9-portrait": "3:1:0:1:1:1"
#     },
#     "right": {
#       "16:9": "1:3:2:0:1:1",
#       "16:9-portrait": "3:1:0:2:1:1",
#       "21:9": "1:3:2:0:1:1",
#       "21:9-portrait": "3:1:0:2:1:1"
#     }
#   }
# }'
