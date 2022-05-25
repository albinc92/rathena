// Copyright (c) rAthena Dev Teams - Licensed under GNU GPL
// For more information, see LICENCE in the main folder

/**
 * Custom Atcommands
 * Place the body of custom atcommands in this file.
 * Format:
 *	ACMD_FUNC(command_name)
 *	{
 *		<code>;
 *	}
 **/

//ACMD_FUNC(newcommand)
//{
//	clif_displaymessage(fd, "It works!");
//	clif_specialeffect(&sd->bl, EF_HEARTCASTING, AREA);
//	return 0;
//}

ACMD_FUNC(arealoot)
{
 if (sd->state.arealoot) {
  sd->state.arealoot = 0;
  clif_displaymessage(fd, "Area loot is now deactivated!");
  return 0;
 }

 sd->state.arealoot = 1;
 clif_displaymessage(fd, "Area loot is now activated!");

 return 0;
}

ACMD_FUNC(battlestats)
{
  struct msg_val { std::string msg; int val; };
  std::vector<msg_val> sub_ele, misc;
	char buf[50] = "";

  sub_ele.push_back({"Neutral resistance : %d%%", sd->indexed_bonus.subele[ELE_NEUTRAL] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_NEUTRAL] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Water resistance :%d%%", sd->indexed_bonus.subele[ELE_WATER] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_WATER] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Earth resistance :%d%%", sd->indexed_bonus.subele[ELE_EARTH] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_EARTH] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Fire resistance :%d%%", sd->indexed_bonus.subele[ELE_FIRE] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_FIRE] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Wind resistance :%d%%", sd->indexed_bonus.subele[ELE_WIND] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_WIND] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Poison resistance :%d%%", sd->indexed_bonus.subele[ELE_POISON] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_POISON] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Holy resistance :%d%%", sd->indexed_bonus.subele[ELE_HOLY] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_HOLY] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Shadow resistance :%d%%", sd->indexed_bonus.subele[ELE_DARK] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_DARK] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Ghost resistance :%d%%", sd->indexed_bonus.subele[ELE_GHOST] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_GHOST] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Undead resistance :%d%%", sd->indexed_bonus.subele[ELE_UNDEAD] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_UNDEAD] + sd->indexed_bonus.subele_script[ELE_ALL]});

  clif_displaymessage(fd, "------ Damage Reduction Against Attack Element ------");
	for(auto curr : sub_ele) {
        sprintf(buf, curr.msg.c_str(), curr.val);
        clif_displaymessage(fd, buf);
	}

  misc.push_back({"Reduced casting time : %d%%", sd->castrate});
  misc.push_back({"Reduced after-cast delay : %d%%", sd->delayrate});
  misc.push_back({"Maximum HP : %d%%", sd->hprate});
  misc.push_back({"Maximum SP : %d%%", sd->sprate});
  misc.push_back({"Reduced SP consumption : %d", sd->dsprate});
  misc.push_back({"HP regeneration : %d", sd->hprecov_rate});
  misc.push_back({"SP regeneration : %d", sd->sprecov_rate});
  misc.push_back({"Matk rate : %d", sd->matk_rate});
  misc.push_back({"Better chance of getting magic items : %d%%", sd->mf_rate});

  clif_displaymessage(fd, "------ Miscellaneous Statuses ------");
	for(auto curr : misc) {
        sprintf(buf, curr.msg.c_str(), curr.val);
        clif_displaymessage(fd, buf);
	}

  return 0;
}

ACMD_FUNC(headhunter)
{
  return 0;
}

ACMD_FUNC(hints)
{
  return 0;
}

ACMD_FUNC(professions)
{
  return 0;
}

ACMD_FUNC(pvpscore)
{
  return 0;
}

ACMD_FUNC(whosell)
{
  return 0;
}

ACMD_FUNC(whobuy)
{
  return 0;
}
