//============================================================
// Script
//============================================================
-	script	Nightmare_Warper	-1,{

	//cutin "nov_magicsoul01",2;
	mes "^0000ff[" + strnpcinfo(1) + "]^000000";
	mes "H-Hello a-adventurer~~!";
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
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
		mes "N-Nightmare Dungeons a-are esse-entially much harder versions of dungeons.";
		next;
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
		mes "In Nightmare D-Dungeons, mo-onsters will appear at a s-substantially higher le-evel than in their no-ormal counterparts.";
		next;
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
		mes "N-Not only that, they mi-ight eeven have more p-powerful abilities at t-their disposal aswell. So b-be careful!";
		next;
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
		mes "It is re-ecommended that you a-acquire a hi-igh level and a-appropriate equipment befor-re you attempt to v-venture down one of them!";
		next;
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
		mes "Now, w-why would a-anyone risk such a v-venture you ask? Well, b-because of the po-otential rewards of course!";
		next;
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
		mes "In Nightmare D-Dungeons, monsters w-will drrop mo-ore and better loot!";
		next;
		mes "^0000ff[" + strnpcinfo(1) + "]^000000";
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
anthell01n,0,0,3	duplicate(Fairy Deadleaf#1)	Fairy Deadleaf#7	613
anthell01n,0,0,3	duplicate(Fairy Deadleaf#1)	Fairy Deadleaf#8	613

// Mining
anthell01n,0,0,3	duplicate(Cyberium Deposit#1)	Cyberium Deposit#5	10248
anthell01n,0,0,3	duplicate(Cyberium Deposit#1)	Cyberium Deposit#6	10248
anthell01n,0,0,3	duplicate(Cyberium Deposit#1)	Cyberium Deposit#7	10248
anthell01n,0,0,3	duplicate(Cyberium Deposit#1)	Cyberium Deposit#8	10248



//============================================================
// Warps
//============================================================
anthell01n,35,267,0	warp	anthell01n_cmd_fild08	1,1,cmd_fild08,330,355



//============================================================
// Monsters
//============================================================

// anthell01n - Ant Hell Nightmare F1
anthell01n,0,0	monster	Nightmare Familiar	5005,20
anthell01n,0,0	monster	Nightmare Andre	5095,15
anthell01n,0,0	monster	Nightmare Piere	5160,50
anthell01n,0,0	monster	Nightmare Deniro	5105,40
anthell01n,0,0	monster	Nightmare Vitata	5176,10
anthell01n,0,0	monster	Nightmare Giearth	5121,1
anthell01n,0,0	monster	Nightmare Maya Purple	5289,1,7200000,3600000
anthell01n,28,266	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,29,266	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,28,265	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,28,264	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,28,263	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,28,262	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,29,265	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,29,264	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,29,263	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,29,262	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,265	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,264	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,263	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,262	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,261	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,264	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,263	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,262	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,263	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,270	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,269	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,268	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,267	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,266	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,265	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,269	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,268	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,267	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,266	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,265	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,198	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,198	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,197	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,196	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,195	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,195	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,194	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,33,195	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,33,196	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,190	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,190	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,189	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,198	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,187	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,32,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,31,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,40,168	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,168	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,42,168	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,42,167	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,42,166	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,42,165	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,41,165	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,43,165	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,44,165	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,45,165	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,44,166	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,43,166	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,30,187	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,29,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,38,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,37,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,36,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,35,186	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,36,187	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,38,184	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,38,183	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,37,183	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,99,127	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,98,127	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,97,127	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,97,126	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,97,125	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,97,124	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,97,123	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,98,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,99,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,100,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,101,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,102,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,104,123	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,104,122	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,104,120	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,103,120	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,103,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,102,121	monster	Nightmare Ant Egg	5097,1,60000,30000
anthell01n,105,124	monster	Nightmare Ant Egg	5097,1,60000,30000
