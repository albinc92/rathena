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
  std::vector<msg_val> sub_ele, rate_data, misc_data;
	char buf[50] = "";

  sub_ele.push_back({"Neutral : %d%%", sd->indexed_bonus.subele[ELE_NEUTRAL] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_NEUTRAL] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Water :%d%%", sd->indexed_bonus.subele[ELE_WATER] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_WATER] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Earth :%d%%", sd->indexed_bonus.subele[ELE_EARTH] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_EARTH] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Fire :%d%%", sd->indexed_bonus.subele[ELE_FIRE] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_FIRE] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Wind :%d%%", sd->indexed_bonus.subele[ELE_WIND] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_WIND] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Poison :%d%%", sd->indexed_bonus.subele[ELE_POISON] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_POISON] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Holy :%d%%", sd->indexed_bonus.subele[ELE_HOLY] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_HOLY] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Shadow :%d%%", sd->indexed_bonus.subele[ELE_DARK] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_DARK] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Ghost :%d%%", sd->indexed_bonus.subele[ELE_GHOST] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_GHOST] + sd->indexed_bonus.subele_script[ELE_ALL]});
  sub_ele.push_back({"Undead :%d%%", sd->indexed_bonus.subele[ELE_UNDEAD] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_UNDEAD] + sd->indexed_bonus.subele_script[ELE_ALL]});

  clif_displaymessage(fd, "------ Elemental Resistances ------");
	for(auto it : sub_ele) {
        sprintf(buf, it.msg.c_str(), it.val);
        clif_displaymessage(fd, buf);
	}

  rate_data.push_back({"Cast time : %d%%", sd->castrate});
  rate_data.push_back({"After-cast delay : %d%%", sd->delayrate});
  rate_data.push_back({"Maximum HP : %d%%", sd->hprate});
  rate_data.push_back({"Maximum SP : %d%%", sd->sprate});
  rate_data.push_back({"SP consumption : %d%%", sd->dsprate});
  rate_data.push_back({"HP recovery : %d%%", sd->hprecov_rate});
  rate_data.push_back({"SP recovery : %d%%", sd->sprecov_rate});
  rate_data.push_back({"MATK : %d%%", sd->matk_rate});

  clif_displaymessage(fd, "------ Rate-based ------");
	for(auto it : rate_data) {
        sprintf(buf, it.msg.c_str(), it.val);
        clif_displaymessage(fd, buf);
	}

  rate_data.push_back({"Better chance of getting magic items : %d%%", sd->bonus.magic_find});

  clif_displaymessage(fd, "------ Miscellaneous ------");
	for(auto it : rate_data) {
        sprintf(buf, it.msg.c_str(), it.val);
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
