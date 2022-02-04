##################################
#
# 3D Model Adjustments
# by ShFsn
#
# oct 2021
#
##################################

################################## Cockpit windows animation #######################################
windows_constraints = func{
      wind_l = getprop("/tu154/door/window-left-sec");
      wind_r = getprop("/tu154/door/window-right-sec");
      gear = getprop("/gear/gear/position-norm");
      if( wind_l == nil ) { return; }
      if( wind_r == nil ) { return; }
      if( gear == nil ) { return; }

      if ( gear == 0 and wind_l == 1) { settimer(func(){ setprop("/tu154/door/window-left-sec", 0); }, 1); }
      if ( gear == 0 and wind_r == 1) { settimer(func(){ setprop("/tu154/door/window-right-sec", 0); }, 1); }

      wind_l *= gear;
      wind_r *= gear;

      setprop("/tu154/door/window-left", wind_l);
      setprop("/tu154/door/window-right", wind_r);
}
setlistener("tu154/door/window-right-sec", windows_constraints);
setlistener("tu154/door/window-left-sec", windows_constraints);
setlistener("gear/gear/position-norm", windows_constraints);