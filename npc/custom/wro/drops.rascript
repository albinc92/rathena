-	script	drops	-1,{ 

OnNPCKillEvent:
	set .@retry, (getstatus(SC_ITEMBOOST, 1) / 100) - 1;

OnDrop:
	set .@rate, 2500;
	set .@lukrate, readparam(bLuk) * (.@rate / 250);

	// message strcharinfo(0),".@rate = " + .@rate;
	// message strcharinfo(0),".@lukrate = " + .@lukrate;
	// message strcharinfo(0),"SC_ITEMBOOST = " + .@retry;

	if(rand(1, 10000) > (.@rate + .@lukrate)) {
		if(.@retry) {
			.@retry--;
			goto OnDrop;
		}
		end;
	}

	set .@moblv, getmonsterinfo(killedrid,MOB_LV);

	setarray .@table$[0], "drop_armor", "drop_shield", "drop_garment", "drop_footgear", "drop_accessory", "drop_headgear_upper", "drop_headgear_all";
	.@count = query_sql("SELECT `id` FROM `" + .@table$[rand(0, getarraysize(.@table$) - 1)] + "` WHERE `item_level` <= " + .@moblv + " ORDER BY `item_level` ASC", .@drops);

	if(!.@count) {
		end;
	}

	// Propability distribution calculation
	// Lower level items have a higher bias to drop
	set .@min, 0;
	set .@max, getarraysize(.@drops) - 1;
	set .@p, 5;	// Bias power factor, higher numbers reduce probability for higher values
	set .@bias, pow(rand(0, 1), .@p);
	set .@id, .@drops[round(.@min + (.@max - .@min) * .@bias)];
	message strcharinfo(0),".@id = " + .@id;

	// TODO: Magic properties here...

	getmapxy(.@map$, .@x, .@y, BL_PC);
	makeitem2 .@id,1,.@map$,rand(.@x-1,.@x+1),rand(.@y-1,.@y+1),0,0,0,0,0,0,0;
	end;
}
