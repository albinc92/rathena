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

	// Propability distribution calculation
	// Lower level items have a higher bias to drop
	set .@res, (getarraysize(.@drops) - 1) * pow(rand(0, 1000), 4);
	message strcharinfo(0),".@res = " + .@res;

	// ID of dropped item
	set .@id, .@drops[.@res];

	// Set magic properties
	if(getiteminfo(.@id, 2) == IT_WEAPON) {
		setarray .@idlist[0],
				3, 4, 5, 6, 7, 8,
				13, 14, 16, 17, 18, 19, 24,
				147, 148, 151, 152,
				164, 166,
				168, 170, 171, 172;

		setarray .@base[0],
				1, 1, 1, 1, 1, 1,
				5, 5, 10, 25, 25, 25, 10,
				5, 5, 5, 5,
				10, 5,
				10, 10, 3, 10;

		setarray .@bonus[0],
				2, 2, 2, 2, 2, 2,
				5, 5, 15, 25, 75, 25, 15,
				5, 5, 5, 5,
				10, 5,
				15, 15, 4, 15;
	} else {
		setarray .@idlist[0],
				3, 4, 5, 6, 7, 8,
				9, 10, 11, 12,
				20, 21, 22, 23,
				165, 167, 171;

		setarray .@base[0],
				1, 1, 1, 1, 1, 1,
				5, 5, 10, 10,
				1, 1, 5, 3,
				5, 5, 3;

		setarray .@bonus[0],
				2, 2, 2, 2, 2, 2,
				5, 5, 10, 10,
				2, 2, 6, 3,
				5, 5, 4;
	}
	
	set .@index, rand(getarraysize(.@idlist));
	setarray .@OptID[0],.@idlist[.@index];
	setarray .@OptVal[0],(.@base[.@index] + rand(0, .@bonus[.@index]));
	setarray .@OptParam[0],0;
	getmapxy(.@map$, .@x, .@y, BL_PC);
	makeitem3 .@id,1,.@map$,rand(.@x-1,.@x+1),rand(.@y-1,.@y+1),0,0,0,0,0,0,0,.@OptID,.@OptVal,.@OptParam;
	end;
}
