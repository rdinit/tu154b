############################################
#
# Air conditioning system for Tu-154B-2
# by ShFsn
# oct 2021
#
############################################


var power_node = props.globals.getNode("/tu154/systems/electrical/buses/DC27-bus-L/volts", 1);
var vs_node = props.globals.getNode("/tu154/air-cond/variables/vs", 1);
var d_p_node = props.globals.getNode("/tu154/air-cond/variables/d-p", 1);
var alt_m_node = props.globals.getNode("/tu154/air-cond/variables/alt-m", 1);
var t_cab_node = props.globals.getNode("/tu154/air-cond/variables/t-cab", 1);
var t_sal_1_node = props.globals.getNode("/tu154/air-cond/variables/t-sal-1", 1);
var t_sal_2_node = props.globals.getNode("/tu154/air-cond/variables/t-sal-2", 1);
var tt_dver_node = props.globals.getNode("/tu154/air-cond/variables/tt-dver", 1);
var tt_ekip_node = props.globals.getNode("/tu154/air-cond/variables/tt-ekip", 1);
var tt_sal_1_node = props.globals.getNode("/tu154/air-cond/variables/tt-sal-1", 1);
var tt_sal_2_node = props.globals.getNode("/tu154/air-cond/variables/tt-sal-2", 1);
var tt_mag_left_node = props.globals.getNode("/tu154/air-cond/variables/tt-mag-left", 1);
var tt_mag_right_node = props.globals.getNode("/tu154/air-cond/variables/tt-mag-right", 1);
var air_cons_l_node = props.globals.getNode("/tu154/air-cond/variables/air-cons-l", 1);
var air_cons_r_node = props.globals.getNode("/tu154/air-cond/variables/air-cons-r", 1);
var sw_sal_12_node = props.globals.getNode("/tu154/air-cond/sw/sw-sal-12", 1);
var sw_eng_1_node = props.globals.getNode("/tu154/air-cond/sw/sw-eng-1", 1);
var sw_eng_2_node = props.globals.getNode("/tu154/air-cond/sw/sw-eng-2", 1);
var sw_eng_3_node = props.globals.getNode("/tu154/air-cond/sw/sw-eng-3", 1);
var sw_nadduv_node = props.globals.getNode("/tu154/air-cond/sw/sw-nadduv", 1);
var sw_psvp_l_node = props.globals.getNode("/tu154/air-cond/sw/sw-psvp-l", 1);
var sw_psvp_r_node = props.globals.getNode("/tu154/air-cond/sw/sw-psvp-r", 1);
var sw_sbros_node = props.globals.getNode("/tu154/air-cond/sw/sw-sbros", 1);
var sel_trub_node = props.globals.getNode("/tu154/air-cond/sel/sel-trub", 1);
var sel_cabin_node = props.globals.getNode("/tu154/air-cond/sel/sel-cabin", 1);
var sel_sal_1_node = props.globals.getNode("/tu154/air-cond/sel/sel-sal-1", 1);
var sel_sal_2_node = props.globals.getNode("/tu154/air-cond/sel/sel-sal-2", 1);
var sel_mag_l_node = props.globals.getNode("/tu154/air-cond/sel/sel-mag-left", 1);
var sel_mag_r_node = props.globals.getNode("/tu154/air-cond/sel/sel-mag-right", 1);
var swt_cabin_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-cabin-aut", 1);
var swt_sal_1_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-sal-1-aut", 1);
var swt_sal_2_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-sal-2-aut", 1);
var swt_th_l_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-th-left-aut", 1);
var swt_th_r_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-th-right-aut", 1);
var swt_vvr_l_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-vvr-left-aut", 1);
var swt_vvr_r_aut_node = props.globals.getNode("/tu154/air-cond/swt/swt-vvr-right-aut", 1);
var swt_cabin_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-cabin-hol", 1);
var swt_sal_1_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-sal-1-hol", 1);
var swt_sal_2_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-sal-2-hol", 1);
var swt_th_l_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-th-left-hol", 1);
var swt_th_r_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-th-right-hol", 1);
var swt_vvr_l_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-vvr-left-hol", 1);
var swt_vvr_r_hol_node = props.globals.getNode("/tu154/air-cond/swt/swt-vvr-right-hol", 1);
var swt_cabin_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-cabin-gor", 1);
var swt_sal_1_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-sal-1-gor", 1);
var swt_sal_2_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-sal-2-gor", 1);
var swt_th_l_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-th-left-gor", 1);
var swt_th_r_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-th-right-gor", 1);
var swt_vvr_l_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-vvr-left-gor", 1);
var swt_vvr_r_gor_node = props.globals.getNode("/tu154/air-cond/swt/swt-vvr-right-gor", 1);
var eng0_run_node = props.globals.getNode("/engines/engine[0]/running", 1);
var eng1_run_node = props.globals.getNode("/engines/engine[1]/running", 1);
var eng2_run_node = props.globals.getNode("/engines/engine[2]/running", 1);
var eng3_run_node = props.globals.getNode("/engines/engine[3]/running", 1);
var apu_bleed_node = props.globals.getNode("/tu154/systems/APU/APU-bleed", 1);
var start_sw_node = props.globals.getNode("/tu154/switches/startpanel-start", 1);
var zero_sel_node = props.globals.getNode("/tu154/instrumentation/altimeter[0]/mmhg", 1);	# Aerodrome pressure. Need to be set separately, BUT...
var press_out_node = props.globals.getNode("/environment/pressure-inhg", 1);
var outside_t_node = props.globals.getNode("/environment/temperature-degc", 1);
var door_p2l_node = props.globals.getNode("/tu154/door/passe", 1);
var win_l_node = props.globals.getNode("/tu154/door/window-left", 1);
var win_r_node = props.globals.getNode("/tu154/door/window-right", 1);


