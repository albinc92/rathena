//
// Gain bonuses to exp by killing monsters in succession before the timer runs
// out.
//
-	script	mobbing	-1,{

OnPCDieEvent:
OnPCLoadMapEvent:
	if(!getmapflag(strcharinfo(3),mf_pvp)) {
		set @mobCombo, 0;
		set @mobCombo2, 0;
		set @bExp, 0;
		set @jExp, 0;
		deltimer strnpcinfo(0)+"::OnComboEnd";
	}
	end;

OnNPCKillEvent:
	if(!getmapflag(strcharinfo(3),mf_pvp) || (@BaseLevel < 250 && @JobLevel < 70)) {
		++@mobCombo;
		if(@BaseLevel < 250) { @bExp += strmobinfo(6, killedrid); }
		if(@JobLevel < 70) { @jExp += strmobinfo(7, killedrid); }
		deltimer strnpcinfo(0)+"::OnComboEnd";
		addtimer 1000,strnpcinfo(0)+"::OnComboEnd";
	}
	end;

OnComboEnd:
	if(@mobCombo < 2) {
		set @mobCombo, 0;
		set @mobCombo2, 0;
		set @bExp, 0;
		set @jExp, 0;
		end;
	}

	set @mobCombo2, @mobCombo;
	if(@mobCombo > 5) {	// Limit exp gain by 10 mobs at once
		set @mobCombo2, 5;
	}

	getexp @bExp, @jExp;
	specialeffect2 799;
	message strcharinfo(0),"You received bonus experience by killing " + @mobCombo + " monsters at the same time!";
	set @mobCombo, 0;
	set @mobCombo2, 0;
	set @bExp, 0;
	set @jExp, 0;
	end;
}
