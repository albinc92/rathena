-- ---------------------------------------------------------------------------------------------------------------------
--                                             WarboundRO custom changes
-- ---------------------------------------------------------------------------------------------------------------------

DELETE FROM `item_db2`;
DELETE FROM `mob_db2`;
DELETE FROM `mob_skill_db2`;
DELETE FROM `item_cash_db2`;

-- ---------------------------------------------------------------------------------------------------------------------
--                                                   wro_tables
-- ---------------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `wroaccdata` (
    `account_id` int(11) unsigned NOT NULL default '0',
    `hints` int(11) NOT NULL default '1',
    PRIMARY KEY (`account_id`),
    KEY `account_id` (`account_id`)
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS `wrochardata` (
    `char_id` int(11) unsigned NOT NULL default '0',
    `intro` int(11) NOT NULL default '0',
    `mainquest` int(11) NOT NULL default '0',
    PRIMARY KEY (`char_id`),
    KEY `char_id` (`char_id`)
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS `headhunter` (
    `char_id` int(11) unsigned NOT NULL default '0',
    `mob_id` mediumint(9) unsigned NOT NULL default '0',
    `count` tinyint(6) unsigned NOT NULL default '0',
    `max` tinyint(6) unsigned NOT NULL default '0',
    `zeny` int(11) unsigned NOT NULL default '0',
    PRIMARY KEY (`char_id`),
    KEY `char_id` (`char_id`)
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS `drop_armor` (
    `id` int(10) unsigned NOT NULL DEFAULT '0',
    `item_level` tinyint(3) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=MyISAM;

CREATE TABLE IF NOT EXISTS `drop_shield` (
    `id` int(10) unsigned NOT NULL DEFAULT '0',
    `item_level` tinyint(3) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE=MyISAM;

-- ---------------------------------------------------------------------------------------------------------------------
--                                                     item_db
-- ---------------------------------------------------------------------------------------------------------------------

REPLACE INTO `drop_armor`
SELECT `id`, `equip_level_min`
FROM `item_db`
WHERE `id` IN (
    2301,
    2302,
    2303,
    2304,
    2305,
    2306,
    2308,
    2310,
    2311,
    2312,
    2313,
    2315,
    2316,
    2317,
    2318,
    2319,
    2320,
    2322,
    2324,
    2326,
    2327,
    2329,
    2331,
    2333,
    2334,
    2336,
    2337,
    2338,
    2339,
    2342,
    2343,
    2344,
    2345,
    2346,
    2347,
    2348,
    2350,
    2353,
    2354,
    2355,
    2357,
    2364,
    2365,
    2366,
    2367,
    2374,
    2375,
    2386,
    2387,
    2388,
    2389,
    2390,
    2391,
    15000
);

UPDATE `drop_armor` da
SET `item_level` = (SELECT (`defense` * 4) FROM `item_db` idb WHERE idb.id = da.id)
WHERE `item_level` IS NULL;

-- Wedding Dress
UPDATE `drop_armor` SET `item_level` = 30 WHERE `id` = 2338;

-- Valk Armor
UPDATE `drop_armor` SET `item_level` = 92 WHERE `id` = 2357;

REPLACE INTO `drop_shield`
SELECT `id`, `equip_level_min`
FROM `item_db`
WHERE `id` IN (
    2101,
    2102,
    2104,
    2106,
    2108,
    2109,
    2110,
    2111,
    2114,
    2115,
    2116,
    2122,
    2123,
    2124,
    2125,
    2129,
    2130,
    2131,
    2133,
    2134,
    2135,
    2138
);

-- Mirror Shield
UPDATE `drop_shield` SET `item_level` = 50 WHERE `id` = 2108;

-- Memory Book
UPDATE `drop_shield` SET `item_level` = 32 WHERE `id` = 2109;

UPDATE `drop_shield` ds
SET `item_level` = (SELECT (`defense` * 4) FROM `item_db` idb WHERE idb.id = ds.id)
WHERE `item_level` IS NULL;

-- Copies all weapons of weapon lvl > 1 from item_db into item_db2
-- Updates ATK of all weapons based on weapon level
-- to make them more viable in comparison to carded
-- 4 socketed alternatives
REPLACE INTO `item_db2` SELECT * FROM `item_db` WHERE `weapon_level` > 1;
UPDATE `item_db2` SET `script` = CONCAT(`script`, " bonus2 bAddClass,Class_All,25;") WHERE `weapon_level` = 2;
UPDATE `item_db2` SET `script` = CONCAT(`script`, " bonus2 bAddClass,Class_All,50;") WHERE `weapon_level` = 3;
UPDATE `item_db2` SET `script` = CONCAT(`script`, " bonus2 bAddClass,Class_All,75;") WHERE `weapon_level` = 4;

-- Create costume copies of all headgears in item_db
-- and updates their stats to reflect their nature.
REPLACE INTO `item_db2`
SELECT * FROM `item_db`
WHERE `type` = 'Armor'
AND (`location_head_top` = true
OR `location_head_mid` = true
OR `location_head_low` = true);

UPDATE `item_db2`
SET `id` = `id` + 41000,
    `alias_name` = `name_aegis`,
    `name_aegis` = CONCAT('C_', `name_aegis`),
    `name_english` = CONCAT('C_', `name_english`),
    `price_buy` = 0,
    `price_sell` = 0,
    `weight` = 0,
    `defense` = 0,
    `slots` = 0,
    `job_all` = true,
    `class_all` = true,
    `gender` = 'Both',
    `equip_level_min` = 0,
    `equip_level_max` = 250,
    `refineable` = true,
    `trade_nodrop` = false,
    `trade_notrade` = false,
    `trade_tradepartner` = false,
    `trade_nosell` = false,
    `trade_nocart` = false,
    `trade_nostorage` = false,
    `trade_noguildstorage` = false,
    `trade_nomail` = false,
    `trade_noauction` = false,
    `script` = '',
    `equip_script` = '',
    `unequip_script` = ''
WHERE `type` = 'Armor'
AND (`location_head_top` = true
OR `location_head_mid` = true
OR `location_head_low` = true);

UPDATE `item_db2`
SET  `location_costume_head_top` = true
WHERE `type` = 'Armor'
AND `location_head_top` = true;

UPDATE `item_db2`
SET  `location_costume_head_mid` = true
WHERE `type` = 'Armor'
AND `location_head_mid` = true;

UPDATE `item_db2`
SET  `location_costume_head_low` = true
WHERE `type` = 'Armor'
AND `location_head_low` = true;

UPDATE `item_db2`
SET  `location_head_top` = false, `location_head_mid` = false, `location_head_low` = false
WHERE `type` = 'Armor'
AND (`location_head_top` = true
OR `location_head_mid` = true
OR `location_head_low` = true);

-- Copy all headgears to item_db2 and set their sell flag to true
-- This part must come after the costume headgear commands, otherwise
-- they will be overwritten as costume headgears.
REPLACE INTO `item_db2`
SELECT * FROM `item_db`
WHERE `type` = 'Armor'
AND (`location_head_top` = true
OR `location_head_mid` = true
OR `location_head_low` = true);

UPDATE `item_db2`
SET `trade_nodrop` = false,
    `trade_notrade` = false,
    `trade_tradepartner` = false,
    `trade_nosell` = false,
    `trade_nocart` = false,
    `trade_nostorage` = false,
    `trade_noguildstorage` = false,
    `trade_nomail` = false,
    `trade_noauction` = false
WHERE `type` = 'Armor' AND (`location_head_top` = true OR `location_head_mid` = true OR `location_head_low` = true);

-- Make all quest items non-sellable etc.
REPLACE INTO `item_db2`
SELECT * FROM `item_db`
WHERE `id` IN (7160, 7285, 7287, 7181);

UPDATE `item_db2`
SET `weight` = 0,
    `trade_nodrop` = true,
    `trade_notrade` = true,
    `trade_tradepartner` = false,
    `trade_nosell` = true,
    `trade_nocart` = true,
    `trade_nostorage` = true,
    `trade_noguildstorage` = true,
    `trade_nomail` = true,
    `trade_noauction` = true
WHERE `id` IN (7160, 7285, 7287, 7181);

-- Make certain items droppable etc.
REPLACE INTO `item_db2`
SELECT * FROM `item_db`
WHERE `id` IN (7821);

UPDATE `item_db2`
SET `trade_nodrop` = false,
    `trade_notrade` = false,
    `trade_tradepartner` = true,
    `trade_nosell` = false,
    `trade_nocart` = false,
    `trade_nostorage` = false,
    `trade_noguildstorage` = false,
    `trade_nomail` = false,
    `trade_noauction` = false
WHERE `id` IN (7821);

-- Make PvP Gear Sellable, Storeable, etc.
REPLACE INTO `item_db2`
SELECT * FROM `item_db`
WHERE (`name_english` LIKE "Glorious %"
OR `name_english` LIKE "Valorous %"
OR `name_english` LIKE "Brave %"
OR `name_english` LIKE "Soldier %"
OR `name_english` LIKE "Soldier %"
OR `name_english` LIKE "Soldier %"
OR `name_english` LIKE "Captain's %"
OR `name_english` LIKE "Commander's %"
OR `name_english` LIKE "Medal of Honor"
OR `id` IN (2435, 2436, 2437, 2376, 2377, 2378, 2379, 2380, 2381, 2382))
AND `name_english` NOT LIKE "% Card";

UPDATE `item_db2`
SET `trade_nodrop` = true,
    `trade_notrade` = true,
    `trade_tradepartner` = true,
    `trade_nosell` = false,
    `trade_nocart` = false,
    `trade_nostorage` = false,
    `trade_noguildstorage` = true,
    `trade_nomail` = true,
    `trade_noauction` = true
WHERE (`name_english` LIKE "Glorious %"
OR `name_english` LIKE "Valorous %"
OR `name_english` LIKE "Brave %"
OR `name_english` LIKE "Soldier %"
OR `name_english` LIKE "Soldier %"
OR `name_english` LIKE "Soldier %"
OR `name_english` LIKE "Captain's %"
OR `name_english` LIKE "Commander's %"
OR `name_english` LIKE "Medal of Honor"
OR `id` IN (2435, 2436, 2437, 2376, 2377, 2378, 2379, 2380, 2381, 2382))
AND `name_english` NOT LIKE "% Card";

-- Update scripts of MvP cards
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4236,'Amon_Ra_Card','Amon Ra Card','Card',20,10,true,true,'bonus bAllStats,1; bonus3 bAutoSpellWhenHit,"PR_KYRIE",10,(30+70*(readparam(bInt)>=250));');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_garment`,`flag_buyingstore`,`script`,`unequip_script`)
-- VALUES (4359,'B_Eremes_Card','Assassin Cross Card','Card',20,10,true,true,'skill "AS_CLOAKING",3;','sc_end SC_CLOAKING;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4425,'Atroce_Card','Atroce Card','Card',20,10,true,true,'bonus bAtkRate,10; bonus bMaxSPrate,-50; bonus2 bAddRace,RC_Angel,50; bonus2 bAddRace,RC_DemiHuman,50;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4372,'Bacsojin_Card','White Lady Card','Card',20,10,true,true,'bonus bHealPower,15; bonus bUseSPrate,7;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4147,'Baphomet_Card','Baphomet Card','Card',20,10,true,true,'bonus bHit,-75; bonus bSplashRange,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4145,'Berzebub_Card','Berzebub Card','Card',20,10,true,true,'bonus bCastrate,-25;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
-- VALUES (4168,'Dark_Lord_Card','Dark Lord Card','Card',20,10,true,true,'bonus3 bAutoSpellWhenHit,"WZ_METEOR",5,100;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
VALUES (4386,'Detale_Card','Detardeurus Card','Card',20,10,true,true,'bonus bMdef,-5; bonus2 bResEff,Eff_Freeze,10000; bonus5 bAutoSpellWhenHit,"SA_LANDPROTECTOR",1,70,BF_MAGIC,0;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4142,'Doppelganger_Card','Doppelganger Card','Card',20,10,true,true,'bonus bAspdRate,25;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4134,'Dracula_Card','Dracula Card','Card',20,10,true,true,'bonus2 bSPDrainRate,100,5;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4137,'Drake_Card','Drake Card','Card',20,10,true,true,'bonus bNoSizeFix; bonus2 bAddMonsterDropItem,7721,10;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
-- VALUES (4123,'Eddga_Card','Eddga Card','Card',20,10,true,true,'bonus bMaxHPrate,-10; bonus bNoWalkDelay;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
-- VALUES (4330,'Dark_Snake_Lord_Card','Evil Snake Lord Card','Card',20,10,true,true,true,true,'bonus bInt,3; bonus2 bResEff,Eff_Blind,10000; bonus2 bResEff,Eff_Curse,10000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4441,'Fallen_Bishop_Card','Fallen Bishop Hibram Card','Card',20,10,true,true,'bonus bMatkRate,10; bonus bMaxSPrate,-50; bonus2 bMagicAddRace,RC_Angel,50; bonus2 bMagicAddRace,RC_DemiHuman,50;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4324,'Garm_Card','Hatii Card','Card',20,10,true,true,'bonus2 bAddEffWhenHit,Eff_Freeze,5000;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4408,'Gloom_Under_Night_Card','Gloom Under Night Card','Card',20,10,true,true,'bonus2 bAddEle,Ele_Holy,40; bonus2 bAddEle,Ele_Dark,40; bonus2 bAddRace,RC_Angel,40; bonus2 bAddRace,RC_Demon,40;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
-- VALUES (4128,'Golden_Bug_Card','Golden Thief Bug Card','Card',20,10,true,true,'bonus bNoMagicDamage,100; bonus bUseSPrate,100;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (4363,'B_Magaleta_Card','High Priest Card','Card',20,10,true,true,true,'bonus5 bAutoSpellWhenHit,"HP_ASSUMPTIO",1,50,BF_WEAPON|BF_MAGIC,0;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`,`unequip_script`)
-- VALUES (4365,'B_Katrinn_Card','High Wizard Card','Card',20,10,true,true,true,true,'bonus2 bIgnoreMdefClassRate,Class_Normal,100; bonus bCastrate,100; bonus bSPrecovRate,-100;','heal 0,-2000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4374,'Apocalips_H_Card','Vesper Card','Card',20,10,true,true,'bonus bDex,2; bonus2 bIgnoreMdefClassRate,Class_Boss,25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (4430,'Ifrit_Card','Ifrit Card','Card',20,10,true,true,true,'bonus bBaseAtk,(JobLevel/4); bonus bCritical,(JobLevel/4); bonus bHit,(JobLevel/4); bonus3 bAutoSpellWhenHit,"NPC_EARTHQUAKE",5,10;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`,`unequip_script`)
-- VALUES (4263,'Incant_Samurai_Card','Samurai Spector Card','Card',20,10,true,true,'bonus bIgnoreDefClass,Class_Normal; bonus bHPrecovRate,-100; bonus2 bHPLossRate,666,10000;','if((Hp <= 999) && !getmapflag(strcharinfo(3),mf_pvp) && !getmapflag(strcharinfo(3),mf_pvp_noparty) && !getmapflag(strcharinfo(3),mf_pvp_noguild)) { heal (1-Hp),0; } else { heal -999,0; }');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
-- VALUES (4403,'Kiel_Card','Kiel-D-01 Card','Card',20,10,true,true,true,true,'bonus bDelayRate,-30;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4318,'Knight_Windstorm_Card','Stormy Knight Card','Card',20,10,true,true,'bonus3 bAutoSpell,"WZ_STORMGUST",2,20; bonus2 bAddEff,Eff_Freeze,2000;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4419,'Ktullanux_Card','Ktullanux Card','Card',20,10,true,true,'bonus2 bAddEle,Ele_Fire,50; bonus5 bAutoSpellWhenHit,"WZ_FROSTNOVA",10,20,BF_WEAPON|BF_MAGIC,0;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
-- VALUES (4376,'Lady_Tanee_Card','Lady Tanee Card','Card',20,10,true,true,'bonus bMaxHPrate,-40; bonus bMaxSPrate,50; bonus2 bAddMonsterDropItem,513,200; bonus2 bAddItemHealRate,513,600;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
-- VALUES (4357,'B_Seyren_Card','Lord Knight Card','Card',20,10,true,true,true,true,'skill "LK_BERSERK",1; bonus bMaxHPrate,-50;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4276,'Lord_Of_Death_Card','Lord of The Dead Card','Card',20,10,true,true,'bonus3 bAddEff,Eff_Stun,500,ATF_SHORT; bonus3 bAddEff,Eff_Curse,500,ATF_SHORT; bonus3 bAddEff,Eff_Silence,500,ATF_SHORT; bonus3 bAddEff,Eff_Poison,500,ATF_SHORT; bonus3 bAddEff,Eff_Bleeding,500,ATF_SHORT;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
-- VALUES (4146,'Maya_Card','Maya Card','Card',20,10,true,true,'bonus bMagicDamageReturn,50;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4132,'Mistress_Card','Mistress Card','Card',20,10,true,true,true,true,'bonus bNoGemStone; bonus bUseSPrate,25; bonus3 bAutoSpellWhenHit,"WZ_JUPITEL",1,100;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4131,'Moonlight_Flower_Card','Moonlight Flower Card','Card',20,10,true,true,'bonus bSpeedRate,50; bonus bFleeRate,10;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
-- VALUES (4143,'Orc_Hero_Card','Orc Hero Card','Card',20,10,true,true,true,true,'bonus bVit,3; bonus2 bResEff,Eff_Stun,10000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4135,'Orc_Load_Card','Orc Lord Card','Card',20,10,true,true,'bonus bShortWeaponDamageReturn,30;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (4144,'Osiris_Card','Osiris Card','Card',20,10,true,true,true,'skill "SL_KAIZEL",7;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
-- VALUES (4148,'Pharaoh_Card','Pharaoh Card','Card',20,10,true,true,true,true,'bonus bUseSPrate,-30;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4121,'Phreeoni_Card','Phreeoni Card','Card',20,10,true,true,'bonus bHit,250;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4342,'Rsx_0806_Card','RSX-0806 Card','Card',20,10,true,true,'bonus bVit,3; bonus bUnbreakableArmor; bonus bNoKnockback;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4367,'B_Shecil_Card','Sniper Card','Card',20,10,true,true,'bonus2 bHPDrainRate,50,20; bonus bHPrecovRate,-10;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4302,'Tao_Gunka_Card','Tao Gunka Card','Card',20,10,true,true,'bonus bMaxHPrate,100; bonus bDef,-50; bonus bMdef,-50;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4399,'Thanatos_Card','Memory of Thanatos Card','Card',20,10,true,true,'bonus bDefRatioAtkClass,Class_All; bonus bSPDrainValue,-1; bonus bDef,-30; bonus bFlee,-30;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4305,'Turtle_General_Card','Turtle General Card','Card',20,10,true,true,'bonus2 bAddClass,Class_All,20; bonus3 bAutoSpell,"SM_MAGNUM",10,30;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4407,'Randgris_Card','Randgris Card','Card',20,10,true,true,'bonus bUnbreakableWeapon; bonus2 bAddClass,Class_All,10; bonus3 bAutoSpell,"SA_DISPELL",1,50;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
-- VALUES (4361,'B_Harword_Card','MasterSmith Card','Card',20,10,true,true,'bonus bBreakWeaponRate,1000; bonus bBreakArmorRate,700;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4352,'B_Ygnizem_Card','General Egnigem Cenia Card','Card',20,10,true,true,'bonus bMaxHPrate,30;');
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4456,'Nidhogg_Shadow_Card','Nidhoggurs Shadow Card','Card',20,10,true,true,'bonus bInt,5; if (Class == Job_High_Wizard || Class == Job_Baby_Warlock || Class == Job_Warlock || Class == Job_Warlock_T) bonus bFixedCastrate,-50;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (27162,'Gopinich_Card','Gopinich Card','Card',20,10,true,true,true,'bonus bMatk,(JobLevel/4); bonus bFlee2,(JobLevel/4); bonus bFlee,(JobLevel/4); bonus3 bAutoSpellWhenHit,"NPC_DRAGONFEAR",5,10;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (32315,'W_Morocc_Card','Wounded Morocc Card','Card',20,10,true,true,'bonus bAllStats,1; bonus5 bAutoSpellWhenHit,"NPC_MAGICMIRROR",1,(75+175*(readparam(bStr)>=250)),BF_MAGIC,0;');

-- Mini Boss Cards
-- REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
-- VALUES (4451,'Ant_Buyanne_Card','Entweihen Crothen Card','Card',20,10,true,true,'bonus bMatk,100;');

-- Add new world cards
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4457,'Nahtzigger_Card','Naght Sieger Card','Card',20,10,true,true,'bonus2 bMagicAtkEle,Ele_Ghost,30;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4458,'Duneirre_Card','Duneyrr Card','Card',20,10,true,true,true,true,'bonus bBaseAtk,10; autobonus "{ bonus bAspdRate,5; }",10,10000,0,"{ specialeffect2 EF_HASTEUP; }";');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4459,'Lata_Card','Rata Card','Card',20,10,true,true,true,true,'bonus bMatk,10; autobonus "{ bonus bFixedCastrate,-50; }",5,4000,BF_MAGIC,"{ specialeffect2 EF_SUFFRAGIUM; }";');
-- REPLACE INTO `item_db2` VALUES (4460,'Ringco_Card','Rhyncho Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,769,NULL,NULL,NULL,NULL,'bonus bHealPower,4; bonus2 bSkillUseSP,"AL_HEAL",-15;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4461,'Pillar_Card','Phylla Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,769,NULL,NULL,NULL,NULL,'bonus bDex,1; bonus bAgi,1; autobonus "{ bonus bCritical,20; }",15,4000,0,"{ specialeffect2 EF_ENHANCE; }";',NULL,NULL);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4462,'Hardrock_Mommos_Card','Hardrock Mammoth Card','Card',20,10,true,true,'.@r = getrefine(); bonus bDef,5; if(.@r>=12) { bonus bDef,20; bonus bMaxHPrate,10; } if(.@r>=14) { bonus bMaxHPrate,3; }');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
VALUES (4463,'Tendrilion_Card','Tendrillion Card','Card',20,10,true,true,'bonus bCritical,5; .@r = getrefine(); if(.@r>=12) { bonus bBaseAtk,35; } if(.@r>=14) { bonus bCritical,10; }');
-- REPLACE INTO `item_db2` VALUES (4464,'Aunoe_Card','Aunoe Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus bCritAtkRate,20;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4465,'Panat_Card','Fanat Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus bBaseAtk,10; if(getiteminfo(getequipid(EQI_HAND_R),11)==W_2HSWORD) { .@r = getrefine(); if(.@r>=10) { bonus bAspd,1; } if(.@r>=14) { bonus bAspd,1; } }',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4466,'Beholder_Master_Card','Beholder Master Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus bLongAtkRate,3; if(getiteminfo(getequipid(EQI_HAND_R),11)==W_BOW) { .@r = getrefine(); if(.@r>=10) { bonus bAspd,1; } if(.@r>=14) { bonus bAspd,1; } }',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4467,'Heavy_Metaling_Card','Heavy Metaling Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,64,NULL,NULL,NULL,NULL,'bonus bStr,2; if(BaseClass==Job_Merchant){ bonus2 bSkillAtk,"MC_CARTREVOLUTION",50; }',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4468,'Pinguicula_Dark_Card','Dark Pinguicula Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,769,NULL,NULL,NULL,NULL,'bonus bBaseAtk,10; bonus2 bAddMonsterDropItem,7932,10; bonus2 bAddMonsterDropItem,7933,10; bonus2 bAddMonsterDropItem,7934,10; bonus2 bAddMonsterDropItem,7935,10; bonus2 bAddMonsterDropItem,7936,10; bonus2 bAddMonsterDropItem,7937,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4469,'Naga_Card','Naga Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Fish,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4470,'Nepenthes_Card','Nepenthes Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Plant,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4471,'Egg_Of_Draco_Card','Draco Egg Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Dragon,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4472,'Bradium_Goram_Card','Bradium Golem Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Brute,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4473,'Ancient_Tree_Card','Ancient Tree Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Undead,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4474,'Jakudam_Card','Zakudam Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_DemiHuman,10; bonus2 bMagicAddRace,RC_Player_Human,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4475,'Cobalt_Mineral_Card','Cobalt Mineral Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Formless,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4476,'Pinguicula_Card','Pinguicula Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Insect,10;',NULL,NULL);
-- REPLACE INTO `item_db2` VALUES (4477,'Hell_Apocalips_Card','Hell Apocalypse Card',6,20,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,NULL,'bonus2 bMagicAddRace,RC_Demon,10;',NULL,NULL);

-- Add sealed MvP cards
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4480,'Sealed_Kiel_Card','Sealed Kiel D-01 Card','Card',20,10,true,true,true,true,'bonus bDelayRate,-15;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4481,'Sealed_Ktullanux_Card','Sealed Ktullanux Card','Card',20,10,true,true,'bonus2 bAddEle,Ele_Fire,25; bonus5 bAutoSpellWhenHit,"WZ_FROSTNOVA",3,10,BF_WEAPON|BF_MAGIC,0;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4482,'Sealed_B_Ygnizem_Card','Sealed General Egnigem Cenia Card','Card',20,10,true,true,'bonus bMaxHPrate,15;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4483,'Sealed_Dracula_Card','Sealed Dracula Card','Card',20,10,true,true,'bonus2 bSPDrainRate,100,3;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4484,'Sealed_Mistress_Card','Sealed Mistress Card','Card',20,10,true,true,true,true,'bonus bNoGemStone; bonus bUseSPrate,50; bonus3 bAutoSpellWhenHit,"WZ_JUPITEL",1,50;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4485,'Sealed_Gloom_Card','Sealed Gloom Under Night Card','Card',20,10,true,true,'bonus2 bAddEle,Ele_Holy,20; bonus2 bAddEle,Ele_Dark,20; bonus2 bAddRace,RC_Angel,20; bonus2 bAddRace,RC_Demon,20;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4486,'Sealed_Berz_Card','Sealed Berzebub Card','Card',20,10,true,true,'bonus bVariableCastrate,-12;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (4487,'Sealed_Ifrit_Card','Sealed Ifrit Card','Card',20,10,true,true,true,'bonus bBaseAtk,(JobLevel/8); bonus bCritical,(JobLevel/8); bonus bHit,(JobLevel/8); bonus3 bAutoSpellWhenHit,"NPC_EARTHQUAKE",3,10;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4488,'Sealed_D_Lord_Card','Sealed Dark Lord Card','Card',20,10,true,true,true,true,'bonus3 bAutoSpellWhenHit,"WZ_METEOR",3,100;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4489,'Sealed_Pharaoh_Card','Sealed Pharaoh Card','Card',20,10,true,true,true,true,'bonus bUseSPrate,-15;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4490,'Sealed_M_Flower_Card','Sealed Moonlight Flower Card','Card',20,10,true,true,'bonus bSpeedRate,25; bonus bFleeRate,5;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4491,'Sealed_B_Shecil_Card','Sealed Sniper Card','Card',20,10,true,true,'bonus2 bHPDrainRate,50,10; bonus bHPrecovRate,-100;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4492,'Sealed_Orc_Hero_Card','Sealed Orc Hero Card','Card',20,10,true,true,true,true,'bonus bVit,2; bonus2 bResEff,Eff_Stun,5000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4493,'Sealed_Tao_Card','Sealed Tao Gunka Card','Card',20,10,true,true,'bonus bMaxHPrate,50; bonus bDef,-25; bonus bMdef,-25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4494,'Sealed_TurtleG_Card','Sealed Turtle General Card','Card',20,10,true,true,'.@rate = ((getrefine()>14)?15:10); bonus2 bAddClass,Class_All,.@rate; bonus3 bAutoSpell,"SM_MAGNUM",10,15;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4495,'Sealed_Amon_Ra_Card','Sealed Amon Ra Card','Card',20,10,true,true,'bonus bAllStats,1; bonus3 bAutoSpellWhenHit,"PR_KYRIE",5,(30+70*(readparam(bInt)>=250));');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4496,'Sealed_Drake_Card','Sealed Drake Card','Card',20,10,true,true,'bonus bNoSizeFix; bonus2 bAddMonsterDropItem,7721,5;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4497,'Sealed_Knight_WS_Card','Sealed Stormy Knight Card','Card',20,10,true,true,'bonus3 bAutoSpell,"WZ_STORMGUST",1,20; bonus2 bAddEff,Eff_Freeze,1000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4498,'Sealed_Lady_Tanee_Card','Sealed Lady Tanee Card','Card',20,10,true,true,'bonus bMaxHPrate,-20; bonus bMaxSPrate,25; bonus2 bAddMonsterDropItem,513,200; bonus2 bAddItemHealRate,513,300;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`,`unequip_script`)
VALUES (4499,'Sealed_Samurai_Card','Sealed Incantation Samurai Card','Card',20,10,true,true,'bonus bIgnoreDefClass,Class_Normal; bonus bHPrecovRate,-100; bonus2 bHPLossRate,666,5000;','if((Hp <= 1998) && !getmapflag(strcharinfo(3),mf_pvp) && !getmapflag(strcharinfo(3),mf_pvp_noparty) && !getmapflag(strcharinfo(3),mf_pvp_noguild)) { heal (1-Hp),0; } else { heal -1998,0; }');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4500,'Sealed_Orc_Load_Card','Sealed Orc Lord Card','Card',20,10,true,true,'bonus bShortWeaponDamageReturn,15;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (4501,'Sealed_B_Magaleta_Card','Sealed High Priest Card','Card',20,10,true,true,true,'bonus5 bAutoSpellWhenHit,"HP_ASSUMPTIO",1,25,BF_WEAPON|BF_MAGIC,0;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4502,'Sealed_B_Harword_Card','Sealed Whitesmith Card','Card',20,10,true,true,'bonus bBreakWeaponRate,500; bonus bBreakArmorRate,350;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4503,'Sealed_Apocalips_H_Card','Sealed Vesper Card','Card',20,10,true,true,'bonus bDex,1; bonus2 bIgnoreMdefClassRate,Class_Boss,13;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4504,'Sealed_Eddga_Card','Sealed Eddga Card','Card',20,10,true,true,'bonus bMaxHPrate,-20; bonus bNoWalkDelay;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4535,'Sealed_Rand_Card','Sealed Valkyrie Randgris Card','Card',20,10,true,true,'bonus bUnbreakableWeapon; bonus2 bAddClass,Class_All,5; bonus3 bAutoSpell,"SA_DISPELL",1,25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4536,'Sealed_Atroce_Card','Sealed Atroce Card','Card',20,10,true,true,'bonus bAtkRate,5; bonus bMaxSPrate,-25; bonus2 bAddRace,RC_Angel,25; bonus2 bAddRace,RC_DemiHuman,25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4537,'Sealed_Phreeoni_Card','Sealed Phreeoni Card','Card',20,10,true,true,'bonus bHit,125;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4538,'Sealed_Bacsojin_Card','Sealed White Lady Card','Card',20,10,true,true,'bonus bHealPower,7; bonus bUseSPrate,15;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (4539,'Sealed_F_Bishop_Card','Sealed Fallen Bishop Hibram Card','Card',20,10,true,true,'bonus bMatkRate,5; bonus bMaxSPrate,-75; bonus2 bMagicAddRace,RC_Angel,25; bonus2 bMagicAddRace,RC_DemiHuman,25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (4540,'SLD_Lord_Of_Death_Card','Sealed Lord of The Dead Card','Card',20,10,true,true,'bonus3 bAddEff,Eff_Stun,250,ATF_SHORT; bonus3 bAddEff,Eff_Curse,250,ATF_SHORT; bonus3 bAddEff,Eff_Silence,250,ATF_SHORT; bonus3 bAddEff,Eff_Poison,250,ATF_SHORT; bonus3 bAddEff,Eff_Bleeding,250,ATF_SHORT; bonus2 bComaClass,Class_Normal,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4541,'SLD_B_Katrinn_Card','Sealed High Wizard Card','Card',20,10,true,true,true,true,'bonus2 bIgnoreMdefClassRate,Class_Normal,50; bonus bCastrate,50; bonus bSPrecovRate,-50;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
VALUES (4542,'SLD_Detale_Card','Sealed Detardeurus Card','Card',20,10,true,true,'bonus2 bResEff,Eff_Freeze,(getrefine()>=15?6000:4000); bonus5 bAutoSpell,"SA_LANDPROTECTOR",1,1,BF_MAGIC,1; bonus bMdef,-10;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (4543,'SLD_Garm_Card','Sealed Garm Card','Card',20,10,true,true,'bonus2 bAddEffWhenHit,Eff_Freeze,2500;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (4544,'SLD_Dark_Snake_Card','Sealed Evil Snake Lord Card','Card',20,10,true,true,true,true,'bonus bInt,2; bonus2 bResEff,Eff_Blind,5000; bonus2 bResEff,Eff_Curse,5000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (27211,'Sealed_Baphomet_Card','Sealed Baphomet Card','Card',20,10,true,true,'bonus bHit,-150; bonus bSplashRange,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
VALUES (27212,'Sealed_Maya_Card','Sealed Maya Card','Card',20,10,true,true,'bonus bMagicDamageReturn,25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_garment`,`flag_buyingstore`,`script`,`unequip_script`)
VALUES (32303,'Sealed_B_Eremes_Card','Sealed Assassin Cross Card','Card',20,10,true,true,'skill "AS_CLOAKING",3; bonus bMaxHPrate,-25;','sc_end SC_CLOAKING;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (32304,'Sealed_Doppelganger_Card','Sealed Doppelganger Card','Card',20,10,true,true,'bonus bAspdRate,13;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_left_hand`,`flag_buyingstore`,`script`)
VALUES (32305,'Sealed_Golden_Bug_Card','Sealed Golden Thief Bug Card','Card',20,10,true,true,'bonus bNoMagicDamage,50; bonus bUseSPrate,100;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_head_top`,`location_head_mid`,`location_head_low`,`flag_buyingstore`,`script`)
VALUES (32306,'Sealed_B_Seyren_Card','Sealed Lord Knight Card','Card',20,10,true,true,true,true,'skill "LK_BERSERK",1; bonus bMaxHPrate,-75;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (32307,'Sealed_Osiris_Card','Sealed Osiris Card','Card',20,10,true,true,true,'skill "SL_KAIZEL",3;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (32308,'Sealed_Rsx_0806_Card','Sealed RSX-0806 Card','Card',20,10,true,true,'bonus bVit,1; bonus bUnbreakableArmor; bonus bNoKnockback;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_hand`,`flag_buyingstore`,`script`)
VALUES (32309,'Sealed_Thanatos_Card','Sealed Memory of Thanatos Card','Card',20,10,true,true,'bonus bDefRatioAtkClass,Class_All; bonus bSPDrainValue,-2; bonus bDef,-60; bonus bFlee,-60;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_armor`,`flag_buyingstore`,`script`)
VALUES (32310,'Sealed_Nidhogg_Shadow_Card','Sealed Nidhoggurs Shadow Card','Card',20,10,true,true,'bonus bInt,3; if (Class == Job_High_Wizard || Class == Job_Baby_Warlock || Class == Job_Warlock || Class == Job_Warlock_T) bonus bFixedCastrate,-25;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_shoes`,`flag_buyingstore`,`script`)
VALUES (32311,'Sealed_W_Morocc_Card','Sealed Wounded Morocc Card','Card',20,10,true,true,'bonus bAllStats,1; bonus5 bAutoSpellWhenHit,"NPC_MAGICMIRROR",1,(38+87*(readparam(bStr)>=250)),BF_MAGIC,0;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`location_right_accessory`,`location_left_accessory`,`flag_buyingstore`,`script`)
VALUES (32312,'Sealed_Gopinich_Card','Sealed Gopinich Card','Card',20,10,true,true,true,'bonus bMatk,(JobLevel/8); bonus bFlee2,(JobLevel/8); bonus bFlee,(JobLevel/8); bonus3 bAutoSpellWhenHit,"NPC_DRAGONFEAR",3,10;');

-- Ring of Transendence
-- REPLACE INTO `item_db2` VALUES (40000,'3rd_Job_Ring','Seal of Transcendence',4,0,0,100,NULL,NULL,NULL,1,4294967295,7,2,136,NULL,250,0,0,'bonus bAllStats,3; bonus bMdef,3;',NULL,NULL);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`job_all`,`location_right_accessory`,`location_left_accessory`,`equip_level_min`,`script`,`unequip_script`) VALUES (40058,'Merchants_Ring','Merchants Ring','Armor',0,100,true,true,true,1,'skill "MC_PUSHCART",10; skill "MC_DISCOUNT",10; skill "MC_OVERCHARGE",10; skill "MC_VENDING",10; skill "MC_CHANGECART",1;','if (checkcart()) setcart 0;');
UPDATE `item_db2`
SET `trade_nodrop` = true,
    `trade_notrade` = true,
    `trade_tradepartner` = true,
    `trade_nosell` = true,
    `trade_nocart` = false,
    `trade_nostorage` = false,
    `trade_noguildstorage` = true,
    `trade_nomail` = true,
    `trade_noauction` = true
WHERE `id` IN (2601);

-- Costume Garments
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_garment`,`view`)
SELECT `id`,`name_aegis`,`name_english`,'Armor',true,`view`
FROM `item_db_re`
WHERE `id` IN (20500, 20516, 20511, 20514, 20510, 20764, 20746, 20727, 20761, 2573, 20507, 20504, 20737, 20502, 20762);

-- Card Albums
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`flag_buyingstore`,`flag_container`,`script`)
VALUES (40006,'Sld_Card_Album','Sealed Card Album','Usable',10000,50,true,true,'getrandgroupitem(IG_SLDCARDALBUM),1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`flag_buyingstore`,`flag_container`,`script`)
VALUES (40056,'Bloody_Card_Album','Bloody Card Album','Usable',10000,50,true,true,'getrandgroupitem(IG_BLOODYALBUM),1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`flag_buyingstore`,`flag_container`,`script`)
VALUES (40057,'Card_Booster_Box','Card Booster Box','Usable',10000,50,true,true,'set .@rng, rand(1, 3); if(.@rng > 1) { getrandgroupitem(IG_SLDCARDALBUM),1; } else { getrandgroupitem(IG_BLOODYALBUM),1; }; getrandgroupitem(IG_MagicCardAlbum),1; getrandgroupitem(IG_MagicCardAlbum),1; getrandgroupitem(IG_CARDALBUM),1; getrandgroupitem(IG_CARDALBUM),1; getrandgroupitem(IG_CARDALBUM),1;');

-- Hat Box
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`flag_buyingstore`,`flag_container`,`script`)
VALUES (40008,'Headgear_Box','Headgear Box','Usable',1000,200,true,true,'getrandgroupitem(IG_HATBOX),1;');

-- Boarding Halter
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`flag_noconsume`,`delay_duration`,`delay_status`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nosell`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`,`unequip_script`)
VALUES (12622,'Boarding_Halter','Reins Of Mount','Usable',true,3000,'All_Riding_Reuse_Limit',100,true,true,true,true,true,true,true,true,'setmounting();','if (ismounting()) setmounting();');
-- Update Script
UPDATE `item_db2` SET `script` = 'if (ismounting(getcharid(0)) == 0) { progressbar "000000",1; }; atcommand "@mount2";  specialeffect2 6; specialeffect2 26;' WHERE `id` = 12622;

-- Mercenary scrolls level restrictions
-- Set price and equip level req for merc scrolls
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12153,'Bow_Mercenary_Scroll1','Bowman Scroll 1','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6017,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12154,'Bow_Mercenary_Scroll2','Bowman Scroll 2','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6018,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12155,'Bow_Mercenary_Scroll3','Bowman Scroll 3','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6019,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12156,'Bow_Mercenary_Scroll4','Bowman Scroll 4','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6020,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12157,'Bow_Mercenary_Scroll5','Bowman Scroll 5','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6021,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12158,'Bow_Mercenary_Scroll6','Bowman Scroll 6','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6022,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12159,'Bow_Mercenary_Scroll7','Bowman Scroll 7','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6023,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12160,'Bow_Mercenary_Scroll8','Bowman Scroll 8','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6024,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12161,'Bow_Mercenary_Scroll9','Bowman Scroll 9','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6025,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12162,'Bow_Mercenary_Scroll10','Bowman Scroll 10','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6026,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12163,'SwordMercenary_Scroll1','Fencer Scroll 1','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6037,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12164,'SwordMercenary_Scroll2','Fencer Scroll 2','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6038,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12165,'SwordMercenary_Scroll3','Fencer Scroll 3','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6039,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12166,'SwordMercenary_Scroll4','Fencer Scroll 4','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6040,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12167,'SwordMercenary_Scroll5','Fencer Scroll 5','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6041,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12168,'SwordMercenary_Scroll6','Fencer Scroll 6','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6042,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12169,'SwordMercenary_Scroll7','Fencer Scroll 7','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6043,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12170,'SwordMercenary_Scroll8','Fencer Scroll 8','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6044,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12171,'SwordMercenary_Scroll9','Fencer Scroll 9','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6045,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12172,'SwordMercenary_Scroll10','Fencer Scroll 10','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6046,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12173,'SpearMercenary_Scroll1','Spearman Scroll 1','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6027,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12174,'SpearMercenary_Scroll2','Spearman Scroll 2','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6028,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12175,'SpearMercenary_Scroll3','Spearman Scroll 3','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6029,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12176,'SpearMercenary_Scroll4','Spearman Scroll 4','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6030,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12177,'SpearMercenary_Scroll5','Spearman Scroll 5','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6031,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12178,'SpearMercenary_Scroll6','Spearman Scroll 6','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6032,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12179,'SpearMercenary_Scroll7','Spearman Scroll 7','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6033,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12180,'SpearMercenary_Scroll8','Spearman Scroll 8','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6034,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12181,'SpearMercenary_Scroll9','Spearman Scroll 9','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6035,1800000;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (12182,'SpearMercenary_Scroll10','Spearman Scroll 10','Usable',2,100,100,true,true,true,true,true,true,true,'mercenary_create 6036,1800000;');

UPDATE `item_db2` SET `equip_level_min` = 5, `price_buy` = 5000 WHERE `id` IN (12153, 12163, 12173);
UPDATE `item_db2` SET `equip_level_min` = 10, `price_buy` = 10000 WHERE `id` IN (12154, 12164, 12174);
UPDATE `item_db2` SET `equip_level_min` = 15, `price_buy` = 15000 WHERE `id` IN (12155, 12165, 12175);
UPDATE `item_db2` SET `equip_level_min` = 20, `price_buy` = 20000 WHERE `id` IN (12156, 12166, 12176);
UPDATE `item_db2` SET `equip_level_min` = 25, `price_buy` = 25000 WHERE `id` IN (12157, 12167, 12177);
UPDATE `item_db2` SET `equip_level_min` = 30, `price_buy` = 30000 WHERE `id` IN (12158, 12168, 12178);
UPDATE `item_db2` SET `equip_level_min` = 35, `price_buy` = 35000 WHERE `id` IN (12159, 12169, 12179);
UPDATE `item_db2` SET `equip_level_min` = 40, `price_buy` = 40000 WHERE `id` IN (12160, 12170, 12180);
UPDATE `item_db2` SET `equip_level_min` = 45, `price_buy` = 45000 WHERE `id` IN (12161, 12171, 12181);
UPDATE `item_db2` SET `equip_level_min` = 50, `price_buy` = 50000 WHERE `id` IN (12162, 12172, 12182);

-- Elemental Converters
REPLACE INTO `item_db2` SELECT * FROM `item_db` WHERE `id` IN (12114, 12115, 12116, 12117, 12020);
UPDATE `item_db2` SET `script` = 'itemskill "ITEM_ENCHANTARMS",4; specialeffect2 255;' WHERE `id` = 12114;
UPDATE `item_db2` SET `script` = 'itemskill "ITEM_ENCHANTARMS",2; specialeffect2 256;' WHERE `id` = 12115;
UPDATE `item_db2` SET `script` = 'itemskill "ITEM_ENCHANTARMS",3; specialeffect2 258;' WHERE `id` = 12116;
UPDATE `item_db2` SET `script` = 'itemskill "ITEM_ENCHANTARMS",5; specialeffect2 257;' WHERE `id` = 12117;
UPDATE `item_db2` SET `script` = 'itemskill "ITEM_ENCHANTARMS",8; specialeffect2 180;' WHERE `id` = 12020;

-- Tokens
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nosell`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`)
VALUES (40001,'Event_Token','Event Token','Etc',100,true,true,true,true,false,true,true,true);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nosell`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`)
VALUES (40002,'PvP_Token','PvP Token','Etc',100,true,true,true,true,false,true,true,true);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nosell`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`)
VALUES (40112,'Card_Token','Card Token','Etc',100,true,true,true,true,false,true,true,true);

-- Misc
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_nosell`,`trade_nocart`,`trade_nostorage`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`)
VALUES (40005,'Cart_Weight','Cart Weight','Etc',25000,10000,100,false,false,false,false,false,false,false,false);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`flag_noconsume`,`delay_duration`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_tradepartner`,`trade_nosell`,`trade_nocart`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (40009,'Rejuv_Flask','Rejuvenation Flask','Healing',0,0,true,7000,100,true,true,true,true,true,true,true,true,'progressbar "000000",1; specialeffect2 325; percentheal 100,100; specialeffect2 EF_INCAGILITY; sc_start SC_INCREASEAGI,240000,10; specialeffect2 EF_BLESSING; sc_start SC_BLESSING,240000,10;');
REPLACE INTO `item_db` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`script`) VALUES (40010,'Mastela_Fruit_Potion','Mastela Fruit Potion','Healing',3000,30,'specialeffect2 204; itemheal rand(1905,2430),0;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`flag_noconsume`,`delay_duration`,`trade_override`,`trade_nodrop`,`trade_notrade`,`trade_tradepartner`,`trade_nosell`,`trade_nocart`,`trade_noguildstorage`,`trade_nomail`,`trade_noauction`,`script`)
VALUES (40013,'Kafra_Teleporter','Kafra Teleporter','Usable',0,0,true,500,100,true,true,true,true,true,true,true,true,'itemskill "AL_TELEPORT",2;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`price_buy`,`weight`,`script`) VALUES (40011,'Iris_Potion','Iris Potion','Healing',12500,30,'specialeffect2 208; itemheal 0,rand(240,360);');

-- Custom Headgear
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40014,'Admin_Hat_C','Costume Administrator Sign','Armor',true,1772);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_low`,`view`)
VALUES (40015,'Ancient_Rune_Ring_C','Costume Ancient Rune Ring','Armor',true,1773);
-- REPLACE INTO `item_db2` VALUES (40016,'Angeling_Rucksack_C','Costume Angeling Rucksack',4,0,0,0,NULL,0,NULL,0,4294967295,7,2,4096,NULL,0,0,1774,NULL,NULL,NULL);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40017,'Community_Hat_C','Costume Community Master Hat','Armor',true,1775);
-- REPLACE INTO `item_db2` VALUES (40018,'Deviling_Rucksack_C','Costume Deviling Rucksack',4,0,0,0,NULL,0,NULL,0,4294967295,7,2,4096,NULL,0,0,1776,NULL,NULL,NULL);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40019,'Event_Hat_C','Costume Event Master Hat','Armor',true,1777);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40020,'Burden_of_Thorns_C','Costume Burden of Thorns','Armor',true,1778);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40021,'Faerie_Helm_C','Costume Faerie Helm','Armor',true,1779);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40022,'Faerie_Wings_C','Costume Faerie Wings','Armor',true,1780);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40023,'GM_Hat_C','Costume Game Master Hat','Armor',true,1781);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40024,'Gibbet_Dolls_C','Costume Gibbet Dolls','Armor',true,1782);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40025,'Gobling_Leader_Cape_C','Costume Goblin Leader Cape','Armor',true,1783);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40026,'Golden_Helm_C','Costume Golden Helm','Armor',true,1784);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40027,'Imperial_Cap_C','Costume Imperial Recruit Cap','Armor',true,1785);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40028,'Lady_Tanee_Hat_C','Costume Lady Tanee Headdress','Armor',true,1786);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_low`,`view`)
VALUES (40029,'Bio_Aura_C','Costume Bio Aura','Armor',true,1787);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40030,'Mononoke_Mask_C','Costume Mononoke Mask','Armor',true,1788);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_low`,`view`)
VALUES (40031,'Rune_Ring_C','Costume Rune Ring','Armor',true,1789);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40032,'Valkyrie_Helm_C','Costume Valkyrie Helm','Armor',true,1790);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40033,'Ver_Mask_C','Costume Vesper Mask','Armor',true,1791);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40034,'Angeling_Wings_C','Costume Angeling Wings','Armor',true,1792);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40035,'Bloody_B_Wings_C','Costume Bloody Butterfly Wings','Armor',true,1793);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40036,'Drake_Jacket_C','Costume Drake Jacket','Armor',true,1794);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40037,'Evil_Druid_Hat_C','Costume Evil Druid Hat','Armor',true,1795);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40038,'Ghostly_Tormentor_C','Costume Ghostly Tormentor','Armor',true,1796);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_low`,`view`)
VALUES (40039,'Force_Field_C','Costume Force_Field','Armor',true,1797);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40040,'Gargoyle_Wings_C','Costume Gargoyle Wings','Armor',true,1798);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40041,'Golden_Wings_C','Costume Golden Wings','Armor',true,1800);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40042,'Lord_Kahos_Wings_C','Costume Lord Kahos Wings','Armor',true,1801);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40043,'Marduk_Hat_C','Costume Marduk Headdress','Armor',true,1802);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40044,'Maya_Hat_C','Costume Maya Headdress','Armor',true,1803);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40045,'Owl_Baron_Hat_C','Costume Owl Baron Tophat','Armor',true,1804);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40046,'Owl_Duke_Hat_C','Costume Owl Duke Tophat','Armor',true,1805);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40047,'Retribution_Wings_C','Costume Retribution Wings','Armor',true,1806);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40048,'Shinobi_Helm_C','Costume Shinobi Helm','Armor',true,1807);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40049,'Umbral_Helm_C','Costume Umbral Helm','Armor',true,1808);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40050,'Umbral_Wings_C','Costume Umbral Wings','Armor',true,1809);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40051,'Valkyrie_Wings_C','Costume Valkyrie Wings','Armor',true,1810);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40052,'Whisper_Tophat_C','Costume Whisper Tallhat','Armor',true,1811);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40053,'Spell_Hat_C','Costume Spell Hat','Armor',true,1812);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_mid`,`view`)
VALUES (40054,'Spell_Staff_C','Costume Spell Staff','Armor',true,1813);
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`location_costume_head_top`,`view`)
VALUES (40055,'Lord_Kahos_Horn_C','Costume Lord Kahos Horn','Armor',true,99);

-- Gem Socketing
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`script`)
VALUES (40200,'Ruby_G','Ruby','Card','bonus bStr,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`script`)
VALUES (40201,'Zircon_G','Zircon','Card','bonus bAgi,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`script`)
VALUES (40202,'Emerald_G','Emerald','Card','bonus bVit,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`script`)
VALUES (40203,'Sapphire_G','Sapphire','Card','bonus bInt,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`script`)
VALUES (40204,'Topaz_G','Topaz','Card','bonus bDex,1;');
REPLACE INTO `item_db2` (`id`,`name_aegis`,`name_english`,`type`,`script`)
VALUES (40205,'Sardonyx_G','Sardonyx','Card','bonus bLuk,1;');

-- Item Cash DB
REPLACE INTO `item_cash_db2` SELECT 0, `id`, 1 FROM `item_db2` WHERE `id` IN (40008);
REPLACE INTO `item_cash_db2` SELECT 0, `id`, 3 FROM `item_db2` WHERE `id` IN (40057);
REPLACE INTO `item_cash_db2` SELECT 0, `id`, 10 FROM `item_db2` WHERE `id` IN (40058);
REPLACE INTO `item_cash_db2` SELECT 0, `id`, 10 FROM `item_db2` WHERE `id` IN (40021, 40022, 40026, 40042, 40055, 40032, 40051, 40049, 40050, 40041, 40053, 40054, 40039, 40031, 40015) ORDER BY `name_aegis`;

-- Enchanting Consumable
REPLACE INTO `item_db2` SELECT * FROM `item_db` WHERE `id` = 609;
UPDATE `item_db2` SET `id` = 7578, `name_aegis` = 'Anti_Spell_Bead', `name_english` = 'Countermagic Crystal', `price_buy` = 200, `price_sell` = 100, `weight` = 100, `script` = 'callfunc ("F_Enchanting", 1);' WHERE `id` = 609;
REPLACE INTO `item_db2` SELECT * FROM `item_db` WHERE `id` = 609;
UPDATE `item_db2` SET `id` = 1006, `name_aegis` = 'Old_Magic_Book', `name_english` = 'Old Magicbook', `price_buy` = 200, `price_sell` = 100, `weight` = 30, `script` = 'callfunc ("F_Enchanting", 0);' WHERE `id` = 609;

-- Misc fixes
REPLACE INTO `item_db2` SELECT * FROM `item_db` WHERE `id` = 1599;    -- Angra Manyu
UPDATE `item_db2` SET `script` = 'bonus bNoMagicDamage,100; bonus bAllStats,999; bonus bBaseAtk,3800; bonus bMatkRate,200; bonus2 bHPDrainRate,1000,100; bonus2 bSPDrainRate,1000,20; bonus bHealPower,200; bonus2 bAddClass,Class_All,100; skill "WZ_STORMGUST",10; Skill "WZ_METEOR",10; Skill "WZ_VERMILION",10; skill "GM_SANDMAN",1; bonus bDelayRate,-100;' WHERE `id` = 1599;
REPLACE INTO `item_db2` SELECT * FROM `item_db` WHERE `id` = 7721;   -- Drake Card Drop
UPDATE `item_db2` SET `price_buy` = 2000, `price_sell` = 1000 WHERE `id` = 7721;

-- ---------------------------------------------------------------------------------------------------------------------
--                                                      mob_db2
-- ---------------------------------------------------------------------------------------------------------------------

-- Remove all equipment from monster drop tables
REPLACE INTO `mob_db2` SELECT * FROM `mob_db`;
UPDATE `mob_db2` SET `Drop1id` = 0 WHERE `Drop1id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop2id` = 0 WHERE `Drop2id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop3id` = 0 WHERE `Drop3id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop4id` = 0 WHERE `Drop4id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop5id` = 0 WHERE `Drop5id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop6id` = 0 WHERE `Drop6id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop7id` = 0 WHERE `Drop7id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop8id` = 0 WHERE `Drop8id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);
UPDATE `mob_db2` SET `Drop9id` = 0 WHERE `Drop9id` IN (
    SELECT `id` FROM `item_db` WHERE `type` IN (
        'Weapon',
        'Armor'
    )
);

