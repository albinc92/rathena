-	script	drops	-1,{ 

OnNPCKillEvent:
	set .@retry, (getstatus(SC_ITEMBOOST, 1) / 100) - 1;

OnDrop:
	set .@rate, 1000;
	set .@lukrate, readparam(bLuk) * 4;

	message strcharinfo(0),".@rate = " + .@rate;
	message strcharinfo(0),".@lukrate = " + .@lukrate;
	message strcharinfo(0),"SC_ITEMBOOST = " + .@retry;

	if(rand(1, 10000) > (.@rate + .@lukrate)) {
		if(.@retry) {
			.@retry--;
			goto OnDrop;
		}
		end;
	}

	set .@moblv, getmonsterinfo(killedrid,MOB_LV);

	setarray .@table$[0], "drop_armor", "drop_shield", "drop_garment", "drop_footgear", "drop_accessory", "drop_headgear_upper", "drop_headgear_middle", "drop_headgear_lower", "drop_headgear_upper_middle", "drop_headgear_upper_middle", "drop_headgear_middle_lower", "drop_headgear_upper_lower", "drop_headgear_all";
	.@count = query_sql("SELECT `id` FROM `" + .@table$[rand(0, getarraysize(.@table$) - 1)] + "` WHERE `item_level` <= " + .@moblv + " ORDER BY `item_level` ASC", .@drops);

	if(!.@count) {
		end;
	}

	set .@id, .@drops[rand(0,(getarraysize(.@drops)-1))];

	// TODO: Magic properties here...

	getmapxy(.@map$, .@x, .@y, BL_PC);
	makeitem2 .@id,1,.@map$,rand(.@x-1,.@x+1),rand(.@y-1,.@y+1),0,0,0,0,0,0,0;
	end;
}