######################################### Indicators work ##########################################
var ind_dt = 1.0;
var power = 0.0;
var goal_ind = 0.0;
var state = 0;

var indicators_func = func {

	power = power_node.getValue();
	#var scale = 1;

	# Cabin Vertical Speed
	goal_ind = vs_node.getValue();
	interpolate("/tu154/air-cond/prib/delta-alt", goal_ind, ind_dt);

	# Delta pressure
	goal_ind = d_p_node.getValue();
	if (power == 0) goal_ind = 0;
	interpolate("/tu154/air-cond/prib/d-p", goal_ind, ind_dt);

	# Cabin height
	goal_ind = alt_m_node.getValue();
	if (power == 0) goal_ind = 0;
	interpolate("/tu154/air-cond/prib/alt-m", goal_ind, ind_dt);

	# Cockpit temperature
	goal_ind = t_cab_node.getValue();
	if (power == 0) goal_ind = 0;
	interpolate("/tu154/air-cond/prib/t-cab", goal_ind, ind_dt);

	# Passenger cabin temperature
	state = sw_sal_12_node.getValue();
	if (state == 1) { goal_ind = t_sal_1_node.getValue(); }
	else if (state == 0) { goal_ind = t_sal_2_node.getValue(); }
	if (power == 0) goal_ind = 0;
	interpolate("/tu154/air-cond/prib/t-sal", goal_ind, ind_dt);

	# Air pipeline temperature
	state = sel_trub_node.getValue();
	if (power == 0) goal_ind = 0;
	else if (state == 0) { goal_ind = tt_dver_node.getValue(); }
	else if (state == 1) { goal_ind = tt_ekip_node.getValue(); }
	else if (state == 2) { goal_ind = tt_sal_1_node.getValue(); }
	else if (state == 3) { goal_ind = tt_sal_2_node.getValue(); }
	else if (state == 4) { goal_ind = tt_mag_left_node.getValue(); }
	else if (state == 5) { goal_ind = tt_mag_right_node.getValue(); }
	interpolate("/tu154/air-cond/prib/t-trub", goal_ind, ind_dt);

	# Air consumption
	goal_ind = air_cons_l_node.getValue();
	if (power == 0) goal_ind = 0;
	interpolate("/tu154/air-cond/prib/p-left", goal_ind, ind_dt);
	goal_ind = air_cons_r_node.getValue();
	if (power == 0) goal_ind = 0;
	interpolate("/tu154/air-cond/prib/p-right", goal_ind, ind_dt);

}
timer_indicators = maketimer(ind_dt, indicators_func);
timer_indicators.simulatedTime = 1;
timer_indicators.start();


