setprop("tu154/contrail/smoke1", 0 );
setprop("engines/engine/rpm", 0);
var smoke1 = func() {
      if((getprop("engines/engine/rpm") > 6200) and (getprop("position/altitude-agl-ft") > 50) and (getprop("position/altitude-agl-ft") < 1678)) {
                setprop("tu154/contrail/smoke1", 1 );
        } else {
                setprop("tu154/contrail/smoke1", 0 );
        }
}
var timer_smoke1 = maketimer(1, smoke1);
_setlistener("/sim/signals/fdm-initialized", func { timer_smoke1.start() });

setprop("tu154/contrail/smoke2", 0 );
setprop("engines/engine[1]/rpm", 0);
var smoke2 = func() {
      if((getprop("engines/engine[1]/rpm") > 6200) and (getprop("position/altitude-agl-ft") > 50) and (getprop("position/altitude-agl-ft") < 1678)) {
                setprop("tu154/contrail/smoke2", 1 );
        } else {
                setprop("tu154/contrail/smoke2", 0 );
        }
}
var timer_smoke2 = maketimer(1, smoke2);
_setlistener("/sim/signals/fdm-initialized", func { timer_smoke2.start() });

setprop("tu154/contrail/smoke3", 0 );
setprop("engines/engine[2]/rpm", 0);
var smoke3 = func() {
      if((getprop("engines/engine[2]/rpm") > 6200) and (getprop("position/altitude-agl-ft") > 50) and (getprop("position/altitude-agl-ft") < 1678)) {
                setprop("tu154/contrail/smoke3", 1 );
        } else {
                setprop("tu154/contrail/smoke3", 0 );
        }
}
var timer_smoke3 = maketimer(1, smoke3);
_setlistener("/sim/signals/fdm-initialized", func { timer_smoke3.start() });

setprop("tu154/contrail/contrail1", 0 );
setprop("engines/engine/rpm", 0);
var contrail1 = func() {
      if((getprop("engines/engine/rpm") > 6200) and (getprop("position/altitude-ft") > 21450)) {
                setprop("tu154/contrail/contrail1", 1 );
        } else {
                setprop("tu154/contrail/contrail1", 0 );
        }
}
var timer_contrail1 = maketimer(1, contrail1);
_setlistener("/sim/signals/fdm-initialized", func { timer_contrail1.start() });

setprop("tu154/contrail/contrail2", 0 );
setprop("engines/engine[1]/rpm", 0);
var contrail2 = func() {
       if((getprop("engines/engine/rpm") > 6200) and (getprop("position/altitude-ft") > 21450)) {
                setprop("tu154/contrail/contrail2", 1 );
        } else {
                setprop("tu154/contrail/contrail2", 0 );
        }
}
var timer_contrail2 = maketimer(1, contrail2);
_setlistener("/sim/signals/fdm-initialized", func { timer_contrail2.start() });

setprop("tu154/contrail/contrail3", 0 );
setprop("engines/engine[2]/rpm", 0);
var contrail3 = func() {
       if((getprop("engines/engine/rpm") > 6200) and (getprop("position/altitude-ft") > 21450)) {
                setprop("tu154/contrail/contrail3", 1 );
        } else {
                setprop("tu154/contrail/contrail3", 0 );
        }
}
var timer_contrail3 = maketimer(1, contrail3);
_setlistener("/sim/signals/fdm-initialized", func { timer_contrail3.start() });

setprop("tu154/contrail/condensation", 0 );
var condensation = func() {
      if((getprop("environment/relative-humidity") > 95) and (getprop("environment/temperature-degc") > 0) and (getprop("velocities/airspeed-kt") > 180)) {
                setprop("tu154/contrail/condensation", 1 );
        } else {
                setprop("tu154/contrail/condensation", 0 );
        }
}
var timer_condensation = maketimer(1, condensation);
_setlistener("/sim/signals/fdm-initialized", func { timer_condensation.start() });


print ( "Contrail system started" );
