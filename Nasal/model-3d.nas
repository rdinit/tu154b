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


############################## Rain glass effect implementation ####################################
var splash_vec_loop = func(){
 var airspeed = getprop("/velocities/airspeed-kt");

 if ( airspeed > 300 ) { airspeed = 300; }

 if ( airspeed < 108 ) { airspeed = airspeed / 108; }
 else { airspeed = 1 + (airspeed - 54) / 21.8; }

 var splash_x = 0.1 + airspeed;
 var splash_y = 0.0;
 var splash_z = -1;

 setprop("/environment/aircraft-effects/splash-vector-x", splash_x);
 setprop("/environment/aircraft-effects/splash-vector-y", splash_y);
 setprop("/environment/aircraft-effects/splash-vector-z", splash_z);

 settimer(func(){ splash_vec_loop(); }, 0.01);
}
splash_vec_loop();


#################################### Reversers animation ############################################
reversers = func{
      eng1_n1 = getprop("/engines/engine/n1");
      eng3_n1 = getprop("/engines/engine[2]/n1");
      reverser1 = getprop("fdm/jsbsim/propulsion/engine[0]/reverser-angle-rad");
      reverser3 = getprop("fdm/jsbsim/propulsion/engine[2]/reverser-angle-rad");
      offset = getprop ("/sim/model/rev-flaps/rev-flaps-offset");
      if( eng1_n1 == nil ) { return; }
      if( eng3_n1 == nil ) { return; }
      if( reverser1 == nil ) { retiurn; }
      if( reverser3 == nil ) { retiurn; }
      if( offset == nil ) { retiurn; }

      if ( eng1_n1 > 30 ) { eng1_n1 = 30; }
      if ( eng3_n1 > 30 ) { eng3_n1 = 30; }

      rev1 = reverser1 / 2.35 * eng1_n1 / 30 * 1.51;
      rev3 = reverser3 / 2.35 * eng3_n1 / 30 * 1.51;

      rev1 = rev1 + offset;
      rev3 = rev3 + offset;

      setprop("/sim/model/rev-flaps/rev-flaps1", rev1);
      setprop("/sim/model/rev-flaps/rev-flaps3", rev3);
}
setlistener("/engines/engine/n1", reversers);
setlistener("/engines/engine[2]/n1", reversers);
setlistener("fdm/jsbsim/propulsion/engine[0]/reverser-angle-rad", reversers);
setlistener("fdm/jsbsim/propulsion/engine[2]/reverser-angle-rad", reversers);
setlistener("/sim/model/rev-flaps/rev-flaps-offset", reversers);