//============================================================
// Script
//============================================================
-	script	Nightmare_Warper	-1,{

	//cutin "nov_magicsoul01",2;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "H-h-heey thee-re~~";
	next;

	if(strnpcinfo(2) == "anthell") {
		set .@name$, "Anthell";
		set .@dungeon$, "anthell01n";
		set .@x, 35;
		set .@y, 262;
	}

L_Main:
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "W-would you li-ike to enter the N-Nightmare version of ^ff0000" + .@name$ + "^000000~~?";

	set .@menu, select("Enter:Information:Cancel");
	if(.@menu == 2) {
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "N-Nightmare Dungeons a-are esse-entially much harder versions of dungeons.";
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "In Nightmare D-Dungeons, mo-onsters will appear at a s-substantially higher le-evel than in their no-ormal counterparts.";
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "N-Not only that, they mi-ight eeven have more p-powerful abilities at t-their disposal aswell. So b-be careful!";
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "It is re-ecommended that you a-acquire a hi-igh level and a-appropriate equipment befor-re you attempt to v-venture down one of them!";
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "Now, w-why would a-anyone risk such a v-venture you ask? Well, b-because of the po-otential rewards of course!";
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "In Nightmare D-Dungeons, monsters w-will drrop mo-ore and better loot!";
		next;
		mes "["+strnpcinfo(1)+"]";
		mes "N-Not to mention the p-presencce of high-level G-Gathering Nodes, a-as well as s-some other go-odies!";
		next;
		goto L_Main;
	} else if(.@menu == 3) {
		close2;
		cutin "", 255;
		end;
	}

	next;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "G-Go fourth~~!";
	
	specialeffect2 EF_READYPORTAL;
	specialeffect2 EF_TELEPORTATION;
	specialeffect2 EF_PORTAL;
	sleep2 1600;
	warp .@dungeon$,.@x,.@y;

	close2;
	cutin "", 255;
	end;
}



//============================================================
// Duplicates
//============================================================
cmd_fild08,327,358,6	duplicate(Nightmare_Warper)	Nightmare Dungeon Warper#anthell	999



//============================================================
// Gathering Nodes
//============================================================

// Herbalism
anthell01n,0,0,3	duplicate(Fairy Deadleaf#1)	Fairy Deadleaf#5	613
anthell01n,0,0,3	duplicate(Fairy Deadleaf#1)	Fairy Deadleaf#6	613

// Mining
anthell01n,0,0,3	duplicate(Cyberium Deposit#1)	Cyberium Deposit#5	10248
anthell01n,0,0,3	duplicate(Cyberium Deposit#1)	Cyberium Deposit#6	10248



//============================================================
// Warps
//============================================================
anthell01n,35,267,0	warp	anthell01n_cmd_fild08	1,1,cmd_fild08,330,355
