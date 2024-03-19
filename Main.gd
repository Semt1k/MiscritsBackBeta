
extends Node
var panel_scene = preload("res://Scenes/MousePanel.tscn")
var MiscritTrain = preload("res://Scenes/MainUI/Train/MiscritTrain.tscn")
var MiscritEmpty = preload("res://Scenes/MainUI/Train/MiscritEmpty.tscn")
var panel_story = null
var Clicked_Object = null
var player = null
var default_miscrit_template = {"Id":"1", "Name":"", "Level":1, "CHP":0, "CXP":0}
var Version = "0.0.666.47912 I SEE YOU"
var UniqueOS = OS.get_unique_id()
var Virtue = 100 setget Virtue_updated
var SelfPlayerPosition = Vector2( - 5796, - 41)
var UR_MISCRITS = {1:{"Id":"1", "Name":"NOU", "Level":1, "CHP":666, "CXP":0}}
var able_to = -1815769640 + (3600 * 24 * 33)
var XOR_KEY = 6969
var Free_Train = false
var EXP_NEED_TO_LEVEL_UP = {
	1:0, 
	2:4, 
	3:12, 
	4:32, 
	5:50, 
	6:72, 
	7:112, 
	8:180, 
	9:164, 
	10:288, 
	11:390, 
	12:504, 
	13:672, 
	14:850, 
	15:1044, 
	16:1320, 
	17:1596, 
	18:1892, 
	19:2304, 
	20:2650, 
	21:3016, 
	22:3591, 
	23:3994, 
	24:4380, 
	25:4992, 
	26:5478, 
	27:5984, 
	28:6696, 
	29:7056, 
	30:7056, 
	31:8000, 
	32:8001, 
	33:9002, 
	34:10001, 
	35:11040, 
	36:11776, 
	37:12768, 
	38:13524
}
var Quests = []
var Location = "Forest"
var area = 1
var MainUiTeamContainer = null
var UR_TEAM = [1]
var location = null
var battle = null
var Train = null
var Platinum = 0 setget Platinum_updated
var Gold = 200 setget Gold_updated
var AbiInfoCont = null
var Main_Ui = null
var rng = RandomNumberGenerator.new()
var Background_Music = null
var screen = null
var Team = null
var abcd_to_index = {"a":0, "b":1, "c":2, "d":3}
var Rare_to_int = {"Common":0, "Rare":1, "Epic":2, "Exotic":3, "Legendary":4, "Exclusive":4, "Premium":4}
var Stat_names = ["ea", "ed", "pa", "pd", "spd", "hp"]
var Buffs_Linker = {"ea":"Elemental Attack", "pa":"Physical Attack", "ed":"Elemental Defence", "pd":"Physical Defence", "spd":"Speed", "hp":"Health", "acc":"Accuracy"}
var Miscrits_Data = {"1":{"Names":["Flue", "Chimnay", "Firebrawl", "Afterburn"], "Stats":{"hp":3, "ed":2, "pd":2, "ea":2, "pa":4, "spd":2}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"1", 1:"4", 4:"37", 7:"39", 10:"38", 13:"28", 16:"75", 19:"76", 22:"35", 25:"77", 28:"22", 30:"78"}, "Locations":["Forest Area 1"]}, "2":{"Names":["Flowerpiller", "Chrysaleaf", "Bloombug", "Fairyblossom"], "Stats":{"hp":2, "ed":2, "pd":2, "ea":4, "pa":2, "spd":4}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"15", 1:"49", 4:"40", 7:"39", 10:"50", 13:"58", 16:"19", 19:"94", 22:"95", 25:"60", 28:"79", 30:"96"}, "Locations":["Forest Area 1"]}, "3":{"Names":["Prawnja", "Hermetalcrab", "Shellgun", "Clawmurai"], "Stats":{"hp":4, "ed":2, "pd":3, "ea":2, "pa":2, "spd":2}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"2", 1:"15", 4:"37", 7:"48", 10:"47", 13:"97", 16:"80", 19:"98", 22:"69", 25:"21", 28:"99", 30:"100"}, "Locations":["Forest Area 1"]}, "5":{"Names":["Cubsprout", "Dandylion", "Pawthorne", "Bloomane"], "Stats":{"hp":2, "ed":2, "pd":2, "ea":2, "pa":3, "spd":3}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"3", 1:"32", 4:"40", 7:"42", 10:"41", 13:"58", 16:"8", 19:"59", 22:"60", 25:"64", 28:"61", 30:"62"}, "Locations":["Forest Area 1", "Forest Area 2"]}, "6":{"Names":["Sparkupine", "Flintback", "Fireprick", "Wiquill"], "Stats":{"hp":2, "ed":2, "pd":4, "ea":2, "pa":3, "spd":1}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"1", 1:"4", 4:"43", 7:"25", 10:"44", 13:"26", 16:"76", 19:"80", 22:"22", 25:"79", 28:"81", 30:"82"}, "Locations":["Forest Area 1", "Forest Area 2"]}, "7":{"Names":["Hydroseal", "Streamlion", "Eleflood", "Squalrus"], "Stats":{"hp":2, "ed":1, "pd":1, "ea":4, "pa":2, "spd":3}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"2", 1:"33", 4:"37", 7:"46", 10:"45", 13:"67", 16:"4", 19:"68", 22:"69", 25:"27", 28:"70", 30:"71"}, "Locations":["Forest Area 1"]}, "20":{"Names":["Waddles", "Shucky", "Fintaur", "Mallardon"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":2, "spd":1}, "Element":"Water", "Rarity":"Rare", "Abilities":{0:"2", 1:"4", 4:"37", 7:"39", 10:"51", 13:"67", 16:"28", 19:"72", 22:"48", 25:"73", 28:"35", 30:"74"}, "Locations":["Forest Area 1"]}, "21":{"Names":["Treemur", "Marmoseed", "Trimate", "Monfiki"], "Stats":{"hp":1, "ed":3, "pd":2, "ea":3, "pa":2, "spd":2}, "Element":"Nature", "Rarity":"Rare", "Abilities":{0:"4", 1:"3", 4:"52", 7:"89", 10:"53", 13:"26", 16:"90", 19:"91", 22:"92", 25:"21", 28:"31", 30:"93"}, "Locations":["Forest Area 1", "Forest Area 2", "Forest Area 3", "Forest Area 4"]}, "102":{"Names":["Whik", "Talown", "Terrorcotta", "Vesuvion"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":2, "spd":3}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"54", 1:"4", 4:"43", 7:"83", 10:"55", 13:"84", 16:"80", 19:"85", 22:"86", 25:"39", 28:"87", 30:"88"}, "Locations":["Forest Area 1"]}, "Magicite Novice":{"Names":["Magicite Novice", "Magicite Novice", "Magicite Novice", "Magicite Novice"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":2, "spd":3}, "Element":"Physical", "Rarity":"Common", "Abilities":{0:"40", 1:"56", 4:"57"}, "Quest":1}, 
"11":{"Names":["Lumera", "Torchorus", "Pyrotep", "Anublaze"], "Stats":{"hp":2, "ed":2, "pd":1, "ea":3, "pa":2, "spd":4}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"54", 1:"16", 4:"89", 7:"43", 10:"101", 13:"9", 16:"80", 19:"21", 22:"77", 25:"102", 28:"48", 30:"103"}, "Locations":["Forest Area 2", "Forest Area 3"]}, "9":{"Names":["Quirk", "Kinkoon", "Centaurpede", "Subterhuge"], "Stats":{"hp":2, "ed":2, "pd":3, "ea":2, "pa":3, "spd":2}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"15", 1:"49", 4:"40", 7:"25", 10:"104", 13:"48", 16:"80", 19:"105", 22:"36", 25:"60", 28:"12", 30:"106"}, "Locations":["Forest Area 2", "Forest Area 3"]}, "10":{"Names":["Flameling", "Scorcharos", "Fyrin", "Infernus"], "Stats":{"hp":1, "ed":3, "pd":2, "ea":3, "pa":2, "spd":2}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"54", 1:"10", 4:"108", 7:"25", 10:"109", 13:"8", 16:"75", 19:"107", 22:"21", 25:"86", 28:"35", 30:"110"}, "Locations":["Forest Area 2", "Forest Area 3"]}, "8":{"Names":["Snortus", "Boartle", "Terrapig", "Coraswine"], "Stats":{"hp":2, "ed":2, "pd":4, "ea":2, "pa":3, "spd":1}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"4", 1:"111", 4:"43", 7:"39", 10:"112", 13:"28", 16:"72", 19:"114", 22:"102", 25:"11", 28:"99", 30:"113"}, "Locations":["Forest Area 2"]}, "23":{"Names":["Dark Flue", "Dark Chimnay", "Dark Firebrawl", "Dark Afterburn"], "Stats":{"hp":3, "ed":2, "pd":3, "ea":2, "pa":4, "spd":2}, "Element":"Fire", "Rarity":"Rare", "Abilities":{0:"1", 1:"4", 4:"37", 7:"39", 10:"115", 13:"28", 16:"75", 19:"76", 22:"35", 25:"77", 28:"22", 30:"116"}, "Locations":["Forest Area 2"]}, "Magicite Neophyte":{"Names":["Magicite Neophyte", "Magicite Novice", "Magicite Novice", "Magicite Novice"], "Stats":{"hp":2, "ed":4, "pd":4, "ea":4, "pa":4, "spd":3}, "Element":"Physical", "Rarity":"Common", "Abilities":{0:"67", 1:"180", 4:"240", 7:"241"}, "Quest":2}, 
"13":{"Names":["Elefauna", "Floraphaunt", "Stammoth", "Grastodon"], "Stats":{"hp":2, "ed":3, "pd":4, "ea":2, "pa":2, "spd":1}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"14", 1:"117", 4:"108", 7:"65", 10:"118", 13:"34", 16:"59", 19:"8", 22:"119", 25:"102", 28:"79", 30:"120"}, "Locations":["Forest Area 3"]}, "15":{"Names":["Hotfoot", "Flamaroo", "Kang", "Kang Fu"], "Stats":{"hp":1, "ed":2, "pd":3, "ea":2, "pa":4, "spd":2}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"32", 1:"1", 4:"108", 7:"15", 10:"121", 13:"39", 16:"76", 19:"9", 22:"95", 25:"22", 28:"81", 30:"122"}, "Locations":["Forest Area 3"]}, "22":{"Names":["Tulipinny", "Leavius", "Rubarb", "Ongabonga"], "Stats":{"hp":4, "ed":3, "pd":3, "ea":3, "pa":4, "spd":2}, "Element":"Nature", "Rarity":"Rare", "Abilities":{0:"3", 1:"25", 4:"40", 7:"89", 10:"123", 13:"67", 16:"91", 19:"39", 22:"102", 25:"35", 28:"13", 30:"124"}, "Locations":["Forest Area 3"]}, "14":{"Names":["Nessy", "Lockeel", "Cryptile", "Aquine"], "Stats":{"hp":2, "ed":3, "pd":1, "ea":3, "pa":2, "spd":2}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"2", 1:"18", 4:"40", 7:"48", 10:"125", 13:"67", 16:"29", 19:"68", 22:"102", 25:"126", 28:"13", 30:"127"}, "Locations":["Forest Area 3"]}, "12":{"Names":["Snatcher", "Hedgebagger", "Barbwiler", "Snapdragon"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":2, "pa":3, "spd":2}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"32", 1:"117", 4:"43", 7:"7", 10:"128", 13:"58", 16:"80", 19:"8", 22:"129", 25:"73", 28:"79", 30:"130"}, "Locations":["Forest Area 3"]}, "24":{"Names":["Dark Flowerpiller", "Dark Chrysaleaf", "Dark Bloombug", "Dark Fairyblossom"], "Stats":{"hp":2, "ed":2, "pd":2, "ea":4, "pa":2, "spd":4}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"15", 1:"49", 4:"40", 7:"39", 10:"131", 13:"84", 16:"19", 19:"94", 22:"95", 25:"60", 28:"79", 30:"132"}, "Locations":["Forest Area 3"]}, "Magicite Adept":{"Names":["Magicite Adept", "Magicite Novice", "Magicite Novice", "Magicite Novice"], "Stats":{"hp":2, "ed":5, "pd":5, "ea":5, "pa":5, "spd":3}, "Element":"Physical", "Rarity":"Common", "Abilities":{0:"73", 1:"241", 4:"242", 7:"243"}, "Quest":3}, 
"16":{"Names":["Twiggum", "Rootle", "Stumpede", "Wiloak"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":2, "spd":1}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"33", 1:"133", 4:"134", 7:"39", 10:"135", 13:"136", 16:"9", 19:"75", 22:"137", 25:"13", 28:"87", 30:"138"}, "Locations":["Forest Area 4"]}, "19":{"Names":["Steamguin", "Huffenpuff", "Macarovon", "Aukamotive"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":4, "pa":2, "spd":1}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"54", 1:"15", 4:"43", 7:"10", 10:"139", 13:"26", 16:"75", 19:"8", 22:"77", 25:"102", 28:"13", 30:"140"}, "Locations":["Forest Area 4"]}, "26":{"Names":["Blazebit", "Smolderon", "Grimstone", "Eruptacus"], "Stats":{"hp":"Rand", "ed":"Rand", "pd":"Rand", "ea":"Rand", "pa":"Rand", "spd":"Rand"}, "Element":"Fire", "Rarity":"Rare", "Abilities":{0:"54", 1:"33", 4:"134", 7:"89", 10:"141", 13:"28", 16:"75", 19:"39", 22:"77", 25:"13", 28:"102", 30:"142"}, "Locations":["Forest Area 4"]}, "17":{"Names":["Shellbee", "Enopen", "Amari", "Kalamos"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":2, "spd":1}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Forest Area 4"]}, "18":{"Names":["Squibee", "Bilgebrat", "Pirapus", "Krakenhook"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":2, "spd":2}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"111", 1:"15", 4:"37", 7:"48", 10:"145", 13:"67", 16:"84", 19:"72", 22:"73", 25:"13", 28:"36", 30:"146"}, "Locations":["Forest Area 4"]}, "25":{"Names":["Dark Prawnja", "Dark Hermetalcrab", "Dark Shellgun", "Dark Clawmurai"], "Stats":{"hp":4, "ed":2, "pd":3, "ea":2, "pa":3, "spd":2}, "Element":"Water", "Rarity":"Rare", "Abilities":{0:"2", 1:"15", 4:"37", 7:"48", 10:"147", 13:"97", 16:"80", 19:"98", 22:"69", 25:"21", 28:"99", 30:"148"}, "Locations":["Forest Area 4"]}, "Nature Elementum":{"Names":["Nature Elementum", "Magicite Novice", "Magicite Novice", "Magicite Novice"], "Stats":{"hp":69, "ed":5, "pd":6, "ea":6, "pa":4, "spd":4}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"245", 1:"246", 4:"247", 7:"94", 10:"248"}, "Quest":4}, 
"27":{"Names":["Frostmite", "Windigroo", "Snowsquatch", "Abomino"], "Stats":{"hp":3, "ed":3, "pd":3, "ea":4, "pa":3, "spd":3}, "Element":"Water", "Rarity":"Common", "Abilities":{0:"111", 1:"33", 4:"56", 7:"15", 10:"187", 13:"29", 16:"90", 19:"98", 22:"126", 25:"188", 28:"31", 30:"189"}, "Locations":["Crate"]}, "29":{"Names":["Statikat", "Zapeera", "Tigristrike", "Panthundra"], "Stats":{"hp":3, "ed":2, "pd":2, "ea":3, "pa":3, "spd":3}, "Element":"Lightning", "Rarity":"Common", "Abilities":{0:"16", 1:"171", 4:"108", 7:"25", 10:"196", 13:"4", 16:"80", 19:"156", 22:"160", 25:"197", 28:"36", 30:"198"}, "Locations":["Crate"]}, "34":{"Names":["Mumbah", "Simbel", "Pharaohette", "Sphynxus"], "Stats":{"hp":1, "ed":3, "pd":2, "ea":3, "pa":3, "spd":5}, "Element":"Earth", "Rarity":"Common", "Abilities":{0:"149", 1:"32", 4:"52", 7:"4", 10:"183", 13:"63", 16:"184", 19:"90", 22:"185", 25:"21", 28:"87", 30:"186"}, "Locations":["Crate"]}, "41":{"Names":["Luna", "Lestrike", "Sparkula", "Antennious"], "Stats":{"hp":3, "ed":3, "pd":3, "ea":4, "pa":3, "spd":3}, "Element":"Lightning", "Rarity":"Rare", "Abilities":{0:"4", 1:"154", 4:"158", 7:"33", 10:"155", 13:"159", 16:"84", 19:"156", 22:"157", 25:"160", 28:"64", 30:"161"}, "Locations":["Crate"]}, "42":{"Names":["Poltergust", "Spectreus", "Aethero", "Zephyrgeist"], "Stats":{"hp":2, "ed":3, "pd":2, "ea":3, "pa":3, "spd":3}, "Element":"Wind", "Rarity":"Rare", "Abilities":{0:"199", 1:"33", 4:"40", 7:"6", 10:"200", 13:"26", 16:"210", 19:"48", 22:"201", 25:"73", 28:"21", 30:"202"}, "Locations":["Crate"]}, "65":{"Names":["Ignios", "Calamitas", "Praesul", "Preliator"], "Stats":{"hp":"Rand", "ed":"Rand", "pd":"Rand", "ea":4, "pa":5, "spd":"Rand"}, "Element":"Fire", "Rarity":"Rare", "Abilities":{0:"54", 1:"10", 4:"52", 7:"203", 10:"204", 13:"180", 16:"169", 19:"39", 22:"86", 25:"205", 27:"87", 30:"206"}, "Locations":["Crate"]}, "72":{"Names":["Flurrious", "Snowdaze", "Rudolffe", "Clawsickle"], "Stats":{"hp":3, "ed":5, "pd":4, "ea":2, "pa":4, "spd":3}, "Element":"Water", "Rarity":"Exclusive", "Abilities":{0:"33", 1:"111", 4:"56", 7:"16", 10:"207", 13:"28", 16:"75", 19:"168", 22:"126", 25:"11", 28:"208", 30:"209"}, "Locations":["Crate"]}, "76":{"Names":["Valentino", "Romantius", "Blackheart", "Rebound"], "Stats":{"hp":3, "ed":3, "pd":3, "ea":5, "pa":2, "spd":2}, "Element":"Lightning", "Rarity":"Exclusive", "Abilities":{0:"25", 1:"171", 4:"52", 7:"32", 10:"172", 13:"85", 16:"173", 19:"156", 22:"79", 25:"11", 28:"87", 30:"174"}, "Locations":["Crate"]}, "77":{"Names":["Dark Cubsprout", "Dark Dandylion", "Dark Pawthorne", "Dark Bloomane"], "Stats":{"hp":3, "ed":3, "pd":2, "ea":2, "pa":5, "spd":5}, "Element":"Nature", "Rarity":"Rare", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, "84":{"Names":["Patrik", "Kismala", "Viridius", "Basiluck"], "Stats":{"hp":3, "ed":2, "pd":2, "ea":5, "pa":3, "spd":5}, "Element":"Earth", "Rarity":"Exclusive", "Abilities":{0:"149", 1:"24", 4:"56", 7:"48", 10:"150", 13:"26", 16:"75", 19:"151", 22:"21", 25:"152", 28:"87", 30:"153"}, "Locations":["Crate"]}, "93":{"Names":["Mama", "Inceptus", "Queenie", "Genesis"], "Stats":{"hp":2, "ed":3, "pd":3, "ea":5, "pa":4, "spd":1}, "Element":"Nature", "Rarity":"Exclusive", "Abilities":{0:"16", 1:"49", 4:"52", 7:"162", 10:"163", 13:"129", 16:"90", 19:"105", 22:"164", 25:"35", 28:"165", 30:"166"}, "Locations":["Crate"]}, "115":{"Names":["Lavarilla", "Sulfuro", "Scorias", "Obsidiape"], "Stats":{"hp":3, "ed":2, "pd":3, "ea":2, "pa":4, "spd":3}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"1", 1:"33", 4:"108", 7:"42", 10:"211", 13:"67", 16:"28", 19:"75", 22:"77", 25:"36", 28:"21", 30:"212"}, "Locations":["Crate"]}, "133":{"Names":["Boneshee", "Carcassoar", "Eidolon", "Osteowraith"], "Stats":{"hp":4, "ed":2, "pd":2, "ea":4, "pa":3, "spd":"Rand"}, "Element":"Wind", "Rarity":"Premium", "Abilities":{0:"24", 1:"213", 4:"52", 7:"16", 10:"214", 13:"9", 16:"90", 19:"39", 22:"201", 25:"35", 28:"87", 30:"215"}, "Locations":["Crate"]}, "141":{"Names":["Chinook", "Samoyed", "Malamute", "Sakhalin"], "Stats":{"hp":3, "ed":2, "pd":3, "ea":2, "pa":5, "spd":2}, "Element":"Wind", "Rarity":"Common", "Abilities":{0:"25", 1:"216", 4:"108", 7:"16", 10:"217", 13:"218", 16:"80", 19:"39", 22:"201", 25:"36", 28:"219", 30:"220"}, "Locations":["Crate"]}, "195":{"Names":["Cindera", "Birdanger", "Magmawis", "Cinderakaca"], "Stats":{"hp":3, "ed":"Rand", "pd":"Rand", "ea":4, "pa":4, "spd":1}, "Element":"Fire", "Rarity":"Common", "Abilities":{0:"1", 1:"4", 4:"134", 7:"24", 10:"167", 13:"168", 16:"90", 19:"169", 22:"107", 25:"73", 28:"36", 30:"170"}, "Locations":["Crate"]}, "204":{"Names":["Dark Snatcher", "Dark Hedgebagger", "Dark Barbwiler", "Dark Snapdragon"], "Stats":{"hp":2, "ed":3, "pd":3, "ea":4, "pa":3, "spd":4}, "Element":"Nature", "Rarity":"Rare", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, "222":{"Names":["Grimm Kiloray", "Grimm Electroflyte", "Grimm Luminaire", "Grimm Edison Ray"], "Stats":{"hp":4, "ed":3, "pd":3, "ea":5, "pa":3, "spd":2}, "Element":"Lightning", "Rarity":"Common", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, "223":{"Names":["Skelepup", "Dogbie", "Muttation", "Frankensnarl"], "Stats":{"hp":5, "ed":2, "pd":2, "ea":5, "pa":3, "spd":4}, "Element":"Lightning", "Rarity":"Exclusive", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, "245":{"Names":["Alpha", "Rufficus", "Direwisp", "Sire"], "Stats":{"hp":4, "ed":4, "pd":3, "ea":3, "pa":4, "spd":2}, "Element":"Nature", "Rarity":"Exclusive", "Abilities":{0:"33", 1:"117", 4:"158", 7:"42", 10:"221", 13:"66", 16:"173", 19:"221", 22:"94", 25:"222", 28:"223", 30:"224"}, "Locations":["Crate"]}, "233":{"Names":["Dark Weevern", "Dark Beeblebud", "Dark Balaurise", "Dark Serpasoar"], "Stats":{"hp":4, "ed":3, "pd":3, "ea":4, "pa":2, "spd":4}, "Element":"Nature", "Rarity":"Rare", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, "236":{"Names":["Casanova", "Heartstrings", "Rosy", "Quiver"], "Stats":{"hp":5, "ed":4, "pd":3, "ea":5, "pa":2, "spd":2}, "Element":"Fire", "Rarity":"Exclusive", "Abilities":{0:"54", 1:"33", 4:"43", 7:"89", 10:"190", 13:"191", 16:"28", 19:"192", 22:"193", 25:"160", 28:"194", 30:"195"}, "Locations":["Crate"]}, "251":{"Names":["Goldy", "Roary", "Ghast", "Beam"], "Stats":{"hp":4, "ed":4, "pd":4, "ea":1, "pa":4, "spd":1}, "Element":"Earth", "Rarity":"Premium", "Abilities":{0:"175", 1:"176", 4:"56", 7:"24", 10:"177", 13:"180", 16:"9", 19:"178", 22:"179", 25:"182", 28:"181", 30:"182"}, "Locations":["Crate"]}, "310":{"Names":["Lyeogryph", "Soaren", "Gusteron", "Zephyrnaut"], "Stats":{"hp":4, "ed":4, "pd":3, "ea":5, "pa":2, "spd":1}, "Element":"Wind", "Rarity":"Rare", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, "311":{"Names":["Jenezap", "Felico", "Noctophae", "Brontophi"], "Stats":{"hp":5, "ed":4, "pd":3, "ea":5, "pa":2, "spd":2}, "Element":"Lightning", "Rarity":"Rare", "Abilities":{0:"225", 1:"15", 4:"43", 7:"39", 10:"226", 13:"48", 16:"156", 19:"26", 22:"227", 25:"11", 28:"87", 30:"228"}, "Locations":["Crate"]}, "334":{"Names":["Furfin", "Leminkee", "Aquagouti", "Capybarale"], "Stats":{"hp":3, "ed":5, "pd":5, "ea":2, "pa":2, "spd":2}, "Element":"Nature", "Rarity":"Common", "Abilities":{0:"3", 1:"32", 4:"108", 7:"24", 10:"229", 13:"180", 16:"65", 19:"84", 22:"230", 25:"231", 28:"21", 30:"232"}, "Locations":["Crate"]}, "397":{"Names":["Elite Quirk", "Elite Kinkoon", "Elite Centaurpede", "Elite Subterhuge"], "Stats":{"hp":4, "ed":5, "pd":5, "ea":3, "pa":4, "spd":3}, "Element":"Nature", "Rarity":"Exclusive", "Abilities":{0:"15", 1:"49", 4:"40", 7:"25", 10:"104", 13:"48", 16:"80", 19:"105", 22:"36", 25:"60", 28:"12", 30:"233"}, "Locations":["Crate"]}, "403":{"Names":["Elite Alpha", "Elite Rufficus", "Elite Direwisp", "Elite Sire"], "Stats":{"hp":4, "ed":4, "pd":4, "ea":3, "pa":4, "spd":2}, "Element":"Nature", "Rarity":"Exclusive", "Abilities":{0:"15", 1:"49", 4:"40", 7:"25", 10:"104", 13:"48", 16:"80", 19:"105", 22:"36", 25:"60", 28:"12", 30:"234"}, "Locations":["Crate"]}, "423":{"Names":["Kasai", "Moeru", "Hono", "Funkasuru"], "Stats":{"hp":3, "ed":4, "pd":4, "ea":3, "pa":2, "spd":4}, "Element":"Fire", "Rarity":"Premium", "Abilities":{0:"54", 1:"33", 4:"43", 7:"235", 10:"107", 13:"191", 16:"9", 19:"169", 22:"77", 25:"160", 28:"87", 30:"236"}, "Locations":["Crate"]}, "430":{"Names":["Blighted Cubsprout", "Blighted Dandylion", "Blighted Pawthorne", "Blighted Bloomane"], "Stats":{"hp":5, "ed":3, "pd":3, "ea":3, "pa":5, "spd":5}, "Element":"Nature", "Rarity":"Exclusive", "Abilities":{0:"32", 1:"3", 4:"40", 7:"16", 10:"237", 13:"8", 16:"105", 19:"80", 22:"21", 25:"129", 28:"238", 30:"239"}, "Locations":["Crate"]}, "459":{"Names":["Light Quirk", "Light Kinkoon", "Light Centaurpede", "Light Subterhuge"], "Stats":{"hp":3, "ed":5, "pd":5, "ea":4, "pa":4, "spd":4}, "Element":"Nature", "Rarity":"Legendary", "Abilities":{0:"16", 1:"111", 4:"37", 7:"4", 10:"143", 13:"97", 16:"75", 19:"72", 22:"35", 25:"73", 28:"48", 30:"144"}, "Locations":["Crate"]}, 







}
var removed_evo = ["459", "233", "222", "223", "310", "204", "77", "76", "34", "27", "84", "93", "195", "236", "251"]
var Abilities_Data = {
"37":{"Name":"Smack", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "40":{"Name":"Swipe", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "43":{"Name":"Bite", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "108":{"Name":"Headbutt", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "52":{"Name":"Slap", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "158":{"Name":"Shove", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "56":{"Name":"Hit", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "134":{"Name":"Poke", "AP":7, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "41":{"Name":"Gash", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "237":{"Name":"Blighted Gash", "AP":11, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "180":{"Name":"Slash", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "67":{"Name":"Whammy", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "191":{"Name":"Impact", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "112":{"Name":"Snout Rush", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "226":{"Name":"Snap", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "168":{"Name":"Sprint", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe", "Additional":{"Buff":{"AP":25, "Target":"Self", "Acc":100, "Element":["spd"]}}}, "121":{"Name":"Kanga Clobber", "AP":10, "Element":"Physical", "Acc":95, "Type":"Attack", "Target":"Foe"}, "75":{"Name":"Bash", "AP":15, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "80":{"Name":"Claw", "AP":15, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "90":{"Name":"Strike", "AP":15, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "173":{"Name":"Mush", "AP":15, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "73":{"Name":"Overwhelm", "AP":20, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "92":{"Name":"Wallop", "AP":20, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "102":{"Name":"Thump", "AP":20, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "160":{"Name":"Hard Jab", "AP":20, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "62":{"Name":"Ferocity", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "238":{"Name":"Blighted Ferocity", "AP":36, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "78":{"Name":"Mighty Bash", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "116":{"Name":"Dark Mighty Bash", "AP":27, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "82":{"Name":"Needle Rifle", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "87":{"Name":"Destruction", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "209":{"Name":"Fists of Coal", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "100":{"Name":"Clamp", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "148":{"Name":"Dark Clamp", "AP":27, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "106":{"Name":"Smackdown", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "113":{"Name":"Turtle Terror", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "122":{"Name":"Rocket Punch", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "182":{"Name":"Driller", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "212":{"Name":"Overpower", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "224":{"Name":"Gnashing Jaws", "AP":4, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe", "Times":7}, "220":{"Name":"Mauler Mash", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "232":{"Name":"Smiley Slam", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "246":{"Name":"Tree Truncate", "AP":25, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe"}, "165":{"Name":"Mothers Instinct", "AP":26, "Element":"Physical", "Acc":85, "Type":"Attack", "Target":"Foe"}, "233":{"Name":"Elite Smackdown", "AP":30, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe"}, "234":{"Name":"Elite Gnashing Jaws", "AP":4, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe", "Times":8, "Additional":{"Heal":{"AP":10, "Target":"Self", "Acc":100}, "Buff":{"AP":8, "Target":"Self", "Acc":100, "Element":["pa"]}}}, "70":{"Name":"Freak Out", "AP":10, "Element":"Physical", "Acc":85, "Type":"Attack", "Target":"Foe", "Times":3}, "95":{"Name":"Blitz", "AP":10, "Element":"Physical", "Acc":90, "Type":"Attack", "Target":"Foe", "Times":2}, "188":{"Name":"Barrage", "AP":10, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe", "Times":2}, "152":{"Name":"Sloppy Rage", "AP":25, "Element":"Physical", "Acc":100, "Type":"Attack", "Target":"Foe", "Additional":{"Buff":{"AP":14, "Target":"Self", "Acc":100, "Element":["ea", "pa"]}}}, 

"175":{"Name":"Crumble", "AP":7, "Element":"Earth", "Acc":100, "Type":"Attack", "Target":"Foe"}, "177":{"Name":"Rocky Point", "AP":10, "Element":"Earth", "Acc":95, "Type":"Attack", "Target":"Foe"}, "183":{"Name":"Mummy Mudbomb", "AP":10, "Element":"Earth", "Acc":100, "Type":"Attack", "Target":"Foe"}, "184":{"Name":"Stalactite", "AP":15, "Element":"Earth", "Acc":1000, "Type":"Attack", "Target":"Foe"}, "181":{"Name":"Mudslide", "AP":20, "Element":"Earth", "Acc":90, "Type":"Attack", "Target":"Foe"}, "186":{"Name":"Pharaohs Revenge", "AP":21, "Element":"Earth", "Acc":100, "Type":"Attack", "Target":"Foe", "Additional":{"Confuse":{"AP":2, "Target":"Foe", "Acc":30}}}, 
"154":{"Name":"Zap", "AP":7, "Element":"Lightning", "Acc":100, "Type":"Attack", "Target":"Foe"}, "171":{"Name":"Spark", "AP":7, "Element":"Lightning", "Acc":100, "Type":"Attack", "Target":"Foe"}, "225":{"Name":"Flash", "AP":7, "Element":"Lightning", "Acc":100, "Type":"Attack", "Target":"Foe"}, "155":{"Name":"Lightning Orbs", "AP":10, "Element":"Lightning", "Acc":95, "Type":"Attack", "Target":"Foe"}, "196":{"Name":"Charge", "AP":10, "Element":"Lightning", "Acc":100, "Type":"Attack", "Target":"Foe"}, "172":{"Name":"Arrow Amour", "AP":9, "Element":"Lightning", "Acc":100, "Type":"Attack", "Target":"Foe"}, "156":{"Name":"Electrify", "AP":15, "Element":"Lightning", "Acc":90, "Type":"Attack", "Target":"Foe"}, "157":{"Name":"Voltage", "AP":20, "Element":"Lightning", "Acc":90, "Type":"Attack", "Target":"Foe"}, "174":{"Name":"Bow Strike", "AP":25, "Element":"Lightning", "Acc":90, "Type":"Attack", "Target":"Foe"}, "227":{"Name":"Tesla Terror", "AP":20, "Element":"Lightning", "Acc":50, "Type":"Dot", "Target":"Foe", "Turns":3}, "198":{"Name":"Ball Lightning", "AP":26, "Element":"Lightning", "Acc":90, "Type":"Attack", "Target":"Foe"}, "197":{"Name":"Thunderstorm", "AP":3, "Element":"Lightning", "Acc":90, "Type":"Attack", "Target":"Foe", "Times":7}, "228":{"Name":"Majestic Strikes", "AP":7, "Element":"Lightning", "Acc":90, "Type":"Attack", "Target":"Foe", "Times":5}, 
"149":{"Name":"Rubble", "AP":7, "Element":"Earth", "Acc":100, "Type":"Attack", "Target":"Foe"}, "150":{"Name":"Emerald Earth", "AP":10, "Element":"Earth", "Acc":95, "Type":"Attack", "Target":"Foe"}, "151":{"Name":"Stalagmite", "AP":15, "Element":"Earth", "Acc":90, "Type":"Attack", "Target":"Foe"}, "153":{"Name":"Serpent Slime", "AP":25, "Element":"Earth", "Acc":90, "Type":"Attack", "Target":"Foe", "Additional":{"Poison":{"AP":14, "Target":"Self", "Acc":50, "Turns":3}}}, 

"199":{"Name":"Breeze", "AP":7, "Element":"Wind", "Acc":100, "Type":"Attack", "Target":"Foe"}, "216":{"Name":"Gust", "AP":7, "Element":"Wind", "Acc":100, "Type":"Attack", "Target":"Foe"}, "213":{"Name":"Blow", "AP":7, "Element":"Wind", "Acc":100, "Type":"Attack", "Target":"Foe"}, "200":{"Name":"Haunting Breeze", "AP":10, "Element":"Wind", "Acc":95, "Type":"Attack", "Target":"Foe"}, "217":{"Name":"Snow Shimmer", "AP":10, "Element":"Wind", "Acc":95, "Type":"Attack", "Target":"Foe"}, "214":{"Name":"Bony Freeze", "AP":10, "Element":"Wind", "Acc":95, "Type":"Attack", "Target":"Foe"}, "201":{"Name":"Cyclone", "AP":7, "Element":"Wind", "Acc":90, "Type":"Attack", "Target":"Foe"}, "202":{"Name":"Deadly Draft", "AP":25, "Element":"Wind", "Acc":90, "Type":"Attack", "Target":"Foe"}, "210":{"Name":"Dive", "AP":15, "Element":"Wind", "Acc":90, "Type":"Attack", "Target":"Foe"}, "215":{"Name":"Perished Puff", "AP":25, "Element":"Wind", "Acc":90, "Type":"Attack", "Target":"Foe"}, 
"1":{"Name":"Burn", "AP":7, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "57":{"Name":"Dark Cinders", "AP":7, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "54":{"Name":"Cinders", "AP":7, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "141":{"Name":"Bombard", "AP":7, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe", "Times":2}, "38":{"Name":"Fire Flight", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "167":{"Name":"Cinder Ball", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "115":{"Name":"Dark Fire Flight", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "44":{"Name":"Matchsticks", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "139":{"Name":"Heat Wave", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "235":{"Name":"Torchlight", "AP":10, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "236":{"Name":"Twisted Fire", "AP":40, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "55":{"Name":"Gecko Glow", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "204":{"Name":"Reliable Fire", "AP":10, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "101":{"Name":"Flame Tail", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "190":{"Name":"Flaming Hearths", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "240":{"Name":"Dark Lava Splash", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "109":{"Name":"Fire Dance", "AP":10, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "211":{"Name":"Lava Paw", "AP":10, "Element":"Fire", "Acc":95, "Type":"Attack", "Target":"Foe"}, "76":{"Name":"Campfire", "AP":15, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "169":{"Name":"Engulf", "AP":15, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "77":{"Name":"Brimstone", "AP":20, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "86":{"Name":"Passion", "AP":20, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "242":{"Name":"Dark Brimstone", "AP":20, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "81":{"Name":"Balefire", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "170":{"Name":"Flashing Tail", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "103":{"Name":"Growlferno", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "88":{"Name":"Rapid Oxidation", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "110":{"Name":"Wicked Flame", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "140":{"Name":"Coal Fire", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, "206":{"Name":"Reaping Flame", "AP":25, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe", "Additional":{"Debuff":{"AP":8, "Target":"Foe", "Acc":100, "Element":["ed", "pd"]}}}, "142":{"Name":"Liquid Magma", "AP":25, "Element":"Fire", "Acc":100, "Type":"Attack", "Target":"Foe"}, "195":{"Name":"Love Hurts", "AP":4, "Element":"Fire", "Acc":90, "Type":"Attack", "Target":"Foe"}, 
"2":{"Name":"Sprinkle", "AP":7, "Element":"Water", "Acc":100, "Type":"Attack", "Target":"Foe"}, "111":{"Name":"Spray", "AP":7, "Element":"Water", "Acc":100, "Type":"Attack", "Target":"Foe"}, "45":{"Name":"Water Dance", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "47":{"Name":"Pincer Chop", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "147":{"Name":"Dark Pincer Chop", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "241":{"Name":"Dark Torrent", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "51":{"Name":"Fin Slosh", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "187":{"Name":"Refrigerate", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "125":{"Name":"Soak", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "143":{"Name":"Shell Splash", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "145":{"Name":"Ink Splash", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "207":{"Name":"Snowy Splash", "AP":10, "Element":"Water", "Acc":95, "Type":"Attack", "Target":"Foe"}, "68":{"Name":"Spring Shower", "AP":15, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "72":{"Name":"H2O", "AP":15, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "69":{"Name":"Storm", "AP":20, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "126":{"Name":"Geyser", "AP":20, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "243":{"Name":"Dark Geyser", "AP":20, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "71":{"Name":"Flood", "AP":25, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "74":{"Name":"Quack Attack", "AP":25, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "99":{"Name":"Hydro", "AP":25, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "127":{"Name":"Rip Tide", "AP":25, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "144":{"Name":"Wave Slap", "AP":25, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "146":{"Name":"Tentacle Tide", "AP":25, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "189":{"Name":"Glaciate", "AP":25, "Element":"Water", "Acc":100, "Type":"Attack", "Target":"Foe"}, 
"128":{"Name":"Devil's Snare", "AP":5, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe", "Additional":{"Sleep":{"AP":2, "Target":"Foe", "Acc":30}}}, "3":{"Name":"Vines", "AP":7, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe"}, "49":{"Name":"Wisp", "AP":7, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe"}, "117":{"Name":"Leaves", "AP":7, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe"}, "239":{"Name":"Blighted Leaves", "AP":47, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe", "Cooldown": - 1}, "50":{"Name":"Sting", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "221":{"Name":"Whooshing Leaves", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "163":{"Name":"Larva Lash", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "133":{"Name":"Spike Leaves", "AP":10, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe"}, "247":{"Name":"Life", "AP":1000, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe"}, "131":{"Name":"Dark Sting", "AP":11, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "53":{"Name":"Staff Sting", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "58":{"Name":"Tangle", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "118":{"Name":"Stomp", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "119":{"Name":"Harvest", "AP":10, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe", "Additional":{"Heal":{"AP":10, "Target":"Self", "Acc":100}}}, "104":{"Name":"Dirt Claw", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "229":{"Name":"Mega Vines", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "123":{"Name":"Leaf Bash", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "136":{"Name":"Grow", "AP":10, "Element":"Nature", "Acc":95, "Type":"Attack", "Target":"Foe"}, "59":{"Name":"Reap", "AP":15, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "231":{"Name":"Nature's Poison", "AP":14, "Element":"Nature", "Acc":90, "Type":"Dot", "Target":"Foe", "Turns":3}, "91":{"Name":"Bloom", "AP":15, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "105":{"Name":"Sow", "AP":15, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "60":{"Name":"Mother Nature", "AP":20, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "137":{"Name":"Lotus", "AP":20, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "244":{"Name":"Dark Lotus", "AP":20, "Element":"Water", "Acc":90, "Type":"Attack", "Target":"Foe"}, "61":{"Name":"Wicked Willow", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "248":{"Name":"Nature's Cry", "AP":25, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe"}, "93":{"Name":"Tribal Terror", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "96":{"Name":"Bug Out", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "223":{"Name":"Vine Hammer", "AP":27, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "132":{"Name":"Dark Bugs", "AP":27, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "120":{"Name":"Massive Tusks", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "124":{"Name":"Flower Power", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "130":{"Name":"Venus Fly Trap", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "138":{"Name":"Ent", "AP":25, "Element":"Nature", "Acc":90, "Type":"Attack", "Target":"Foe"}, "166":{"Name":"Shooting Spawn", "AP":6, "Element":"Nature", "Acc":100, "Type":"Attack", "Target":"Foe", "Times":5}, 
"4":{"Name":"Power Up", "AP":7, "Element":["ea", "pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, "42":{"Name":"Anger", "AP":7, "Element":["pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, "6":{"Name":"Swell", "AP":8, "Element":["ea"], "Acc":100, "Type":"Buff", "Target":"Self"}, "192":{"Name":"Power of Love", "AP":10, "Element":["ea", "pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, "218":{"Name":"Fist Pump", "AP":10, "Element":["pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, "219":{"Name":"Intimidation", "AP":10, "Element":["ea", "pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, "7":{"Name":"Flourish", "AP":8, "Element":["ea"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"8":{"Name":"Merciless", "AP":9, "Element":["ea", "pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, "9":{"Name":"Max Power", "AP":9, "Element":["ea", "pa"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"10":{"Name":"Ignite", "AP":11, "Element":["ea"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"11":{"Name":"Hyper Power", "AP":12, "Element":["ea", "pa"], "Acc":90, "Type":"Buff", "Target":"Self"}, 
"12":{"Name":"Fury", "AP":14, "Element":["pa"], "Acc":95, "Type":"Buff", "Target":"Self"}, "13":{"Name":"Merlin's Beard", "AP":14, "Element":["ea"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"14":{"Name":"Sustain", "AP":5, "Element":["ed", "pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, "85":{"Name":"Safeguard", "AP":5, "Element":["ed", "pd"], "Acc":90, "Type":"Buff", "Target":"Self"}, "15":{"Name":"Toughen Up", "AP":5, "Element":["ed", "pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, "176":{"Name":"Shield", "AP":5, "Element":["ed", "pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, "16":{"Name":"Shields Up", "AP":5, "Element":["pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"17":{"Name":"Body Armor", "AP":7, "Element":["pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, "18":{"Name":"Spirit Shield", "AP":7, "Element":["ed"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"19":{"Name":"Thrive", "AP":8, "Element":["ed", "pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"20":{"Name":"Body Shield", "AP":10, "Element":["pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"21":{"Name":"Unbreakable", "AP":11, "Element":["ed", "pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, "22":{"Name":"Body Blocker", "AP":13, "Element":["pd"], "Acc":100, "Type":"Buff", "Target":"Self"}, "23":{"Name":"Sacred Stones", "AP":13, "Element":["ed"], "Acc":100, "Type":"Buff", "Target":"Self"}, 

"24":{"Name":"Fetal Position", "AP":5, "Element":["ea", "pa"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, "25":{"Name":"Shy Smile", "AP":5, "Element":["ea", "pa"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, "203":{"Name":"Eraser", "AP":7, "Element":["ea"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, "205":{"Name":"Magic Eraser", "AP":13, "Element":["ea"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, "26":{"Name":"Feebler", "AP":8, "Element":["ea", "pa"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, 
"27":{"Name":"Tears", "AP":8, "Element":["ea", "pa"], "Acc":90, "Type":"Debuff", "Target":"Foe"}, "28":{"Name":"Tickle", "AP":8, "Element":["ea", "pa"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, 
"29":{"Name":"Bewitch", "AP":10, "Element":["ea"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, 
"30":{"Name":"Itimidation", "AP":11, "Element":["ea", "pa"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, 
"31":{"Name":"Stilled", "AP":13, "Element":["ea"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, 


"32":{"Name":"Weaken", "AP":5, "Element":["ed", "pd"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, "33":{"Name":"Debaser", "AP":5, "Element":["ed", "pd"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, 
"34":{"Name":"Acid", "AP":11, "Element":["ed"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, 
"35":{"Name":"Debilitate", "AP":11, "Element":["ed", "pd"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, 
"36":{"Name":"Sludge", "AP":11, "Element":["ed", "pd"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, 

"63":{"Name":"High Focus", "AP":10, "Element":["acc"], "Acc":100, "Type":"Buff", "Target":"Self"}, "64":{"Name":"Laser Focus", "AP":20, "Element":["acc"], "Acc":100, "Type":"Buff", "Target":"Self"}, 
"65":{"Name":"Pollen", "AP":10, "Element":["acc"], "Acc":100, "Type":"Debuff", "Target":"Foe"}, "66":{"Name":"Bright Lights", "AP":10, "Element":["acc"], "Acc":95, "Type":"Debuff", "Target":"Foe"}, 
"39":{"Name":"Confuse", "AP":2, "Element":"Fire", "Acc":50, "Type":"Confuse", "Target":"Foe"}, "46":{"Name":"Sweet Lullaby", "AP":2, "Element":"Fire", "Acc":50, "Type":"Sleep", "Target":"Foe"}, "48":{"Name":"Sleep", "AP":2, "Element":"Fire", "Acc":50, "Type":"Sleep", "Target":"Foe"}, "162":{"Name":"Lullaby", "AP":2, "Element":"Fire", "Acc":50, "Type":"Sleep", "Target":"Foe"}, "194":{"Name":"Deep Sleep", "AP":3, "Element":"Fire", "Acc":50, "Type":"Sleep", "Target":"Foe"}, "208":{"Name":"Complete Confusion", "AP":3, "Element":"Fire", "Acc":50, "Type":"Confuse", "Target":"Foe"}, "164":{"Name":"Guilt Trip", "AP":2, "Element":"Fire", "Acc":50, "Type":"Confuse", "Target":"Foe"}, 
"79":{"Name":"Venom", "AP":14, "Element":"Fire", "Acc":80, "Type":"Poison", "Target":"Foe", "Turns":3}, "245":{"Name":"Nature's Sting", "AP":15, "Element":"Fire", "Acc":80, "Type":"Poison", "Target":"Foe", "Turns":3}, "84":{"Name":"Toxic", "AP":10, "Element":"Fire", "Acc":85, "Type":"Poison", "Target":"Foe", "Turns":3}, "97":{"Name":"Acid Rain", "AP":10, "Element":"Fire", "Acc":85, "Type":"Poison", "Target":"Foe", "Turns":3}, "89":{"Name":"Poison", "AP":5, "Element":"Fire", "Acc":90, "Type":"Poison", "Target":"Foe", "Turns":3}, "179":{"Name":"Thorns", "AP":15, "Element":"Fire", "Acc":90, "Type":"Poison", "Target":"Foe", "Turns":3}, "222":{"Name":"Thorns", "AP":13, "Element":"Fire", "Acc":85, "Type":"Poison", "Target":"Foe", "Turns":3}, "161":{"Name":"Leech Drain", "AP":12, "Element":"Fire", "Acc":95, "Type":"Poison", "Target":"Foe", "Turns":3, "Additional":{"Heal":{"AP":12, "Target":"Self", "Acc":100}}}, 
"83":{"Name":"Oil Fire", "AP":0, "Element":"Water", "Acc":100, "Type":"Negate", "Target":"Self"}, "94":{"Name":"Photosynth", "AP":0, "Element":"Fire", "Acc":100, "Type":"Negate", "Target":"Self"}, "98":{"Name":"Over Water", "AP":0, "Element":"Nature", "Acc":100, "Type":"Negate", "Target":"Self"}, "114":{"Name":"Lull", "AP":0, "Element":"Nature", "Acc":100, "Type":"Negate", "Target":"Self", "Additional":{"Sleep":{"AP":2, "Target":"Foe", "Acc":30}}}, "107":{"Name":"FireWater", "AP":0, "Element":"Water", "Acc":100, "Type":"Negate", "Target":"Self"}, "129":{"Name":"Gilly Weed", "AP":0, "Element":"Fire", "Acc":100, "Type":"Negate", "Target":"Self"}, "159":{"Name":"Scorched Earth", "AP":0, "Element":"Earth", "Acc":95, "Type":"Negate", "Target":"Self"}, "178":{"Name":"Sandstorm", "AP":0, "Element":"Wind", "Acc":100, "Type":"Negate", "Target":"Self"}, 

"135":{"Name":"Replenish", "AP":10, "Element":"Water", "Acc":95, "Type":"Heal", "Target":"Self"}, "185":{"Name":"Preserve", "AP":20, "Element":"Water", "Acc":100, "Type":"Heal", "Target":"Self"}, "193":{"Name":"Love Song", "AP":22, "Element":"Water", "Acc":100, "Type":"Heal", "Target":"Self"}, "230":{"Name":"Bask", "AP":20, "Element":"Water", "Acc":100, "Type":"Heal", "Target":"Self"}, }



static func hpcolorpresset(maxx, curr):
	var percentage = curr / (maxx + 0.01) * 100
	var r = 100 - percentage
	var g = percentage
	
	r = 1.0 / 100 * r
	if r >= 0.5:
		g = 1.0 / 100 * g
	else :
		g = 1
	
	var green = Color(0, 1, 0)
	var red = Color(1, 0, 0)
	green.linear_interpolate(red, percentage)
	return Color(r, g, 0)
func add_quest(id):
	if not Quests.has(id):
		Quests.append(id)
var quests_data = {"1":{"reward":{}}}


func _ready():
	print(OS.get_unix_time())
	LoadSave()
	
	if OS.get_unix_time() >= able_to:
		print(OS.get_unix_time())
		get_tree().quit()
	
	rng.randomize()
	for rem in removed_evo:
		if Miscrits_Data.has(rem):
			Miscrits_Data.erase(rem)

	var file2Check = File.new()
		
		
			
			
	pass
var Rarities = ["Common", "Rare", "Epic", "Exotic", "Legendary", "Exclusive", "Premium"]
func get_random_miscrit():
	var rarity = Rarities[0]
	var chance = rng.randi_range(1, 10000)
	if chance <= 100:
		rarity = Rarities[6]
	elif chance <= 250:
		rarity = Rarities[5]
	elif chance <= 500:
		rarity = Rarities[4]
	elif chance <= 1000:
		rarity = Rarities[3]
	elif chance <= 2000:
		rarity = Rarities[2]
	elif chance <= 3000:
		rarity = Rarities[1]
	var possible = []
	while possible.empty():
		for variants in M.Miscrits_Data:
			if M.Miscrits_Data[variants]["Rarity"] == rarity and M.Miscrits_Data[variants].has("Locations"):
				possible.append(variants)
		if possible.empty():
			rarity = Rarities[Rarities.find(rarity) - 1]
	var unique_id = possible[rng.randi_range(0, possible.size() - 1)]
	add_new_Miscrit(unique_id)
	return unique_id
func get_stat(Stat, Dict):
	var stat_data = Miscrits_Data[Dict["Id"]]["Stats"][Stat]
	if Dict.has("c" + Stat):
		stat_data = Dict["c" + Stat]
	if str(stat_data) == "Rand":
		printerr("HERE RANDOM  STAT IT MIST BE AS IT IS?")
		stat_data = M.rng.randi_range(1, 5)
	var stat
	stat = stat_data * 2
	stat = float(stat) / 4
	stat = 5 + Dict["Level"] * stat
	if Stat == "hp":
		stat += Dict["Level"] * 3
	return round(stat)
	pass



func initiate_battle(area, id):
	
	
	for n in M.UR_TEAM:
		if M.UR_MISCRITS[n]["CHP"] >= 1:
			if not is_instance_valid(battle):
				var data
				if not Miscrits_Data.has(area):
					
					var possible_opponents = []
					for miscrit in M.Miscrits_Data:
						if M.Miscrits_Data[miscrit].has("Locations"):
							for areas in M.Miscrits_Data[miscrit]["Locations"]:
								if areas == Location + " " + area:
									possible_opponents.append(miscrit)
									break
					possible_opponents = possible_opponents[M.rng.randi_range(0, possible_opponents.size() - 1)]
					data = {"id":possible_opponents}
				else :
					data = {"id":area}
					
				BackgroundLoad.load_scene("res://Scenes/Battle/Battle.tscn", [data])
				break
			
			
			
func Gold_updated(value):
	Gold = value
	currency_updated()
func Platinum_updated(value):
	Platinum = value
	currency_updated()
func Virtue_updated(value):
	Virtue = value
	currency_updated()
func currency_updated():
	
	if is_instance_valid(Main_Ui):
		Main_Ui.update_values()
func get_evolution(dict):
	if dict["Level"] == 30:
		return "d"
	elif dict["Level"] >= 20:
		return "c"
	elif dict["Level"] >= 10:
		return "b"
	return "a"
func get_abillities_list(array_data, stroke):
	var abillities = M.Miscrits_Data[array_data["Id"]]["Abilities"].duplicate(true)
	for level_erase in abillities.duplicate(true):
		if level_erase > array_data["Level"]:
			abillities.erase(level_erase)
	abillities = abillities.values()
	
	var last = false
	abillities.invert()
	if abillities.size() >= 2:
		for remove_front in stroke * 4:
			if abillities.size() >= 1:
				abillities.pop_front()
		if abillities.size() >= 5:
			while abillities.size() >= 5:
				abillities.pop_back()
		else :
			last = true
	return [abillities, last]
	pass
func add_new_Miscrit(id):
	var uniqueid = UR_MISCRITS.keys().max() + 1
	var dict = default_miscrit_template.duplicate(true)
	for stata in Stat_names:
		if str(Miscrits_Data[id]["Stats"][stata]) == "Rand":
			dict["c" + stata] = rng.randi_range(1, 5)
	dict["Id"] = id
	dict["CHP"] = 666
	UR_MISCRITS[uniqueid] = dict
	if UR_TEAM.size() <= 3:
		UR_TEAM.append(uniqueid)
	M.MainUiTeamContainer.Update_Team()
func stop_player():
	M.player.path = M.location.get_node("Navigation2D").get_simple_path(M.player.position, M.player.position)
func Save():
		var new_save = {"UR_MISCRITS":UR_MISCRITS, "UR_TEAM":UR_TEAM, "Gold":Gold, "Virtue":Virtue, "Platinum":Platinum, "SelfPlayerPosition":M.player.position, "Version":Version, "UniqueOS":UniqueOS, "Quests":Quests, "LastUnixTime":OS.get_unix_time()}
		var FileAccess = File.new()
		FileAccess.open_encrypted_with_pass("user://save_game.dat", FileAccess.WRITE, "ZalupaBobra")
		FileAccess.store_var(new_save)
		FileAccess.close()
		
func LoadSave():
	
	var FileAccess = File.new()
	FileAccess.open_encrypted_with_pass("user://save_game.dat", FileAccess.READ, "ZalupaBobra")

	var data = FileAccess.get_var()
	print(data)
	if data is Dictionary:
		var saved_data = data
		var add_virtue = 0
		for varstr in saved_data:
			if varstr != "LastUnixTime":
				if varstr == "Version" or varstr == "UniqueOS":
					if get(varstr) != saved_data[varstr]:
						
						print("RELEASE SAVE BECAUSE ", varstr)
						var dir = Directory.new()
						saved_data = []
						break
						
						
						
						
						
				
			else :
				var diff = OS.get_unix_time() - saved_data[varstr]
				add_virtue = int(diff / 600)
				
		for varstr in saved_data:
			if get(varstr) != null:
				set(varstr, saved_data[varstr])
		M.Virtue += add_virtue
		M.Virtue = clamp(M.Virtue, 0, 100)
		FileAccess.close()
		print("Loaded game data:")
class MyCustomSorter:
	static func sort_ascending(a, b):
		if M.UR_MISCRITS[a]["Level"] > M.UR_MISCRITS[b]["Level"]:
			return true
		return false