######################################## Air Consumption #########################################
var maint = 0;

var air_cons = func {
	maint = 0;

	# By APU
	if (eng3_run_node.getValue() == 1 and apu_bleed_node.getValue() == 5 and start_sw_node.getValue() != 1) { maint = 1; }

	# By engines
	if (eng0_run_node.getValue() == 1 and sw_eng_1_node.getValue() == 1 and eng1_run_node.getValue() == 1 and sw_eng_2_node.getValue() == 1) { maint = 1; }
	if (eng1_run_node.getValue() == 1 and sw_eng_2_node.getValue() == 1 and eng2_run_node.getValue() == 1 and sw_eng_3_node.getValue() == 1) { maint = 1; }
	if (eng0_run_node.getValue() == 1 and sw_eng_1_node.getValue() == 1 and eng2_run_node.getValue() == 1 and sw_eng_3_node.getValue() == 1) { maint = 1; }

	# "NADDUV" Switch
	if (maint == 0 or sw_nadduv_node.getValue() == -1 or sw_sbros_node.getValue() == 1 or sw_psvp_l_node.getValue() == 0) { interpolate ("tu154/air-cond/variables/air-cons-l", 0, 1); }
	else if (maint == 1 and sw_nadduv_node.getValue() == 1 and air_cons_l_node.getValue() < 5.46) { air_cons_l_node.setValue(air_cons_l_node.getValue() + 0.05); }
	if (maint == 0 or sw_nadduv_node.getValue() == -1 or sw_sbros_node.getValue() == 1 or sw_psvp_r_node.getValue() == 0) { interpolate ("tu154/air-cond/variables/air-cons-r", 0, 1); }
	else if (maint == 1 and sw_nadduv_node.getValue() == 1 and air_cons_r_node.getValue() < 5.46) { air_cons_r_node.setValue(air_cons_r_node.getValue() + 0.05); }

}
var timer_air_cons = maketimer(0.1, air_cons);
timer_air_cons.simulatedTime = 1;
timer_air_cons.start();


########################################### Cabin pressure #############################################
var zero = 0.0;
var outside = 0.0;
var goal_press = 0.0;
var cabin = 0.0;
var max_dh = 0.0;

var cab_press = func {
	zero = zero_sel_node.getValue();

	outside = press_out_node.getValue() / 29.92 * 760;
	goal_press = outside + 460;
	if (goal_press > zero) { goal_press = zero; }

	cabin = zero - alt_m_node.getValue() / 2000 * 160;
	max_dh = ((air_cons_l_node.getValue() + air_cons_r_node.getValue()) / 2 - 2) / 3000 * 160;
	if (door_p2l_node.getValue() > 0 or win_l_node.getValue() > 0 or win_r_node.getValue() > 0) { 
		if (outside < cabin) { max_dh = -8; }
		if (outside > cabin) { max_dh = 8; }
		goal_press = outside;
	}

	if ((goal_press - cabin) < max_dh and max_dh > 0) { cabin = goal_press; }
	else if ((outside - cabin) > max_dh and max_dh < 0 ) { cabin = outside; }
	else { cabin = cabin + max_dh; }

	vs_node.setValue(((zero - cabin) / 160 * 2000 - alt_m_node.getValue()) * 10);
	d_p_node.setValue((cabin - outside) / 760);
	alt_m_node.setValue((zero - cabin) / 160 * 2000);
}
var timer_cab_press = maketimer(0.1, cab_press);
timer_cab_press.simulatedTime = 1;
timer_cab_press.start();


