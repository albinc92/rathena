-	script	drops	-1,{

OnNPCKillEvent:

	// No drop?
	set .@drop, rand(1, (1000 + readparam(bLuk)));
	if(.@drop < 100) {
		end;
	}

	set .@moblv, getmonsterinfo(killedrid, MOB_LV);
	.@count = query_sql("SELECT `id` FROM `drop_armor` WHERE `item_level` <= " + .@moblv + " ORDER BY `item_level` ASC", .@drops);

	if(!.@count) {
		end;
	}

	getmapxy(.@map$, .@x, .@y, BL_PC);
	setarray .@OptID[0],RDMOPT_ATTR_TOLERACE_NOTHING,RDMOPT_RACE_TOLERACE_HUMAN;
	setarray .@OptVal[0],10,5;
	setarray .@OptParam[0],0;
	makeitem3 .@drops[rand(0,(getarraysize(.@drops)-1))],1,.@map$,rand(.@x-1,.@x+1),rand(.@y-1,.@y+1),0,0,0,0,0,0,0,.@OptID,.@OptVal,.@OptParam;
	end;
}
