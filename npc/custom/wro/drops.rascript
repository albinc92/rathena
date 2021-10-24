-	script	drops	-1,{ 

OnNPCKillEvent:
	set .@itemboost, ((getstatus(SC_ITEMBOOST, 1) / 100) - 1); // Drop modifying item account
	set .@rate, 1000; // A value of 1000 = 10.00%
	set .@lukrate, readparam(bLuk) * (.@rate / 250); // Every 250 pts in LUK doubles drop rate

OnTryDrop:
	// Drop check
	message strcharinfo(0),".@itemboost = " + .@itemboost;
	if(rand(1, 10000) > (.@rate + .@lukrate)) {
		if(.@itemboost > 0) {
			.@itemboost--;
			goto OnTryDrop;
		}
		end;
	}

	// Query DB
	set .@moblv, getmonsterinfo(killedrid,MOB_LV);
	//setarray .@table$[0], "drop_armor", "drop_shield", "drop_garment", "drop_footgear", "drop_accessory", "drop_headgear_upper", "drop_headgear_all";
	setarray .@table$[0], "drop_armor";
	set .@count, 0;
	while(!.@count) {
		.@count = query_sql("SELECT `id` FROM `" + .@table$[rand(0, getarraysize(.@table$) - 1)] + "` WHERE `item_level` <= " + .@moblv + " ORDER BY `item_level` ASC", .@drops);
	}

	// Drop probability calculation
	set .@max, getarraysize(.@drops) - 1;
	set .@res, (.@max * pow(rand(0, 10), 2)) / 100;
	// message strcharinfo(0),".@max = " + .@max;
	// message strcharinfo(0),".@res = " + .@res;

	// Set item ID
	set .@id, .@drops[.@res];

	// ------------------
	// Set random options
	// ------------------

	// Generate number of affixes
	set .@optAmt, 0;
    set .@r, rand(1, 750);
    if(.@r < 251 && .@r > 125) {
        .@optAmt = 1;
    } else if(.@r < 126 && .@r > 62) {
        .@optAmt = 2;
    } else if(.@r < 63 && .@r > 31) {
        .@optAmt = 3;
    } else if(.@r < 32 && .@r > 16) {
        .@optAmt = 4;
    } else if(.@r < 17 && .@r > 8) {
        .@optAmt = 5;
    }

	// Limit maximum affixes based on slot count
	if(.@optAmt) {
		set .@slotAmnt, getiteminfo(.@id, 10);
		if(.@slotAmnt == 1 && .@optAmt > 4) {
			.@optAmt = 4;
		} else if(.@slotAmnt == 2 && .@optAmt > 3) {
			.@optAmt = 3;
		} else if(.@slotAmnt == 3 && .@optAmt > 2) {
			.@optAmt = 2;
		} else if(.@slotAmnt == 4 && .@optAmt > 1) {
			.@optAmt = 1;
		}
	}

	// Check item type and setup affix data
	if(getiteminfo(.@id, 2) == IT_WEAPON) {
		setarray .@optionid[0],
				3, 4, 5, 6, 7, 8,
				13, 14, 16, 17, 18, 19, 24,
				147, 148, 151, 152,
				164, 166,
				168, 170, 171, 172;
		setarray .@roabase[0],
				1, 1, 1, 1, 1, 1,
				5, 5, 10, 25, 25, 25, 10,
				5, 5, 5, 5,
				10, 5,
				10, 10, 3, 10;
		setarray .@roabonus[0],
				2, 2, 2, 2, 2, 2,
				5, 5, 15, 25, 75, 25, 15,
				5, 5, 5, 5,
				10, 5,
				15, 15, 4, 15;
	} else {

		 // Limit max slots on armor to 3
		if(.@optAmt > 3) {
			set .@optAmt, 3;
		}

		setarray .@optionid[0],
				3, 4, 5, 6, 7, 8,
				9, 10, 11, 12,
				20, 21, 22, 23,
				165, 167, 171;
		setarray .@roabase[0],
				1, 1, 1, 1, 1, 1,
				5, 5, 10, 10,
				1, 1, 5, 3,
				5, 5, 3;
		setarray .@roabonus[0],
				2, 2, 2, 2, 2, 2,
				5, 5, 10, 10,
				2, 2, 6, 3,
				5, 5, 4;
	}

	// Generate base array
	if(.@optAmt == 1) {
		setarray .@index[0], rand(getarraysize(.@optionid));
	} else if(.@optAmt == 2) {
		setarray .@index[0], rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid));
	} else if(.@optAmt == 3) {
		setarray .@index[0], rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid));
	} else if(.@optAmt == 4) {
		setarray .@index[0], rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid));
	} else if(.@optAmt == 5) {
		setarray .@index[0], rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid)), rand(getarraysize(.@optionid));
	}

	// Check for duplicate affixes
	if(getarraysize(@index) > 0) {
		for(set .@i, getarraysize(@index); .@i > 0; .@i--) {
			for(set .@j, .@i - 1; .@j == 0; .@j--) {
				if(.@index[.@j] == .@index[.@i]) {
					set .@optAmt, 0; // Null affix amount
				}
			}
		}
	}

	// Fixate affixes
	for (set .@i, 0; .@i < .@optAmt; .@i++) {
		set .@OptID[.@i], .@optionid[.@index[.@i]];
		set .@OptVal[.@i], (.@roabase[.@index[.@i]] + rand(0, .@roabonus[.@index[.@i]]));
	}

	// Drop item
	getmapxy(.@map$, .@x, .@y, BL_PC);
	makeitem3 .@id,1,.@map$,rand(.@x-1,.@x+1),rand(.@y-1,.@y+1),0,0,0,0,0,0,0,.@OptID,.@OptVal,.@OptParam;
	end;
}
