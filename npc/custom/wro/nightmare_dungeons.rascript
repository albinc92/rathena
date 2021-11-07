-	script	Nightmare_Warper	-1,{

	//cutin "nov_magicsoul01",2;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";

	if(strnpcinfo(2) == "anthell") {
		set .@dungeon$, "anthell01";
		set .@x, 0;
		set .@y, 0;
		message strcharinfo(0), "This is the Anthell warper.";
	}

	next;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	message strcharinfo(0), "Good luck!";
	
	specialeffect2 EF_READYPORTAL;
	specialeffect2 EF_TELEPORTATION;
	specialeffect2 EF_PORTAL;
	sleep2 1600;
	warp .@dungeon$,.@x,.@y;

	end;
}



// Duplicates
//============================================================
cmd_fild08,25,240,6	duplicate(Nightmare_Warper)	Nightmare Warper#anthell	999
