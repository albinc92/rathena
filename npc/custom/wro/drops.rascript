-	script	drops	-1,{ 

OnNPCKillEvent:
	set .@retry, (getstatus(SC_ITEMBOOST, 1) / 100) - 1;

OnDrop:
	set .@rate, 2500; // 25.00% base drop rate
	set .@lukrate, readparam(bLuk) * (.@rate / 250); // Every 250 pts in LUK doubles drop rate

	if(rand(1, 10000) > (.@rate + .@lukrate)) {
		if(.@retry) {
			.@retry--;
			goto OnDrop;
		}
		end;
	}

	set .@moblv, getmonsterinfo(killedrid,MOB_LV);
	setarray .@table$[0], "drop_armor", "drop_shield", "drop_garment", "drop_footgear", "drop_accessory", "drop_headgear_upper", "drop_headgear_all";
	while(!.@count) {
		.@count = query_sql("SELECT `id` FROM `" + .@table$[rand(0, getarraysize(.@table$) - 1)] + "` WHERE `item_level` <= " + .@moblv + " ORDER BY `item_level` ASC", .@drops);
	}

	set .@max, getarraysize(.@drops) - 1;
	set .@res, (.@max * pow(rand(0, 10), 2)) / 100;
	message strcharinfo(0),".@max = " + .@max;
	message strcharinfo(0),".@res = " + .@res;

	set .@id, .@drops[.@res];
	getmapxy(.@map$, .@x, .@y, BL_PC);
	makeitem3 .@id,1,.@map$,rand(.@x-1,.@x+1),rand(.@y-1,.@y+1),0,0,0,0,0,0,0,.@OptID,.@OptVal,.@OptParam;
	end;
}
