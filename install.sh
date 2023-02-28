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

require_new_magisk() {
  ui_print "- PLEASE INSTALL MAGISK VERSION 23 OR NEWER!"
  exit 1
}

require_new_ksu() {
  ui_print "- PLEASE INSTALL KERNELSU VERSION 10647 OR NEWER!"
  exit 1
}

on_install() {
  [ "$BOOTMODE" ] || abort "- INSTALLATION FROM RECOVERY NOT SUPPORTED!"
  [ "$ARCH" = "arm64" ] || abort "- $(awk -v var="$ARCH" 'BEGIN{print toupper(var)}') NOT SUPPORTED!"
  if [ -n "$KSU_KERNEL_VER_CODE" ] && [ "$KSU_KERNEL_VER_CODE" -lt "10647" ]; then
    require_new_ksu
  elif [ "$MAGISK_VER_CODE" -lt "23000" ]; then
    require_new_magisk
  fi
  ui_print " "
  find /data/adb -type f -name 'module.prop' | while IFS= read -r i; do
    MNAME="$(awk -F'=' '/name=/{print $2}' $i)"
    MDESC="$(awk -F'=' '/description=/{print $2}' $i)"
    if echo "$MNAME" | grep -q 'MAGNETAR' ||  echo "$MDESC" | grep -q 'Device Performance Optimizer'; then
      resetprop magnetar.ota.update initialize
      sleep 1
      magnetar --update ota
      break
    fi
  done
  [ -n "$MODPATH" ] && $BB rm -rf "$MODPATH"
  rm -rf "$TMPDIR"
  exit 0
}
