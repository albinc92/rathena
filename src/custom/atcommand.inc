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
  std::vector<msg_val> data_info;

  data_info.push_back({"Neutral : %d%%", sd->s_indexed_bonus.subele[ELE_NEUTRAL]});
  data_info.push_back({"Water   : %d%%", sd->s_indexed_bonus.subele[ELE_WATER]});
  data_info.push_back({"Earth   : %d%%", sd->s_indexed_bonus.subele[ELE_EARTH]});
  data_info.push_back({"Fire    : %d%%", sd->s_indexed_bonus.subele[ELE_FIRE]});
  data_info.push_back({"Wind    : %d%%", sd->s_indexed_bonus.subele[ELE_WIND]});
  data_info.push_back({"Poison  : %d%%", sd->s_indexed_bonus.subele[ELE_POISON]});
  data_info.push_back({"Holy    : %d%%", sd->s_indexed_bonus.subele[ELE_HOLY]});
  data_info.push_back({"Shadow  : %d%%", sd->s_indexed_bonus.subele[ELE_DARK]});
  data_info.push_back({"Ghost   : %d%%", sd->s_indexed_bonus.subele[ELE_GHOST]});
  data_info.push_back({"Undead  : %d%%", sd->s_indexed_bonus.subele[ELE_UNDEAD]});
  data_info.push_back({"All     : %d%%", sd->s_indexed_bonus.subele[ELE_ALL]});

	char buf[50] = "";
  clif_displaymessage(fd, "------ Elemental Resistances ------");
	for(auto curr : data_info) {
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