############################################# Temperatures ################################################
var curr_cab = 0.0;
var curr_sal_1 = 0.0;
var curr_sal_2 = 0.0;
var curr_th_left = 0.0;
var curr_vvr_left = 0.0;
var curr_th_right = 0.0;
var curr_vvr_right = 0.0;
var goal_cab = t_cab_node.getValue();
var goal_sal_1 = t_sal_1_node.getValue();
var goal_sal_2 = t_sal_2_node.getValue();
var goal_th_left = tt_mag_left_node.getValue() / 2;
var goal_vvr_left = tt_mag_left_node.getValue() / 2;
var goal_th_right = tt_mag_right_node.getValue() / 2;
var goal_vvr_right = tt_mag_right_node.getValue() / 2;
var outside_t = 0.0;
settimer(func {
	outside_t = outside_t_node.getValue();
	t_cab_node.setValue(outside_t);
	t_sal_1_node.setValue(outside_t);
	t_sal_2_node.setValue(outside_t);
	tt_dver_node.setValue(outside_t);
	tt_ekip_node.setValue(outside_t);
	tt_sal_1_node.setValue(outside_t);
	tt_sal_2_node.setValue(outside_t);
	tt_mag_left_node.setValue(outside_t);
	tt_mag_right_node.setValue(outside_t);
	goal_cab = outside_t;
	goal_sal_1 = outside_t;
	goal_sal_2 = outside_t;
	goal_th_left = outside_t / 2;
	goal_vvr_left = outside_t / 2;
	goal_th_right = outside_t / 2;
	goal_vvr_right = outside_t / 2;
}, 5);

