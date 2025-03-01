WACOM_STYLUS_ID=$(xsetwacom --list | grep 'type: STYLUS' | grep -Eo '[0-9]+')
xsetwacom --set ${WACOM_STYLUS_ID} Button 2 "button +2 button +1"

