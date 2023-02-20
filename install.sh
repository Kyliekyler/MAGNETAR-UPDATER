print_modname() {
  sleep 1
  echo " "
  echo "=================================================="
  echo "      ⢀⣠⣤⡶⣢⣶⣶⣦⡀"
  echo "   ⢀⣴⡿⠋⠁⠼⢿⡿⠿⣿⣿⣼⣦⡀     M A G N E T A R"
  echo "  ⢀⣾⠏ ⢀⣴⣿⣿⣿⣿⣮⡿⠁⠹⣷⡀   -----------------"
  echo "  ⠸⣫⣶⣇⣿⣿⣿⣿⣿⣿⡿⠿⡀ ⣿⡇   DEV: Kyliekyler"
  echo "  ⢸⣿⣿⡏⣿⣿⣿⣿⢏⣷⣿⣿⣷⣆⢿⡇"
  echo "  ⠈⠿⣿⣿⣮⡿⣿⣟⢾⣿⣿⣿⣿⣿⡞    ░▒░▒░▒░▒░▒░▒░"
  echo "    ⠲⣿⣅⡀  ⠈⠘⢿⣿⣿⣿⠟     ▒░▒░▒░▒░▒░▒░▒"
  echo "      ⠈⠙⠛⠿⠿⠿⠷⠒⠂"
  echo "=================================================="
}

on_install() {
  echo " "
  find /data/adb -type f -name 'module.prop' | while IFS= read -r i; do
    MNAME="$(awk -F'=' '/name=/{print $2}' $i)"
    MDESC="$(awk -F'=' '/description=/{print $2}' $i)"
    if echo "$MNAME" | grep -q 'MAGNETAR' ||  echo "$MDESC" | grep -q 'Device Performance Optimizer'; then
      resetprop magnetar.update initialize
      sleep 1
      magnetar --update ota
      break
    fi
  done
  [ -n "$MODPATH" ] && $BB rm -rf "$MODPATH"
  rm -rf "$TMPDIR"
  exit 0
}
