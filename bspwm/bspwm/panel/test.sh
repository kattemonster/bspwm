#! /bin/sh
#
# Example panel for LemonBoy's bar

#. panel_colors

num_mon=$(bspc query -M | wc -l)

while read -r line ; do
	case $line in
		S*)
			# clock output
			sys_infos="%{F$COLOR_STATUS_FG}%{B$COLOR_STATUS_BG} ${line#?} %{B-}%{F-}"
			;;
		T*)
			# xtitle output
			title="%{F$COLOR_TITLE_FG}%{B$COLOR_TITLE_BG} ${line#?} %{B-}%{F-}"
			;;
		W*)
			# bspwm internal state
			wm_infos=""
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ] ; do
				item=$1
				name=${item#?}
				case $item in
					M*)
						# active monitor
						if [ $num_mon -gt 1 ] ; then
							wm_infos="$wm_infos %{F$COLOR_ACTIVE_MONITOR_FG}%{B$COLOR_ACTIVE_MONITOR_BG} ${name} %{B-}%{F-}  "
						fi
						;;
					m*)
						# inactive monitor
						if [ $num_mon -gt 1 ] ; then
							wm_infos="$wm_infos %{F$COLOR_INACTIVE_MONITOR_FG}%{B$COLOR_INACTIVE_MONITOR_BG} ${name} %{B-}%{F-}  "
						fi
						;;
					O*)
						# focused occupied desktop
						wm_infos="${wm_infos}%{F$COLOR_FOCUSED_OCCUPIED_FG}%{B$COLOR_FOCUSED_OCCUPIED_BG}%{U$COLOR_FOREGROUND}%{+u} ${name} %{-u}%{B-}%{F-}"
						;;
					F*)
						# focused free desktop
						wm_infos="${wm_infos}%{F$COLOR_FOCUSED_FREE_FG}%{B$COLOR_FOCUSED_FREE_BG}%{U$COLOR_FOREGROUND}%{+u} ${name} %{-u}%{B-}%{F-}"
						;;
					U*)
						# focused urgent desktop
						wm_infos="${wm_infos}%{F$COLOR_FOCUSED_URGENT_FG}%{B$COLOR_FOCUSED_URGENT_BG}%{U$COLOR_FOREGROUND}%{+u} ${name} %{-u}%{B-}%{F-}"
						;;
					o*)
						# occupied desktop
						wm_infos="${wm_infos}%{F$COLOR_OCCUPIED_FG}%{B$COLOR_OCCUPIED_BG} ${name} %{B-}%{F-}"
						;;
					f*)
						# free desktop
						wm_infos="${wm_infos}%{F$COLOR_FREE_FG}%{B$COLOR_FREE_BG} ${name} %{B-}%{F-}"
						;;
					u*)
						# urgent desktop
						wm_infos="${wm_infos}%{F$COLOR_URGENT_FG}%{B$COLOR_URGENT_BG} ${name} %{B-}%{F-}"
						;;
					L*)
						# layout
						wm_infos="$wm_infos  %{F$COLOR_LAYOUT_FG}%{B$COLOR_LAYOUT_BG} ${name} %{B-}%{F-}"
						;;
				esac
				shift
			done
			;;
	esac
	printf "%s\n" "%{l}${wm_infos}%{c}${title}%{r}${sys_infos}"
done