var temps = func {
	outside_t = outside_t_node.getValue();


	if (swt_cabin_aut_node.getValue() == 1) { goal_cab = sel_cabin_node.getValue() * 2 - 10; }
	if (swt_sal_1_aut_node.getValue() == 1) { goal_sal_1 = sel_sal_1_node.getValue() * 2 - 10; }
	if (swt_sal_2_aut_node.getValue() == 1) { goal_sal_2 = sel_sal_2_node.getValue() * 2 - 10; }
	if (swt_th_l_aut_node.getValue() == 1) { goal_th_left = (sel_mag_l_node.getValue() * 2 - 10) / 2; }
	if (swt_vvr_l_aut_node.getValue() == 1) { goal_vvr_left = (sel_mag_l_node.getValue() * 2 - 10) / 2; }
	if (swt_th_r_aut_node.getValue() == 1) { goal_th_right = (sel_mag_r_node.getValue() * 2 - 10) / 2; }
	if (swt_vvr_r_aut_node.getValue() == 1) { goal_vvr_right = (sel_mag_r_node.getValue() * 2 - 10) / 2; }

	if (swt_cabin_aut_node.getValue() == 0) { goal_cab = t_cab_node.getValue(); }
	if (swt_sal_1_aut_node.getValue() == 0) { goal_sal_1 = t_sal_1_node.getValue(); }
	if (swt_sal_2_aut_node.getValue() == 0) { goal_sal_2 = t_sal_2_node.getValue(); }

	if (swt_cabin_hol_node.getValue() == 1) { goal_cab = goal_cab - 0.01; }
	if (swt_sal_1_hol_node.getValue() == 1) { goal_sal_1 = goal_sal_1 - 0.01; }
	if (swt_sal_2_hol_node.getValue() == 1) { goal_sal_2 = goal_sal_2 - 0.01; }
	if (swt_th_l_hol_node.getValue() == 1) { goal_th_left = goal_th_left - 0.05; }
	if (swt_vvr_l_hol_node.getValue() == 1) { goal_vvr_left = goal_vvr_left - 0.05; }
	if (swt_th_r_hol_node.getValue() == 1) { goal_th_right = goal_th_right - 0.05; }
	if (swt_vvr_r_hol_node.getValue() == 1) { goal_vvr_right = goal_vvr_right - 0.05; }

	if (swt_cabin_gor_node.getValue() == 1) { goal_cab = goal_cab + 0.01; }
	if (swt_sal_1_gor_node.getValue() == 1) { goal_sal_1 = goal_sal_1 + 0.01; }
	if (swt_sal_2_gor_node.getValue() == 1) { goal_sal_2 = goal_sal_2 + 0.01; }
	if (swt_th_l_gor_node.getValue() == 1) { goal_th_left = goal_th_left + 0.05; }
	if (swt_vvr_l_gor_node.getValue() == 1) { goal_vvr_left = goal_vvr_left + 0.05; }
	if (swt_th_r_gor_node.getValue() == 1) { goal_th_right = goal_th_right + 0.05; }
	if (swt_vvr_r_gor_node.getValue() == 1) { goal_vvr_right = goal_vvr_right + 0.05; }


	var curr_cab = (t_cab_node.getValue() + 0.01 * (outside_t - t_cab_node.getValue()) / 80);
	var curr_sal_1 = (t_sal_1_node.getValue() + 0.01 * (outside_t - t_sal_1_node.getValue()) / 80);
	var curr_sal_2 = (t_sal_2_node.getValue() + 0.01 * (outside_t - t_sal_2_node.getValue()) / 80);
	var curr_th_left = (tt_mag_left_node.getValue() + 0.01 * (outside_t - tt_mag_left_node.getValue()) / 80) / 2;
	var curr_vvr_left = (tt_mag_left_node.getValue() + 0.01 * (outside_t - tt_mag_right_node.getValue()) / 80) / 2;
	var curr_th_right = (tt_mag_right_node.getValue() + 0.01 * (outside_t - tt_mag_right_node.getValue()) / 80) / 2;
	var curr_vvr_right = (tt_mag_right_node.getValue() + 0.01 * (outside_t - tt_mag_right_node.getValue()) / 80) / 2;

	if (air_cons_l_node.getValue() > 1) { tt_mag_left_node.setValue(goal_th_left + goal_vvr_left); }
	else { tt_mag_left_node.setValue(curr_th_left + curr_vvr_left); }
	if (air_cons_r_node.getValue() > 1) { tt_mag_right_node.setValue(goal_th_right + goal_vvr_right); }
	else { tt_mag_right_node.setValue(curr_th_right + curr_vvr_right); }

	if (air_cons_l_node.getValue() > 1 and air_cons_r_node.getValue() > 1) {
		if (abs(goal_cab - curr_cab) < 0.02) { curr_cab = goal_cab; }
		else { curr_cab = curr_cab + 0.02 * (goal_cab - curr_cab) / abs(goal_cab - curr_cab); }
		if (abs(goal_sal_1 - curr_sal_1) < 0.02) { curr_sal_1 = goal_sal_1; }
		else { curr_sal_1 = curr_sal_1 + 0.02 * (goal_sal_1 - curr_sal_1) / abs(goal_sal_1 - curr_sal_1); }
		if (abs(goal_sal_2 - curr_sal_2) < 0.02) { curr_sal_2 = goal_sal_2; }
		else { curr_sal_2 = curr_sal_2 + 0.02 * (goal_sal_2 - curr_sal_2) / abs(goal_sal_2 - curr_sal_2); }
	}
	else if (air_cons_l_node.getValue() > 1 or air_cons_r_node.getValue() > 1) {
		if (abs(goal_cab - curr_cab) < 0.015) { curr_cab = goal_cab; }
		else { curr_cab = curr_cab + 0.015 * (goal_cab - curr_cab) / abs(goal_cab - curr_cab); }
		if (abs(goal_sal_1 - curr_sal_1) < 0.015) { curr_sal_1 = goal_sal_1; }
		else { curr_sal_1 = curr_sal_1 + 0.015 * (goal_sal_1 - curr_sal_1) / abs(goal_sal_1 - curr_sal_1); }
		if (abs(goal_sal_2 - curr_sal_2) < 0.015) { curr_sal_2 = goal_sal_2; }
		else { curr_sal_2 = curr_sal_2 + 0.015 * (goal_sal_2 - curr_sal_2) / abs(goal_sal_2 - curr_sal_2); }
	}
	t_cab_node.setValue(curr_cab);
	t_sal_1_node.setValue(curr_sal_1);
	t_sal_2_node.setValue(curr_sal_2);
	tt_dver_node.setValue((curr_th_left + curr_vvr_left + curr_th_right + curr_vvr_right) / 2);
	tt_ekip_node.setValue(goal_cab);
	tt_sal_1_node.setValue(goal_sal_1);
	tt_sal_2_node.setValue(goal_sal_2);

}
var timer_temps = maketimer(0.1, temps);
timer_temps.simulatedTime = 1;
timer_temps.start();