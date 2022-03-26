BATTLVL=$(ioreg -r -l -n AppleHSBluetoothDevice | egrep '"BatteryPercent" = |^  \|   "Bluetooth Product Name" = '| sed 's/"Bluetooth Product Name" = "Magic Mouse 2"/Mouse:/' | sed 's/"Bluetooth Product Name" = "Magic Keyboard with Touch ID"/  \|  Keyboard:/'| sed 's/"BatteryPercent" = //' | sed "s/\|//g")
BATTRPT=${BATTLVL//[$'\t\r\n\ ']}
# NOTE \d is not supported
echo $BATTRPT | sed -r 's/[0-9]+/\ &\%\n/g'