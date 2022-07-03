print_modname() {
  $BB sleep 1
  echo " "
  echo "======================================================"
  echo "     _____ __________ _____ ____ _____ _________      "
  echo "    |     | _  |   __|   | |  __|_   _| _  | __ |     "
  echo "    | | | |    |  |  | | | |  __| | | |    |   -|     "
  echo "    |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__|     "
  echo "                                    by Kyliekyler     "
  echo "======================================================"
}

on_install() {
  echo " "
  for i in /data/adb/*/*/module.prop; do
    MDESC=$($BB grep -sm1 'description' $i | $BB cut -d'=' -f2)
    if [[ "$MDESC" = *"Device Performance Optimizer"* ]]; then
      MNAME=$($BB grep -sm1 'name=' $i | $BB cut -d'=' -f2)
      if [[ "$MNAME" = "MAGNETAR+" ]]; then
        resetprop magnetar.update initialize
        $BB sleep 1
        magnetar --update ota
      else
        echo "- DOWNLOAD LATEST MAGNETAR RELEASE"
        $BB sleep 3
        echo " "
        echo "- OPENING PLING..."
        [ -n "$(which xdg-open)" ] && xdg-open https://www.pling.com/p/1465345/ > /dev/null 2>&1 || am start -a android.intent.action.VIEW -d https://www.pling.com/p/1465345/ > /dev/null 2>&1
        echo "  DONE"
        echo " "
        echo "- FLASH DOWNLOADED FILE BEFORE REBOOTING!"
        echo " "
        echo "======================================================"
        echo "                                  MAGNETAR © 2019-2022"
      fi
      break
    fi
  done
  [ -n "$MODPATH" ] && $BB rm -rf $MODPATH
  $BB rm -rf $TMPDIR
  exit 0
}

BB=/data/adb/magisk/busybox
