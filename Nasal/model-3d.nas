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


############################### Groung services implementation ######################################
gndservs = func{
      chockss = getprop("/sim/model/ground-services/chockss");
      chocks = getprop("/sim/model/ground-services/chocks");
      pb = getprop("/controls/gear/brake-parking");
      gs = getprop("/velocities/groundspeed-kt");
      if( chockss == nil ) { return; }
      if( chocks == nil ) { return; }
      if( pb == nil ) { return; }
      if( gs == nil ) { return; }

      print ( gs );

      if ( gs > 1 ) { chockss = 0; chocks = 0; setprop("/sim/model/ground-services/chockss", chockss); setprop("/sim/model/ground-services/chocks", chocks); }
      if ( chockss == 1 and chocks == 0 and pb == 0 ) { chockss = 0; }
      if ( chockss == 1 and chocks == 0 and pb == 1 ) { chocks = 1; }
      if ( chockss == 1 and chocks == 1 and pb == 0 ) { pb = 1; }
      if ( chockss == 1 and chocks == 1 and pb == 1 ) { setprop("/controls/gear/brake-left", pb); setprop("/controls/gear/brake-right", pb); }
      if ( chockss == 0 ) { chocks = 0; }

      setprop("/sim/model/ground-services/chockss", chockss);
      setprop("/sim/model/ground-services/chocks", chocks);
      setprop("/controls/gear/brake-parking", pb);
}
setlistener("/sim/model/ground-services/chockss", gndservs);
setlistener("/controls/gear/brake-parking", gndservs);
setlistener("/velocities/groundspeed-kt", gndservs);
setlistener("/controls/gear/brake-left", gndservs);
setlistener("/controls/gear/brake-right", gndservs);

catering_anim = func{
      state = getprop("/sim/model/ground-services/cat-up");
      if ( state == nil ) { return; }

      if ( state == 1 ) {
            time = 5 / 0.62 * (0.62 - getprop("/services/catering/position-norm"));
            interpolate ("/services/catering/position-norm", 0.62, time);
      }
      if ( state == 0 ) {
            time = 5 / 0.62 * getprop("/services/catering/position-norm");
            interpolate ("/services/catering/position-norm", 0, time);
      }
} setlistener("/sim/model/ground-services/cat-up", catering_anim);

#deicing_anim = func{
#      setprop("/sim/model/ground-services/de-ice-p", 0);
#      setprop("/sim/model/ground-services/de-ice-pp", 0);
#      interpolate ("/sim/model/ground-services/de-ice-pp", 90, 90);
#} setlistener("/sim/model/ground-services/de-ice-p", deicing_anim);
deicing = func{
      crane = "services/deicing_truck/crane/position-norm";
      deice = "services/deicing_truck/deicing/position-norm";
      state = getprop("/sim/model/ground-services/de-ice-pp");
      if ( state > 0 and state < 1) { interpolate(crane, 1, 14.9); }
      if ( state > 15 and state < 16 ) { 
      interpolate(deice, 1, 15);
#      defrost(); 
      }
      if ( state > 30 and state < 31 ) { interpolate(deice, 0, 15); }
      if ( state > 45 and state < 46 ) { interpolate(deice, 1, 15); }
      if ( state > 60 and state < 61 ) { interpolate(deice, 0, 15); }
      if ( state > 75 and state < 76 ) { interpolate(crane, 0, 15); }
} setlistener("/sim/model/ground-services/de-ice-pp", deicing);

ext_power_autoconnect = func{
      if ( getprop("/tu154/switches/APU-RAP-selector") == 2 ) { setprop("/sim/model/ground-services/ext-power", 1); }
} setlistener("/tu154/switches/APU-RAP-selector", ext_power_autoconnect);


############################################# Tu-154B-2 Rollshake ##############################################
#
# Copyright (c) 2020 Josh Davidson (Octal450)

var shakeEffect = props.globals.initNode("/systems/shake/effect", 0, "BOOL");
var shake = props.globals.initNode("/systems/shake/shaking", 0, "DOUBLE");
var shakext = props.globals.initNode("/systems/shake/shakingext", 0, "DOUBLE");
var sf = 0;

var theShakeEffect = func {
      if (getprop("/systems/shake/effect") == 1) {
            n = 100000;
            max = 80;
            ext = 2.5;
            sf = getprop("/velocities/groundspeed-kt") / n;
            if (sf > max / n) { sf = max / n; }
            interpolate("/systems/shake/shaking", sf, 0.03);
            settimer(func {
                  interpolate("/systems/shake/shaking", -sf * 2, 0.03); 
                  if (getprop("/sim/sound/pax") == 1) {
                        interpolate("/systems/shake/shakingext", -sf * 2 * ext, 0.03);
                  } else {
                        settimer(func {
                              setprop("/systems/shake/shakingext", 0);
                        }, 0.2);
                  }
            }, 0.06);
            settimer(func {
                  interpolate("/systems/shake/shaking", sf, 0.03);
                  if (getprop("/sim/sound/pax") == 1) {
                        interpolate("/systems/shake/shakingext", sf * ext, 0.03);
                  } else {
                        settimer(func {
                              setprop("/systems/shake/shakingext", 0);
                        }, 0.2);
                  }
            }, 0.12);
            settimer(theShakeEffect, 0.09);     
      } else {
#           shake.setValue(0);
#           shakeEffect.setBoolValue(0);
            settimer(func {
                  setprop("/systems/shake/shaking", 0);
                  setprop("/systems/shake/shakingext", 0);
            }, 0.2);
      }         
}
setlistener("/systems/shake/effect", func {
      if (shakeEffect.getBoolValue()) {
            theShakeEffect();
      }
}, 0, 0);