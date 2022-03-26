#!/bin/bash
# Set Mouse Sensitivity to Windows Value
xinput --set-prop 'pointer:Glorious Model O' 'libinput Accel Profile Enabled' 0, 1

# Enable Middle Click Scrolling ("autoscroll")
xinput set-prop 'pointer:Glorious Model O' 'libinput Scroll Method Enabled' 0 0 1