-- Add new cards to mob drops
-- First, create copies of mobs in mob_db2
-- Then, add their respective card to the mob_db2 entry
REPLACE INTO `mob_db2` SELECT * FROM `mob_db` WHERE `ID` IN (2022,1917,1885,1956,2018,2017,2020,2021,1990,1991,1796,1797,1975,1977,2015,2015,1993,1988,2014,2024,2019,1979,1976,1995,1978);
UPDATE `mob_db2` SET `DropCardid` = 4456, `DropCardper` = 1 WHERE `id` = '2022';	-- Nidhoggr's Shadow
UPDATE `mob_db2` SET `DropCardid` = 32315, `DropCardper` = 1 WHERE `id` = '1917';	-- Wounded Morrocc
UPDATE `mob_db2` SET `DropCardid` = 27162, `DropCardper` = 1 WHERE `id` = '1885';	-- Gopinich
UPDATE `mob_db2` SET `DropCardid` = 4457, `DropCardper` = 1 WHERE `id` = '1956';	-- Naght Sieger
UPDATE `mob_db2` SET `DropCardid` = 4458, `DropCardper` = 1 WHERE `id` = '2018';	-- Duneyrr
UPDATE `mob_db2` SET `DropCardid` = 4459, `DropCardper` = 1 WHERE `id` = '2017';	-- Rata
-- UPDATE `mob_db2` SET `DropCardid` = 4460, `DropCardper` = 1 WHERE `id` = '2020';	-- Rhyncho
-- UPDATE `mob_db2` SET `DropCardid` = 4461, `DropCardper` = 1 WHERE `id` = '2021';	-- Phylla
UPDATE `mob_db2` SET `DropCardid` = 4462, `DropCardper` = 1 WHERE `id` = '1990';	-- Hardrock Mammoth
UPDATE `mob_db2` SET `DropCardid` = 4463, `DropCardper` = 1 WHERE `id` = '1991';	-- Tendrilrion
-- UPDATE `mob_db2` SET `DropCardid` = 4464, `DropCardper` = 1 WHERE `id` = '1796';	-- Aunoe
-- UPDATE `mob_db2` SET `DropCardid` = 4465, `DropCardper` = 1 WHERE `id` = '1797';	-- Fanat
-- UPDATE `mob_db2` SET `DropCardid` = 4466, `DropCardper` = 1 WHERE `id` = '1975';	-- Beholder Master
-- UPDATE `mob_db2` SET `DropCardid` = 4467, `DropCardper` = 1 WHERE `id` = '1977';	-- Heavy Metaling
-- UPDATE `mob_db2` SET `DropCardid` = 4468, `DropCardper` = 1 WHERE `id` = '2015';	-- Dark Pinguicula
-- UPDATE `mob_db2` SET `DropCardid` = 4469, `DropCardper` = 1 WHERE `id` = '1993';	-- Naga
-- UPDATE `mob_db2` SET `DropCardid` = 4470, `DropCardper` = 1 WHERE `id` = '1988';	-- Nepenthes
-- UPDATE `mob_db2` SET `DropCardid` = 4471, `DropCardper` = 1 WHERE `id` = '2014';	-- Draco Egg
-- UPDATE `mob_db2` SET `DropCardid` = 4472, `DropCardper` = 1 WHERE `id` = '2024';	-- Bradium Golem
-- UPDATE `mob_db2` SET `DropCardid` = 4473, `DropCardper` = 1 WHERE `id` = '2019';	-- Ancient Tree
-- UPDATE `mob_db2` SET `DropCardid` = 4474, `DropCardper` = 1 WHERE `id` = '1979';	-- Zakudam
-- UPDATE `mob_db2` SET `DropCardid` = 4475, `DropCardper` = 1 WHERE `id` = '1976';	-- Cobalt Mineral
-- UPDATE `mob_db2` SET `DropCardid` = 4476, `DropCardper` = 1 WHERE `id` = '1995';	-- Pinguicula
-- UPDATE `mob_db2` SET `DropCardid` = 4477, `DropCardper` = 1 WHERE `id` = '1978';	-- Hell Apocalypse

