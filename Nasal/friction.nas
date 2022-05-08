######################################################################
#
# Terrain reactions for JSBSim (friction, bumpiness, water sinking).
#
# Configuration:
#
# Add the following to ...-set.xml:
#
#   <nasal>
#     ...
#     <friction>
#       <file>path/to/friction.nas</file>
#     </friction>
#   </nasal>
#
#   <gear>
#     <gear n="N">
#       ...
#       <zsink-in type="double">INCHES</zsink-in>
#     </gear>
#   </gear>
#
# where N is the index of the point of contact (<zsink-in> should be
# specified for every point of contact, not just the gears) and INCHES
# is how deep that point should sink in the water.
#
# Information about surface properties will appear in
#
#   /fdm/jsbsim/gear/unit[*]/friction/
#   /fdm/jsbsim/contact/unit[*]/friction/
#


setprop("sim/fdm/surface/override-level", 1);

var rain_factor = 0.3;
var snow_factor = 0.45;
var meters_in_degree = 1852 * 60;
var degrees_in_inch = 0.0254 / meters_in_degree;
var radians_in_degree = math.pi / 180;

var points_of_contact = getprop("fdm/jsbsim/gear/num-units");
var point_info = [];
var x = 0.0;
var y = 0.0;
var z = 0.0;
var zs = 0.0;
var g = 0;
var r = 0.0;
var prop = "";
var s = 0.0;
var d = 0.0;
for (var i = 0; i < points_of_contact; i += 1) {
    x = getprop("gear/gear["~i~"]/xoffset-in") * degrees_in_inch;
    y = getprop("gear/gear["~i~"]/yoffset-in") * degrees_in_inch;
    z = getprop("gear/gear["~i~"]/zoffset-in");
    zs = getprop("gear/gear["~i~"]/zsink-in");
    if (zs == nil)
        zs = z;

    g = 0;
    r = 0;
    prop = "";
    if (props.globals.getNode("fdm/jsbsim/gear/unit["~i~"]") != nil) {
        prop = "fdm/jsbsim/gear/unit["~i~"]";
        g = 1;
        r = getprop(prop~"/rolling_friction_coeff");
    } else {
        prop = "fdm/jsbsim/contact/unit["~i~"]";
    }
    s = getprop(prop~"/static_friction_coeff");
    d = getprop(prop~"/dynamic_friction_coeff");

    append(point_info, { g: g, x: x, y: y, z: z, zs: zs, s: s, d: d, r: r });
}


var lat = 0.0;
var lon = 0.0;
var rot = 0.0;
var h_cos = 0.0;
var h_sin = 0.0;
var cg = 0.0;
var rain_coeff = 0.0;
var snow_coeff = 0.0;
var wave_amp = 0.0;
var wave_freq = 0.0;
var north = 0.0;
var east = 0.0;
var lat_corr = 0.0;
var p_lat = 0.0;
var p_lon = 0.0;
var info = geodinfo(p_lat, p_lon);
var rolling_friction = 0.0;
var dynamic_friction = 0.0;
var static_friction = 0.0;
var friction_factor = 0.0;
var bumpiness = 0.0;
var solid = nil;
z = 0.0;
var l = 0.0;
var dist_m = 0.0;
prop = "";

var update_reactions = func {

    if (getprop("fdm/jsbsim/position/h-agl-ft") > 100)
        return;

    lat = getprop("fdm/jsbsim/position/lat-geod-deg");
    lon = getprop("fdm/jsbsim/position/long-gc-deg");
    rot = -getprop("fdm/jsbsim/attitude/heading-true-rad");
    h_cos = math.cos(rot);
    h_sin = math.sin(rot);
    cg = -getprop("fdm/jsbsim/inertia/cg-x-in") * degrees_in_inch;

    rain_coeff = (getprop("environment/rain-norm")
                      or getprop("environment/metar/rain-norm")
                      or 0) * rain_factor;
    snow_coeff = (getprop("environment/snow-norm")
                      or getprop("environment/metar/snow-norm")
                      or 0) * snow_factor;
    wave_amp = ((getprop("environment/wave/amp") or 1) - 1) * 40;
    wave_freq = (getprop("environment/wave/freq") or 0) * 60;

    for (var i = 0; i < points_of_contact; i += 1) {
        if (!getprop("gear/gear["~i~"]/wow"))
            continue;

        north = (point_info[i].x - cg) * h_cos + point_info[i].y * h_sin;
        east = (point_info[i].x - cg) * -h_sin + point_info[i].y * h_cos;
        lat_corr = math.cos(lat * radians_in_degree) or 0.0000000001;
        east /= lat_corr;
        p_lat = lat + north;
        p_lon = lon + east;

        info = geodinfo(p_lat, p_lon);
        rolling_friction = point_info[i].r;
        dynamic_friction = point_info[i].d;
        friction_factor = 1;
        bumpiness = 0;
        solid = 1;
        if (info != nil and info[1] != nil) {
            friction_factor = info[1].friction_factor;
            rolling_friction = info[1].rolling_friction;
            bumpiness = info[1].bumpiness;
            solid = info[1].solid;
        }

        z = 0;
        if (solid) {
            z = -point_info[i].z;
            # Bumpiness has a period of about 16m and an amplitude
            # of about 1m (40 inches) for bumpiness == 1.
            if (bumpiness) {
                l = p_lon / lat_corr;
                dist_m = math.sqrt(p_lat*p_lat + l*l) * meters_in_degree;
                z += 20 * bumpiness * math.sin(math.pi * dist_m * 0.125);
            }

            static_friction = point_info[i].s - rain_coeff - snow_coeff;
            static_friction *= friction_factor;
            if (static_friction < rolling_friction)
                static_friction = rolling_friction;
            if (static_friction < 0.1)
                static_friction = 0.1;
        } else {
            if (point_info[i].g)
                rolling_friction = 1;

            z = point_info[i].zs;
            z += wave_amp * math.sin(wave_freq * systime() + i);
            static_friction = rolling_friction; # Make brakes ineffective.
        }

        if (dynamic_friction > static_friction)
            dynamic_friction = static_friction;

        prop = (point_info[i].g
                    ? "fdm/jsbsim/gear/unit["~i~"]"
                    : "fdm/jsbsim/contact/unit["~i~"]");

        setprop(prop~"/static_friction_coeff", static_friction);
        setprop(prop~"/dynamic_friction_coeff", dynamic_friction);
        if (point_info[i].g)
            setprop(prop~"/rolling_friction_coeff", rolling_friction);
        setprop(prop~"/z-position", z);

        setprop(prop~"/friction/friction_factor", friction_factor);
        setprop(prop~"/friction/rolling_friction", rolling_friction);
        setprop(prop~"/friction/bumpiness", bumpiness);
        setprop(prop~"/friction/solid", solid);
        setprop(prop~"/friction/lat", p_lat);
        setprop(prop~"/friction/lon", p_lon);
    }
}

var timer_update_reactions = maketimer(0.1, update_reactions);
timer_update_reactions.simulatedTime = 1;
update_reactions();
timer_update_reactions.start();
