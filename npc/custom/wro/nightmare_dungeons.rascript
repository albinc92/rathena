-	script	Nightmare_Warper	-1,{

	//cutin "nov_magicsoul01",2;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "H-h-heey thee-re~~";
	next;

	if(strnpcinfo(2) == "anthell") {
		set .@dungeon$, "anthell01";
		set .@x, 0;
		set .@y, 0;
	}

	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "W-would you li-ike to enter the N-Nightmare version of this dungeon~~?";

	
	set .@menu, select("Enter Dungeon:Information:Cancel");
	if(.@menu == 2) {
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "Sweet duude ~~";
		next;
		warp "quiz_02", 55, 85;
	}
	if(.@menu == 3) {
		close2;
		cutin "", 255;
		end;
	}

	next;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "Good luck!";
	
	specialeffect2 EF_READYPORTAL;
	specialeffect2 EF_TELEPORTATION;
	specialeffect2 EF_PORTAL;
	sleep2 1600;
	warp .@dungeon$,.@x,.@y;

	end;
}



// Duplicates
//============================================================
cmd_fild08,327,358,6	duplicate(Nightmare_Warper)	Nightmare Warper#anthell	999