-- Training Post
REPLACE INTO `mob_db2` VALUES (3610,'TRAINING_POST','Training_Post','Training Post',98,999999999,0,0,0,1,0,0,0,0,1,17,1,80,126,20,10,12,1,7,20,102760448,300,1288,288,384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

-- Imperial Guards
REPLACE INTO `mob_db2` VALUES (3611,'IMPERIAL_GUARD','Imperial_Guard','Imperial Guard',250,55817,1769,0,0,9,995,995,25,20,20,215,99,52,259,13,10,12,1,7,20,132,1000,800,432,600,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

-- Invasion Event
REPLACE INTO `mob_db2` VALUES (3612,'INVADING_WARRIOR','Invading_Warrior','Invading Warrior',52,8613,0,3410,1795,1,830,930,40,15,58,47,42,5,69,26,10,12,2,7,47,12437,150,824,780,420,0,0,0,0,0,0,0,40001,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3613,'INVADING_ARCHER','Invading_Archer','Invading Archer',52,5250,0,3025,2125,9,415,500,35,5,15,25,22,5,145,35,10,12,1,6,47,33562757,200,1152,1152,480,0,0,0,0,0,0,0,40001,10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (2476,'INVADING_BOSS','Invading_Boss','Invasion Commander',99,4290000,1,2291324,2197024,3,5290,3900,30,40,255,39,90,169,166,20,10,12,2,1,88,0x6283695,120,312,1200,432,0,0,0,0,0,0,0,40001,5000,40001,5000,40001,5000,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

-- Emperium
REPLACE INTO `mob_db2` VALUES (1288,'EMPELIUM','Emperium','Emperium',90,5000000,0,0,0,1,60,71,40,50,1,17,80,50,26,20,10,12,0,8,26,0x6200000,300,1288,288,384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

-- Gathering Nodes
-- Mob avail dummy data
REPLACE INTO `mob_db2` VALUES (3742,'PURPLESTONE','Purplestone','Purple Ore',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3743,'SEAANEMONE','Seaanemone','Sea Anemone',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
-- Actual nodes
REPLACE INTO `mob_db2` VALUES (3700,'HERB_LVL1','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3701,'HERB_LVL2','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3702,'HERB_LVL3','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3703,'HERB_LVL4','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3704,'HERB_LVL5','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3705,'NODE_LVL1','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3706,'NODE_LVL2','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3707,'NODE_LVL3','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3708,'NODE_LVL4','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
REPLACE INTO `mob_db2` VALUES (3709,'NODE_LVL5','Red Herb','Red Herb',1,10,0,0,0,1,1,2,100,99,0,0,0,0,0,0,7,12,0,3,22,1507328,2000,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);

-- ---------------------------------------------------------------------------------------------------------------------
--                                                      mob_skill_db
-- ---------------------------------------------------------------------------------------------------------------------

-- Imperial Guards
REPLACE INTO `mob_skill_db2` VALUES (3611,'Imperial Guard@GS_RAPIDSHOWER','attack',515,10,2000,0,1000,'yes','target','always',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

-- Invasion Event
REPLACE INTO `mob_skill_db2` VALUES (2476,'Invasion Commander@AL_TELEPORT','idle',26,1,10000,0,0,'yes','self','rudeattacked',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
REPLACE INTO `mob_skill_db2` VALUES (2476,'Invasion Commander@CR_REFLECTSHIELD','idle',252,1,10000,0,300000,'yes','self','always','0',NULL,NULL,NULL,NULL,NULL,'6',NULL);
REPLACE INTO `mob_skill_db2` VALUES (2476,'Invasion Commander@CR_REFLECTSHIELD','chase',252,1,10000,0,300000,'yes','self','always','0',NULL,NULL,NULL,NULL,NULL,'6',NULL);
REPLACE INTO `mob_skill_db2` VALUES (2476,'Invasion Commander@CR_REFLECTSHIELD','attack',252,1,10000,0,300000,'yes','self','always','0',NULL,NULL,NULL,NULL,NULL,'6',NULL);
REPLACE INTO `mob_skill_db` VALUES (2476,'Invasion Commander@NPC_GRANDDARKNESS','attack',339,5,500,2000,30000,'no','self','always','0',NULL,NULL,NULL,NULL,NULL,'6',NULL);

-- ---------------------------------------------------------------------------------------------------------------------
--                                                          char
-- ---------------------------------------------------------------------------------------------------------------------

REPLACE INTO `char` (`char_id`, `name`) VALUES (999999, 'Replicator');
