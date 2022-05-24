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

ACMD_FUNC(professions)
{
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

ACMD_FUNC(showrank)
{
  return 0;
}

ACMD_FUNC(pvpscore)
{
  return 0;
}

ACMD_FUNC(battlestats)
{
  clif_displaymessage(fd, "------ Battle Stats ------");
  clif_displaymessage(fd, "Fire resistance: +" + sd->indexed_bonus.subele[ELE_FIRE] + "%");
  clif_displaymessage(fd, "After-cast delay: -" + sd->status.delayrate + "%");
  clif_displaymessage(fd, "Better chance of finding magic items: +" + sd->status.magicfindrate + "%");
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
