print_modname() {
  $BB sleep 1
  echo " "
  echo "================================================"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
  echo "   _____ __________ _____ ____ _____ _________  "
  echo "  |     | _  |   __|   | |  __|_   _| _  | __ | "
  echo "  | | | |    |  |  | | | |  __| | | |    |   -| "
  echo "  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| "
  echo "                                  by Kyliekyler "
  echo "================================================"
}

on_install() {
  echo " "
  echo "- DOWNLOAD LATEST MAGNETAR RELEASE"
  echo " "
  echo "- OPENING PLING..."
  $BB sleep 3
  [ -n "$($BB which xdg-open)" ] && $BB xdg-open https://www.pling.com/p/1465345/ > /dev/null 2>&1 || am start -a android.intent.action.VIEW -d https://www.pling.com/p/1465345/ > /dev/null 2>&1
  echo "  DONE"
  echo " "
  echo "- FLASH DOWNLOADED FILE BEFORE REBOOTING!"
  echo " "
  echo "================================================"
  echo "                            MAGNETAR © 2019-2022"
  [ ! -z $MODPATH ] && $BB rm -rf $MODPATH
  $BB rm -rf $TMPDIR
  exit 0
}

BB=/data/adb/magisk/busybox
