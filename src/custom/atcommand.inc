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
