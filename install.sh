print_modname() {
  $BB sleep 1
  echo " "
  echo "======================================================"
  echo "⠀⠀⠀⠀⠀⢀⣠⣤⡶⣢⣶⣶⣦⡀"
  echo "⠀⠀⠀⢀⣴⡿⠋⠁⠼⢿⡿⠿⣿⣿⣼⣦⡀⠀⠀ ⠀M A G N E T A R"
  echo "⠀⠀⠀⣾⠏⠀⢀⣴⣿⣿⣿⣿⣮⡿⠁⠹⣷⡀  ⠀----------------"
  echo "⠀⠀⠸⣫⣶⣇⣿⣿⣿⣿⣿⣿⡿⠿⠀⠀⣿⡇   DEV: Kyliekyler"
  echo "⠀⠀⢸⣿⣿⡏⣿⣿⣿⣿⢏⣷⣿⣿⣷⣆⢿⡇"
  echo "⠀⠀⠈⠿⣿⣿⣮⡿⣿⣟⢾⣿⣿⣿⣿⣿⡞⠀⠀  ░▒░▒░▒░▒░▒░▒░"
  echo "⠀⠀⠀⠀⠲⣿⣅⡀⠀⠈⠘⢿⣿⣿⣿⠟⠀⠀⠀  ▒░▒░▒░▒░▒░▒░▒"⠀
  echo "⠀⠀⠀⠀⠀⠈⠙⠛⠿⠿⠿⠷⠒⠂"
  echo "======================================================"
}

on_install() {
  echo " "
  for i in /data/adb/*/*/module.prop; do
    MNAME=$(awk -F'=' '/name=/{print $2}' "$i")
    MDESC=$(awk -F'=' '/description=/{print $2}' "$i")
    if echo "$MNAME" | grep -q 'MAGNETAR' ||  echo "$MDESC" | grep -q 'Device Performance Optimizer'; then
      resetprop magnetar.update initialize
      $BB sleep 1
      magnetar --update ota
      break
    fi
  done
  [ -n "$MODPATH" ] && $BB rm -rf "$MODPATH"
  rm -rf "$TMPDIR"
  exit 0
}
