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
  nullpo_retr(-1, sd);

  if(!message || !*message) {
    clif_displaymessage(fd, "Please provide a parameter: <1=defensive|2=offensive|3=other>");
    return 0;
  }

	int type = atoi(message);
  if (type < 1 || type > 3) {
    clif_displaymessage(fd, "Please provide a parameter: <1=defensive|2=offensive|3=other>");
    return 0;
  }

  struct msg_val { std::string msg; int val; };
  std::vector<msg_val> data;
	char buf[50] = "";

  // Defensive stats
  if(type == 1) {
    data.push_back({"----- Resistance VS. Element -----", 0});
    data.push_back({"Neutral : %d%%", sd->indexed_bonus.subele[ELE_NEUTRAL] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_NEUTRAL] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Water : %d%%", sd->indexed_bonus.subele[ELE_WATER] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_WATER] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Earth : %d%%", sd->indexed_bonus.subele[ELE_EARTH] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_EARTH] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Fire : %d%%", sd->indexed_bonus.subele[ELE_FIRE] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_FIRE] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Wind : %d%%", sd->indexed_bonus.subele[ELE_WIND] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_WIND] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Poison : %d%%", sd->indexed_bonus.subele[ELE_POISON] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_POISON] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Holy : %d%%", sd->indexed_bonus.subele[ELE_HOLY] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_HOLY] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Shadow : %d%%", sd->indexed_bonus.subele[ELE_DARK] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_DARK] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Ghost : %d%%", sd->indexed_bonus.subele[ELE_GHOST] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_GHOST] + sd->indexed_bonus.subele_script[ELE_ALL]});
    data.push_back({"Undead : %d%%", sd->indexed_bonus.subele[ELE_UNDEAD] + sd->indexed_bonus.subele[ELE_ALL] + sd->indexed_bonus.subele_script[ELE_UNDEAD] + sd->indexed_bonus.subele_script[ELE_ALL]});

    data.push_back({"----- Physical Resistance VS. Enemy With Defense Element -----", 0});
    data.push_back({"Neutral : %d%%", sd->indexed_bonus.subdefele[ELE_NEUTRAL] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Water : %d%%", sd->indexed_bonus.subdefele[ELE_WATER] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Earth : %d%%", sd->indexed_bonus.subdefele[ELE_EARTH] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Fire : %d%%", sd->indexed_bonus.subdefele[ELE_FIRE] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Wind : %d%%", sd->indexed_bonus.subdefele[ELE_WIND] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Poison : %d%%", sd->indexed_bonus.subdefele[ELE_POISON] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Holy : %d%%", sd->indexed_bonus.subdefele[ELE_HOLY] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Shadow : %d%%", sd->indexed_bonus.subdefele[ELE_DARK] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Ghost : %d%%", sd->indexed_bonus.subdefele[ELE_GHOST] + sd->indexed_bonus.subdefele[ELE_ALL]});
    data.push_back({"Undead : %d%%", sd->indexed_bonus.subdefele[ELE_UNDEAD] + sd->indexed_bonus.subdefele[ELE_ALL]});

    data.push_back({"----- Magical Resistance VS. Enemy With Defense Element -----", 0});
    data.push_back({"Neutral : %d%%", sd->indexed_bonus.magic_subdefele[ELE_NEUTRAL] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Water : %d%%", sd->indexed_bonus.magic_subdefele[ELE_WATER] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Earth : %d%%", sd->indexed_bonus.magic_subdefele[ELE_EARTH] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Fire : %d%%", sd->indexed_bonus.magic_subdefele[ELE_FIRE] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Wind : %d%%", sd->indexed_bonus.magic_subdefele[ELE_WIND] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Poison : %d%%", sd->indexed_bonus.magic_subdefele[ELE_POISON] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Holy : %d%%", sd->indexed_bonus.magic_subdefele[ELE_HOLY] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Shadow : %d%%", sd->indexed_bonus.magic_subdefele[ELE_DARK] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Ghost : %d%%", sd->indexed_bonus.magic_subdefele[ELE_GHOST] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});
    data.push_back({"Undead : %d%%", sd->indexed_bonus.magic_subdefele[ELE_UNDEAD] + sd->indexed_bonus.magic_subdefele[ELE_ALL]});

    data.push_back({"----- Resistance VS. Race -----", 0});
    data.push_back({"Formless : %d%%", sd->indexed_bonus.subrace[RC_FORMLESS] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Undead : %d%%", sd->indexed_bonus.subrace[RC_UNDEAD] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Brute : %d%%", sd->indexed_bonus.subrace[RC_BRUTE] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Plant : %d%%", sd->indexed_bonus.subrace[RC_PLANT] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Insect : %d%%", sd->indexed_bonus.subrace[RC_INSECT] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Fish : %d%%", sd->indexed_bonus.subrace[RC_FISH] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Demon : %d%%", sd->indexed_bonus.subrace[RC_DEMON] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Demi-human : %d%%", sd->indexed_bonus.subrace[RC_DEMIHUMAN] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Angel : %d%%", sd->indexed_bonus.subrace[RC_ANGEL] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Dragon : %d%%", sd->indexed_bonus.subrace[RC_DRAGON] + sd->indexed_bonus.subrace[RC_ALL]});
    data.push_back({"Player : %d%%", sd->indexed_bonus.subrace[RC_PLAYER_HUMAN] + sd->indexed_bonus.subrace[RC_ALL]});

    data.push_back({"----- Resistance VS. Class -----", 0});
    data.push_back({"Normal : %d%%", sd->indexed_bonus.subclass[CLASS_NORMAL] + sd->indexed_bonus.subclass[CLASS_ALL]});
    data.push_back({"Boss : %d%%", sd->indexed_bonus.subclass[CLASS_BOSS] + sd->indexed_bonus.subclass[CLASS_ALL]});
    data.push_back({"Guardian : %d%%", sd->indexed_bonus.subclass[CLASS_GUARDIAN] + sd->indexed_bonus.subclass[CLASS_ALL]});
    data.push_back({"Battlefield : %d%%", sd->indexed_bonus.subclass[CLASS_BATTLEFIELD] + sd->indexed_bonus.subclass[CLASS_ALL]});

    data.push_back({"----- Physical Resistance VS. Size -----", 0});
    data.push_back({"Small : %d%%", sd->indexed_bonus.subsize[SZ_SMALL] + sd->indexed_bonus.subsize[SZ_ALL]});
    data.push_back({"Medium : %d%%", sd->indexed_bonus.subsize[SZ_MEDIUM] + sd->indexed_bonus.subsize[SZ_ALL]});
    data.push_back({"Large : %d%%", sd->indexed_bonus.subsize[SZ_BIG] + sd->indexed_bonus.subsize[SZ_ALL]});

    data.push_back({"----- Magical Resistance VS. Size -----", 0});
    data.push_back({"Small : %d%%", sd->indexed_bonus.magic_subsize[SZ_SMALL] + sd->indexed_bonus.magic_subsize[SZ_ALL]});
    data.push_back({"Medium :%d%%", sd->indexed_bonus.magic_subsize[SZ_MEDIUM] + sd->indexed_bonus.magic_subsize[SZ_ALL]});
    data.push_back({"Large :%d%%", sd->indexed_bonus.magic_subsize[SZ_BIG] + sd->indexed_bonus.magic_subsize[SZ_ALL]});
  }

  // Offensive stats
  else if(type == 1) {
    data.push_back({"----- Coming Soon -----", 0});
  }

  // Misc stats
  else if(type == 3) {
    data.push_back({"----- Rate-based -----", 0});
    data.push_back({"Cast time : %d%%", sd->castrate});
    data.push_back({"After-cast delay : %d%%", sd->delayrate});
    data.push_back({"Maximum HP : %d%%", sd->hprate});
    data.push_back({"Maximum SP : %d%%", sd->sprate});
    data.push_back({"SP consumption : %d%%", sd->dsprate});
    data.push_back({"HP recovery : %d%%", sd->hprecov_rate});
    data.push_back({"SP recovery : %d%%", sd->sprecov_rate});
    data.push_back({"MATK : %d%%", sd->matk_rate});

    data.push_back({"----- Drop Related -----", 0});
    data.push_back({"Better chance of getting magic items : %d%%", sd->bonus.magic_find});
  }

	for(auto it : data) {
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
