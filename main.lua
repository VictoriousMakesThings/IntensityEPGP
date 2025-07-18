DEFAULT_AUCTION_DURATION = 20;
MIN_AUCTION_DURATION = 15;
MAX_AUCTION_DURATION = 60;
DEFAULT_LOOT_CONTROLLER_RANK = 2; -- Top two ranks. 0=GM, 1=Super Officer, 2=Officer etc
ADDON_API_VERSION = "1.1";
AUCTION_SPLIT_DELIMETER = "\t\t\t\t\t\t"

bid_item = nil;
loot_export_csv = "";
ms_bidders = {};
os_bidders = {};
loot_export_enabled = false;
item_prices = {{"Band of Lucent Beams",1000,FALSE},{"Bracers of the Forgotten Conqueror",2000,FALSE},{"Bracers of the Forgotten Protector",2000,FALSE},{"Bracers of the Forgotten Vanquisher",2000,FALSE},{"Breeches of Natural Aggression",1000,FALSE},{"Breeches of Natural Splendor",1000,FALSE},{"Dragonscale-Encrusted Longblade",3500,FALSE},{"Fang of Kalecgos",200,FALSE},{"Legplates of the Holy Juggernaut",2000,FALSE},{"Pantaloons of Calming Strife",2000,FALSE},{"Pantaloons of Growing Strife",2000,FALSE},{"Starstalker Legguards",1000,FALSE},{"Judicator's Legguards",2000,FALSE},{"Belt of the Forgotten Conqueror",2000,FALSE},{"Belt of the Forgotten Protector",2000,FALSE},{"Belt of the Forgotten Vanquisher",2000,FALSE},{"Clutch of Demise",2500,FALSE},{"Collar of the Pit Lord",2500,FALSE},{"Felfury Legplates",2000,FALSE},{"Felstrength Legplates",2000,FALSE},{"Heart of the Pit",2000,FALSE},{"Leggings of Calamity",2000,FALSE},{"Reign of Misery",1000,FALSE},{"Boots of the Forgotten Conqueror",2000,FALSE},{"Boots of the Forgotten Protector",2000,FALSE},{"Boots of the Forgotten Vanquisher",2000,FALSE},{"Borderland Fortress Grips",2000,FALSE},{"Brooch of the Highborne",2500,FALSE},{"Chain Links of the Tumultuous Storm",2000,FALSE},{"Grand Magister's Staff of Torrents",1000,FALSE},{"Kilt of Spiritual Reconstruction",2000,FALSE},{"Leggings of the Immortal Beast",1000,FALSE},{"Leggings of the Immortal Night",2000,FALSE},{"Sword Breaker's Bulwark",2000,FALSE},{"Amice of the Convoker",2000,FALSE},{"Amulet of Unfettered Magics",2500,FALSE},{"Archon's Gavel",1000,FALSE},{"Band of Ruinous Delight",2500,FALSE},{"Book of Highborne Hymns",2000,TRUE},{"Crimson Paragon's Cover",2500,FALSE},{"Demontooth Shoulderpads",2000,FALSE},{"Equilibrium Epaulets",2000,FALSE},{"Erupting Epaulets",2000,FALSE},{"Golden Bow of Quel'Thalas",5000,FALSE},{"Grip of Mannoroth",1000,FALSE},{"Mantle of the Golden Forest",1000,FALSE},{"Pauldrons of Berserking",2000,FALSE},{"Pauldrons of Perseverance",2000,FALSE},{"Shawl of Wonderment",2000,FALSE},{"Shiv of Exsanguination",1000,FALSE},{"Shoulderpads of Knowledge's Pursuit",1000,FALSE},{"Shoulderpads of Vehemence",1000,FALSE},{"Shroud of Redeemed Souls",2500,FALSE},{"Sin'dorei Pendant of Conquest",200,FALSE},{"Sin'dorei Pendant of Salvation",1000,FALSE},{"Sin'dorei Pendant of Triumph",200,FALSE},{"Spaulders of Devastation",2000,FALSE},{"Spaulders of Reclamation",2000,FALSE},{"Spaulders of the Thalassian Defender",2000,FALSE},{"Spaulders of the Thalassian Savior",2000,FALSE},{"Stanchion of Primal Instinct",5000,FALSE},{"Aegis of Angelic Fortune",2000,FALSE},{"Blackened Naaru Sliver",3500,TRUE},{"Bladed Chaos Tunic",2000,FALSE},{"Breastplate of Agony's Aversion",2000,FALSE},{"Fel Conquerer Raiments",2000,FALSE},{"Garments of Crashing Shores",2000,FALSE},{"Garments of Serene Shores",2000,FALSE},{"Gauntlets of the Soothed Soul",1000,FALSE},{"Glimmering Naaru Sliver",3500,TRUE},{"Gloves of the Forest Drifter",1000,FALSE},{"Harness of Carnal Instinct",2000,FALSE},{"Heroic Judicator's Chestguard",2000,FALSE},{"Muramasa",3500,FALSE},{"Noble Judicator's Chestguard",1000,FALSE},{"Ring of Hardened Resolve",2500,FALSE},{"Ring of Omnipotence",2500,TRUE},{"Robes of Faltered Light",2000,FALSE},{"Robes of Ghostly Hatred",2000,FALSE},{"Shadowed Gauntlets of Paroxysm",2000,FALSE},{"Shifting Naaru Sliver",3500,TRUE},{"Sin'dorei Band of Dominance",200,FALSE},{"Sin'dorei Band of Salvation",1000,FALSE},{"Sin'dorei Band of Triumph",200,FALSE},{"Steely Naaru Sliver",3500,FALSE},{"Sunglow Vest",2000,FALSE},{"Utopian Tunic of Elune",1000,FALSE},{"Vicious Hawkstrider Hauberk",1000,FALSE},{"Warharness of Reckless Fury",1000,FALSE},{"Apolyon the Soul-Render",5000,FALSE},{"Borderland Paingrips",1000,FALSE},{"Cloak of Unforgivable Sin",2500,FALSE},{"Coif of Alleria",2000,FALSE},{"Cover of Ursoc the Mighty",1000,FALSE},{"Cover of Ursol the Wise",1000,FALSE},{"Cowl of Gul'dan",2000,FALSE},{"Cowl of Light's Purity",2000,FALSE},{"Crown of Anasterian",1000,FALSE},{"Crown of Dath'Remar",2000,FALSE},{"Crux of the Apocalypse",3500,FALSE},{"Dark Conjuror's Collar",2000,FALSE},{"Duplicitous Guise",2000,FALSE},{"Gloves of Tyri's Power",2000,FALSE},{"Golden Staff of the Sin'dorei",1000,FALSE},{"Hammer of Sanctification",3500,TRUE},{"Hand of the Deceiver",3500,FALSE},{"Handguards of Defiled Worlds",2000,FALSE},{"Handguards of the Dawn",2000,FALSE},{"Helm of Arcane Purity",1000,FALSE},{"Helm of Burning Righteousness",2000,FALSE},{"Helm of Uther's Resolve",2000,FALSE},{"Mask of the Fury Hunter",1000,FALSE},{"Shroud of Chieftain Ner'zhul",2000,FALSE},{"Sunflare",3500,TRUE},{"Tattered Cape of Antonidas",2500,FALSE},{"Thalassian Ranger Gauntlets",2000,FALSE},{"Thori'dal the Stars' Fury",5000,TRUE},{"Tranquil Majesty Wraps",1000,FALSE},{"Tranquil Moonlight Wraps",1000,FALSE},{"Gauntlets of the Ancient Shadowmoon",2000,FALSE},{"Gauntlets of the Ancient Frostwolf",2000,FALSE},{"Ring of Harmonic Beauty",1000,FALSE},{"Shivering Felspine",1000,FALSE},{"Mounting Vengeance",1000,FALSE},{"Blade of Life's Inevitability",200,FALSE},{"Wand of Cleansing Light",2000,FALSE},{"Wand of the Demonsoul",2000,FALSE},{"Blessed Adamantite Bracers",1000,FALSE},{"Blood-stained Pauldrons",200,FALSE},{"Bracers of Martyrdom",1000,FALSE},{"Bracers of the Pathfinder",1000,FALSE},{"Chronicle of Dark Secrets",1000,FALSE},{"Cuffs of Devastation",1000,FALSE},{"Deadly Cuffs",1000,FALSE},{"Furious Shackles",1000,FALSE},{"Howling Wind Bracers",1000,FALSE},{"Rejuvenating Bracers",1000,FALSE},{"Stillwater Boots",1000,FALSE},{"Tracker's Blade",1000,FALSE},{"Anetheron's Noose",1000,FALSE},{"Archbishop's Slippers",200,FALSE},{"Bastion of Light",1000,FALSE},{"Blade of Infamy",1000,FALSE},{"Don Alejandro's Money Waist",1000,FALSE},{"Enchanted Leather Sandals",200,FALSE},{"Glimmering Steel Mantle",1000,FALSE},{"Golden Links of Restoration",200,FALSE},{"Hatefury Mantle",1000,FALSE},{"Pillar of Ferocity",1000,FALSE},{"Quickstrider Moccasins",1000,FALSE},{"The Unbreakable Will",1000,FALSE},{"Don Alejandro's Money Belt",1000,},{"Angelista's Sash",1000,FALSE},{"Beast-tamer's Shoulder",1000,FALSE},{"Belt of Seething Fury",200,FALSE},{"Belt of the Crescent Moon",1000,FALSE},{"Black Featherlight Boots",1000,FALSE},{"Blue Suede Shoes",1000,FALSE},{"Hammer of Atonement",1000,FALSE},{"Kaz'rogal's Hardened Heart",1000,FALSE},{"Leggings of Channeled Elements",1000,FALSE},{"Razorfury Mantle",200,FALSE},{"Sun-touched Chain Leggings",1000,FALSE},{"Valestalker Girdle",1000,FALSE},{"Boundless Agony",1000,FALSE},{"Bow-stitched Leggings",1000,FALSE},{"Don Rodrigo's Poncho",200,FALSE},{"Girdle of Hope",1000,FALSE},{"Glory of the Defender",1000,FALSE},{"Gloves of the Forgotten Conqueror",1000,FALSE},{"Gloves of the Forgotten Protector",1000,FALSE},{"Gloves of the Forgotten Vanquisher",1000,FALSE},{"Shady Dealer's Pantaloons",1000,FALSE},{"Antonidas's Aegis of Rapt Concentration",1000,FALSE},{"Apostle of Argus",1000,FALSE},{"Bristleblitz Striker",1000,FALSE},{"Cataclysm's Edge",1000,FALSE},{"Helm of the Forgotten Conqueror",1000,FALSE},{"Helm of the Forgotten Protector",1000,FALSE},{"Helm of the Forgotten Vanquisher",1000,FALSE},{"Leggings of Eternity",1000,FALSE},{"Legguards of Endless Rage",200,FALSE},{"Mail of Fevered Pursuit",200,FALSE},{"Midnight Chestguard",1000,FALSE},{"Robes of Rhonin",1000,FALSE},{"Savior's Grasp",1000,FALSE},{"Scepter of Purification",1000,FALSE},{"Tempest of Chaos",1000,FALSE},{"Design: Flashing Crimson Spinel",0,FALSE},{"Design: Great Lionseye",0,FALSE},{"Design: Inscribed Pyrestone",0,FALSE},{"Design: Mystic Lionseye",0,FALSE},{"Design: Shifting Shadowsong Amethyst",0,FALSE},{"Design: Sovereign Shadowsong Amethyst",0,FALSE},{"Design: Stormy Empyrean Sapphire",0,FALSE},{"Design: Veiled Pyrestone",0,FALSE},{"Pepe's Shroud of Pacification",1000,FALSE},{"Claw of Molten Fury",1000,FALSE},{"Fist of Molten Fury",200,FALSE},{"Boots of Oceanic Fury",1000,FALSE},{"Eternium Shell Bracers",1000,FALSE},{"Fists of Mukoa",1000,FALSE},{"Guise of the Tidal Lurker",1000,FALSE},{"Halberd of Desolation",1000,FALSE},{"Head of Soothing Currents",1000,FALSE},{"Mantle of Darkness",1000,FALSE},{"Pearl Inlaid Boots",1000,FALSE},{"Ring of Calming Waves",1000,FALSE},{"Ring of Captured Storms",1000,FALSE},{"Rising Tide",1000,FALSE},{"Slippers of the Seacaller",200,FALSE},{"The Maelstrom's Fury",1000,FALSE},{"Tide-stomper's Greaves",1000,FALSE},{"Band of the Abyssal Lord",1000,FALSE},{"Bands of the Coming Storm",200,FALSE},{"Choker of Endless Nightmares",1000,FALSE},{"Felstone Bulwark",1000,FALSE},{"Idol of the White Stag",1000,FALSE},{"Legionkiller",1000,FALSE},{"Naturalist's Preserving Cinch",1000,FALSE},{"Nether Shadow Tunic",1000,FALSE},{"Pauldrons of Abyssal Fury",1000,FALSE},{"Syphon of the Nathrezim",1000,FALSE},{"The Brutalizer",200,FALSE},{"Waistwrap of Infinity",1000,FALSE},{"Wraps of Precise Flight",200,FALSE},{"Amice of Brilliant Light",200,FALSE},{"Blind-Seers Icon",1000,FALSE},{"Flashfire Girdle",1000,FALSE},{"Focused Mana Bindings",200,FALSE},{"Grips of Silent Justice",200,FALSE},{"Kilt of Immortal Nature",1000,FALSE},{"Myrmidon's Treads",1000,FALSE},{"Praetorian's Legguards",1000,FALSE},{"Ring of Deceitful Intent",1000,FALSE},{"Shadow-walker's Cord",1000,FALSE},{"Shoulders of the Hidden Predator",200,FALSE},{"Spiritwalker Gauntlets",1000,FALSE},{"The Seeker's Wristguards",1000,FALSE},{"Wristbands of Divine Influence",1000,FALSE},{"Softstep Boots of Tracking",1000,FALSE},{"Botanist's Hands of Growth",1000,FALSE},{"Cowl of Benevolence",1000,FALSE},{"Gauntlets of Enforcement",1000,FALSE},{"Girdle of Lordaeron's Fallen",1000,FALSE},{"Insidious Bands",1000,FALSE},{"Rifle of the Stoic Guardian",1000,FALSE},{"Robe of the Shadow Council",200,FALSE},{"Shadowmoon Destroyer's Drape",1000,FALSE},{"Soul Cleaver",1000,FALSE},{"Totem of Ancestral Guidance",1000,FALSE},{"Twisted Blades of Zarak",1000,FALSE},{"Botanist's Gloves of Growth",1000,FALSE},{"Belt of Primal Majesty",1000,FALSE},{"Waist of Primal Majesty",1000,FALSE},{"Blood-cursed Shoulderpads",200,FALSE},{"Garments of Temperance",200,FALSE},{"Girdle of Mighty Resolve",1000,FALSE},{"Girdle of Stability",1000,FALSE},{"Leggings of Divine Retribution",1000,FALSE},{"Messenger of Fate",200,FALSE},{"Shadowmoon Insignia",1000,FALSE},{"Shroud of Forgiveness",1000,FALSE},{"Staff of Immaculate Recovery",200,FALSE},{"Unstoppable Aggressor's Ring",1000,FALSE},{"Vest of Mounting Assault",1000,FALSE},{"Wand of Prismatic Focus",1000,FALSE},{"Boneweave Girdle",1000,FALSE},{"Crown of Empowered Fate",1000,FALSE},{"Dreadboots of the Legion",1000,FALSE},{"Elunite Empowered Bracers",1000,FALSE},{"Gloves of Unfailing Faith",1000,FALSE},{"Grips of Damnation",1000,FALSE},{"Naaru-Blessed Life Rod",1000,FALSE},{"Naturewarden's Treads",1000,FALSE},{"Pendant of Titans",1000,FALSE},{"The Wavemender's Mantle",1000,FALSE},{"Torch of the Damned",1000,FALSE},{"Touch of Inspiration",1000,FALSE},{"Translucent Spellthread Necklace",1000,FALSE},{"Blade of Savagery",1000,FALSE},{"Heartshatter Breastplate",1000,FALSE},{"Leggings of Devastation",1000,FALSE},{"Nadina's Pendant of Purity",1000,FALSE},{"Pauldrons of the Forgotten Conqueror",1000,FALSE},{"Pauldrons of the Forgotten Protector",1000,FALSE},{"Pauldrons of the Forgotten Vanquisher",1000,FALSE},{"Shadowmaster's Boots",1000,FALSE},{"Tome of the Lightbringer",1000,FALSE},{"Leggings of the Forgotten Conqueror",1000,FALSE},{"Leggings of the Forgotten Protector",1000,FALSE},{"Leggings of the Forgotten Vanquisher",1000,FALSE},{"Belt of Divine Guidance",1000,FALSE},{"Cloak of the Illidari Council",1000,FALSE},{"Forest Prowler's Head",1000,FALSE},{"Helm of the Illidari Shatterer",1000,FALSE},{"Madness of the Betrayer",1000,FALSE},{"Veil of Turning Leaves",200,FALSE},{"Black Bow of the Betrayer",1000,FALSE},{"Bulwark of Azzinoth",1000,FALSE},{"Chestguard of the Forgotten Conqueror",1000,FALSE},{"Chestguard of the Forgotten Protector",1000,FALSE},{"Chestguard of the Forgotten Vanquisher",1000,FALSE},{"Cowl of the Illidari High Lord",1000,FALSE},{"Crystal Spire of Karabor",1000,FALSE},{"Cursed Vision of Sargeras",2000,TRUE},{"Faceplate of the Impenetrable",1000,FALSE},{"Memento of Tyrande",3500,TRUE},{"Shard of Azzinoth",1000,FALSE},{"Shroud of the Highborne",2500,TRUE},{"Stormrage Signet Ring",1000,FALSE},{"The Skull of Gul'dan",3500,TRUE},{"Warglaive of Azzinoth",0,FALSE},{"Warglaive of Azzinoth",0,FALSE},{"Zhar'doom Greatstaff of the Devourer",1000,FALSE},{"Shroud of the Final Stand",1000,FALSE},{"Treads of the Den Mother",1000,FALSE},{"Pillager's Gauntlets",1000,FALSE},{"Girdle of the Lightbearer",200,FALSE},{"Band of Devastation",1000,FALSE},{"Blessed Band of Karabor",1000,FALSE},{"Ring of Ancient Knowledge",1000,FALSE},{"Swiftsteel Bludgeon",1000,FALSE},{"Illidari Runeshield",200,FALSE},{"Nethervoid Cloak",200,FALSE},{"Hammer of Judgement",200,FALSE},{"Boots of the Divine Light",1000,FALSE},{"Chestguard of Relentless Storms",1000,FALSE},{"Choker of Serrated Blades",1000,FALSE},{"Hellfire-Encased Pendant",1000,FALSE},{"Pattern: Bindings of Lightning Reflexes",0,FALSE},{"Pattern: Bracers of Nimble Thought",0,FALSE},{"Pattern: Bracers of Renewed Life",0,FALSE},{"Pattern: Living Earth Bindings",0,FALSE},{"Pattern: Swiftheal Wraps",0,FALSE},{"Pattern: Swiftheal Mantle",0,FALSE},{"Pattern: Mantle of Nimble Thought",0,FALSE},{"Pattern: Swiftstrike Bracers",0,FALSE},{"Plans: Dawnsteel Bracers",0,FALSE},{"Plans: Swiftsteel Bracers",0,FALSE},{"Glowing Breastplate of Truth",200,FALSE},{"Boots of Effortless Striking",200,FALSE},{"Tempest-Strider Boots",200,FALSE},{"Velvet Boots of the Guardian",200,FALSE},{"Ancestral Ring of Conquest",200,FALSE},{"The Seal of Danzalar",200,FALSE},{"Mallet of the Tides",200,FALSE},{"Choker of Animalistic Fury",200,FALSE},{"Libram of Absolute Truth",200,FALSE},{"Earring of Soulful Meditation",200,FALSE},{"Cord of Screaming Terrors",200,FALSE},{"Bracers of Eradication",200,FALSE},{"Grove-Bands of Remulos",200,FALSE},{"Ranger-General's Chestguard",200,FALSE},{"Robe of Hateful Echoes",200,FALSE},{"Boots of the Shifting Nightmare",200,FALSE},{"Band of Vile Aggression",200,FALSE},{"Ring of Lethality",200,FALSE},{"Brighthelm of Justice",200,FALSE},{"Fathomstone",200,FALSE},{"Idol of the Crescent Goddess",200,FALSE},{"Pauldrons of the Wardancer",200,FALSE},{"Shoulderpads of the Stranger",200,FALSE},{"Living Root of the Wildheart",200,FALSE},{"Scarab of Displacement",200,FALSE},{"Blackfathom Warbands",200,FALSE},{"Wraps of Purification",200,FALSE},{"Razor-Scale Battlecloak",200,FALSE},{"Gnarled Chestpiece of the Ancients",200,FALSE},{"Warboots of Obliteration",200,FALSE},{"Band of the Vigilant",200,FALSE},{"Ring of Sundered Souls",200,FALSE},{"Pendant of the Lost Ages",200,FALSE},{"Talon of Azshara",200,FALSE},{"Illidari Shoulderpads",200,FALSE},{"Mantle of the Tireless Tracker",200,FALSE},{"Pauldrons of the Argent Sentinel",200,FALSE},{"Serpent-Coil Braid",200,FALSE},{"Girdle of the Tidal Call",200,FALSE},{"Luminescent Rod of the Naaru",200,FALSE},{"Bloodsea Brigand's Vest",200,FALSE},{"Soul-Strider Boots",200,FALSE},{"Leggings of the Vanquished Champion",200,FALSE},{"Leggings of the Vanquished Defender",200,FALSE},{"Leggings of the Vanquished Hero",200,FALSE},{"Frayed Tether of the Drowned",200,FALSE},{"Fathom-Brooch of the Tidewalker",200,FALSE},{"Sextant of Unstable Currents",200,FALSE},{"World Breaker",200,FALSE},{"Orca-Hide Boots",200,FALSE},{"Gloves of the Vanquished Champion",200,FALSE},{"Gloves of the Vanquished Defender",200,FALSE},{"Gloves of the Vanquished Hero",200,FALSE},{"Fang of the Leviathan",200,FALSE},{"Girdle of the Invulnerable",200,FALSE},{"True-Aim Stalker Bands",200,FALSE},{"Tsunami Talisman",200,FALSE},{"Coral-Barbed Shoulderpads",200,FALSE},{"Serpent Spine Longbow",200,FALSE},{"Krakken-Heart Breastplate",200,FALSE},{"Vestments of the Sea-Witch",200,FALSE},{"Fang of Vashj",200,FALSE},{"Cobra-Lash Boots",200,FALSE},{"Coral Band of the Revived",200,FALSE},{"Ring of Endless Coils",200,FALSE},{"Glorious Gauntlets of Crestfall",200,FALSE},{"Helm of the Vanquished Champion",200,FALSE},{"Helm of the Vanquished Defender",200,FALSE},{"Helm of the Vanquished Hero",200,FALSE},{"Lightfathom Scepter",200,FALSE},{"Runetotem's Mantle",200,FALSE},{"Prism of Inner Calm",200,FALSE},{"Belt of One-Hundred Deaths",200,FALSE},{"Boots of Courage Unending",200,FALSE},{"Pendant of the Perilous",200,FALSE},{"Totem of the Maelstrom",200,FALSE},{"Serpentshrine Shuriken",200,FALSE},{"Spyglass of the Hidden Fleet",200,FALSE},{"Wildfury Greatstaff",200,FALSE},{"Arcanite Steam-Pistol",200,FALSE},{"Band of Al'ar",200,FALSE},{"Claw of the Phoenix",200,FALSE},{"Fire Crest Breastplate",200,FALSE},{"Gloves of the Searing Grip",200,FALSE},{"Mindstorm Wristbands",200,FALSE},{"Netherbane",200,FALSE},{"Phoenix-Ring of Rebirth",200,FALSE},{"Phoenix-Wing Cloak",200,FALSE},{"Talisman of the Sun King",200,FALSE},{"Talon of Al'ar",200,FALSE},{"Talon of the Phoenix",200,FALSE},{"Tome of Fiery Redemption",200,FALSE},{"Cowl of the Grand Engineer",200,FALSE},{"Fel Reaver's Piston",200,FALSE},{"Fel-Steel Warhelm",200,FALSE},{"Girdle of Zaetar",200,FALSE},{"Pauldrons of the Vanquished Champion",200,FALSE},{"Pauldrons of the Vanquished Defender",200,FALSE},{"Pauldrons of the Vanquished Hero",200,FALSE},{"Void Reaver Greaves",200,FALSE},{"Warp-Spring Coil",200,FALSE},{"Wristguards of Determination",200,FALSE},{"Boots of the Resilient",200,FALSE},{"Ethereum Life-Staff",200,FALSE},{"Girdle of the Righteous Path",200,FALSE},{"Greaves of the Bloodwarder",200,FALSE},{"Heartrazor",200,FALSE},{"Solarian's Sapphire",200,FALSE},{"Star-Soul Breeches",200,FALSE},{"Star-Strider Boots",200,FALSE},{"Trousers of the Astromancer",200,FALSE},{"Vambraces of Ending",200,FALSE},{"Void Star Talisman",200,FALSE},{"Wand of the Forgotten Star",200,FALSE},{"Worldstorm Gauntlets",200,FALSE},{"Band of the Ranger-General",200,FALSE},{"Chestguard of the Vanquished Champion",200,FALSE},{"Chestguard of the Vanquished Defender",200,FALSE},{"Chestguard of the Vanquished Hero",200,FALSE},{"Crown of the Sun",200,FALSE},{"Gauntlets of the Sun King",200,FALSE},{"Leggings of Murderous Intent",200,FALSE},{"Rod of the Sun King",200,FALSE},{"Royal Cloak of the Sunstriders",200,FALSE},{"Royal Gauntlets of Silvermoon",200,FALSE},{"Sunhawk Leggings",200,FALSE},{"Sunshower Light Cloak",200,FALSE},{"Thalassian Wildercloak",200,FALSE},{"The Nexus Key",200,FALSE},{"Twinblade of the Phoenix",200,FALSE},{"Verdant Sphere",200,FALSE},{"Ashes of Al'ar",0,FALSE},{"Mantle of the Elven Kings",200,FALSE},{"Fire-Cord of the Magus",200,FALSE},{"Bark-Gloves of Ancient Wisdom",200,FALSE},{"Bands of the Celestial Archer",200,FALSE},{"Girdle of Fallen Stars",200,FALSE},{"Seventh Ring of the Tirisfalen",200,FALSE},{"Pattern: Boots of the Long Road",0,FALSE},{"Pattern: Boots of Blasting",0,FALSE},{"Pattern: Boots of Natural Grace",0,FALSE},{"Pattern: Boots of Utter Darkness",0,FALSE},{"Pattern: Boots of the Crimson Hawk",0,FALSE},{"Pattern: Hurricane Boots",0,FALSE},{"Plans: Red Havoc Boots",0,FALSE},{"Plans: Boots of the Protector",0,FALSE},{"Brute Cloak of the Ogre-Magi",200,FALSE},{"Belt of Divine Inspiration",200,FALSE},{"Malefic Mask of the Shadows",200,FALSE},{"Maulgar's Warhelm",200,FALSE},{"Bladespire Warbands",200,FALSE},{"Hammer of the Naaru",200,FALSE},{"Pauldrons of the Fallen Champion",200,FALSE},{"Pauldrons of the Fallen Defender",200,FALSE},{"Pauldrons of the Fallen Hero",200,FALSE},{"Cowl of Nature's Breath",200,FALSE},{"Gronn-Stitched Girdle",200,FALSE},{"Gauntlets of the Dragonslayer",200,FALSE},{"Windshear Boots",200,FALSE},{"Gauntlets of Martial Perfection",200,FALSE},{"Teeth of Gruul",200,FALSE},{"Eye of Gruul",200,FALSE},{"Dragonspine Trophy",3500,TRUE},{"Leggings of the Fallen Champion",200,FALSE},{"Leggings of the Fallen Defender",200,FALSE},{"Leggings of the Fallen Hero",200,FALSE},{"Bloodmaw Magus-Blade",200,FALSE},{"Axe of the Gronn Lords",200,FALSE},{"Aldori Legacy Defender",200,FALSE},{"Shuriken of Negation",200,FALSE},{"Collar of Cho'gall",200,FALSE},{"Cloak of the Pit Stalker",200,FALSE},{"Soul-Eater's Handwraps",200,FALSE},{"Liar's Tongue Gloves",200,FALSE},{"Terror Pit Girdle",200,FALSE},{"Thundering Greathelm",200,FALSE},{"Girdle of the Endless Pit",200,FALSE},{"Eye of Magtheridon",200,FALSE},{"Karaborian Talisman",200,FALSE},{"Glaive of the Pit",200,FALSE},{"Crystalheart Pulse-Staff",200,FALSE},{"Aegis of the Vindicator",200,FALSE},{"Eredar Wand of Obliteration",200,FALSE},{"Chestguard of the Fallen Champion",200,FALSE},{"Chestguard of the Fallen Defender",200,FALSE},{"Chestguard of the Fallen Hero",200,FALSE},{"Magtheridon's Head",200,FALSE},{"Pit Lord's Satchel",0,FALSE}}

local epgp = CreateFrame("Frame")
epgp:RegisterEvent("CHAT_MSG_RAID")
epgp:RegisterEvent("CHAT_MSG_RAID_LEADER")
epgp:SetScript("OnEvent", function(self, event, message, sender, ...)
  local message = strtrim(message, " ")
  local command, arguments = strsplit(" ", message, 2)
  command = strlower(command)
  if command == "!bid" then do_bid(arguments, sender)
  elseif command == "!open" then open_bids(arguments, sender)
  elseif command == "!bis" then epgp_unknown_command(sender)
  elseif command == "!help" then epgp_help_command(sender)
  elseif command == "!close" then close_bids(sender)
  end
end)

function can_bid(name)
  -- function: can_bid
  -- @name,string - Player name
  -- @return,boolean
  -- Returns true if the player has the correct permissions to bid on items in a raid.
  --   Placeholder function. Has been implemented where necessary.
  return true;
end

function is_lootmaster(name)
  -- function: is_lootmaster
  -- @name,string - Player name
  -- @return,boolean
  -- Returns true if the player has the correct permissions to control loot in a raid.
  --   This is decided by their rank in the guild, usually the ranks at or above 
  --   DEFAULT_LOOT_CONTROLLER_RANK, then they have permission.
  for i=1,GetNumGuildMembers() do
    local guildname, rank, rankIndex=GetGuildRosterInfo(i);
    if guildname==name and rankIndex <= DEFAULT_LOOT_CONTROLLER_RANK then
      return true;
    end
  end

  return false;
end

function epgp_unknown_command(player)
  -- function: epgp_unknown_command
  -- @player,string - The player who sent the command
  -- Messages an error to the sender about the invalid command.
  SendChatMessage("iEPGP: Unknown command. Type !bid ms, !bid os, or !bid cancel.", "WHISPER", nil, player)
end

function epgp_help_command(player)
  -- function: epgp_help_command
  -- @player,string - The player who requested the help command
  -- Messages help information to the requestee.
  SendChatMessage("iEPGP: After bidding has opened (look for the raid warning), type !bid ms (for main spec), !bid os (for off spec), or !bid cancel (to retract bids).", "WHISPER", nil, player)
end

function open_bids(gp_string, player)
  if not is_lootmaster(player) then
    return;
  end

  local auction_item, auction_cost, auction_quantity, auction_duration = strsplit(AUCTION_SPLIT_DELIMETER, gp_string);
  auction_string = gp_string;

  local item = Item:CreateFromItemLink(auction_item)
  item:ContinueOnItemLoad(start_auction)
end

function get_item_gp(query_item_name)
  for i=1,getn(item_prices) do
    local item_name = item_prices[i][1]
    local item_price = item_prices[i][2]
    local is_lit = item_prices[i][3]
    if item_name == query_item_name then
      return item_price, is_lit
    end
  end
  return nil
end

function start_auction()
  if bid_item ~= nil then
    SendChatMessage("iEPGP: Bids not opened, close previous item first.", "RAID");
    return;
  end

  local auction_item, auction_cost, auction_quantity, auction_duration = strsplit(AUCTION_SPLIT_DELIMETER, auction_string);

  local auction_item_name, auction_item_link = GetItemInfo(auction_item);
  if auction_item_name == nil then
    SendChatMessage("iEPGP: Bids not opened, invalid item.", "RAID");
    return;
  end

  auction_cost, auction_lit = get_item_gp(auction_item_name)
  auction_quantity = tonumber(auction_quantity);
  auction_duration = tonumber(auction_duration);

  if auction_duration == nil then
    auction_duration = DEFAULT_AUCTION_DURATION;
  elseif auction_duration < MIN_AUCTION_DURATION then
    auction_duration = MIN_AUCTION_DURATION;
  elseif auction_duration > MAX_AUCTION_DURATION then
    auction_duration = MAX_AUCTION_DURATION;
  end

  if auction_quantity == nil then
    auction_quantity = 1;
  end

  bid_item = auction_item_link;

  if auction_cost ~= nil then
    if auction_lit then
      SendChatMessage("iEPGP: "..auction_item_link.." (GP: " .. auction_cost .. ", *LUXURY ITEM*) open for bidding (closing in ".. auction_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
    else
      SendChatMessage("iEPGP: "..auction_item_link.." (GP: " .. auction_cost .. ") open for bidding (closing in ".. auction_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
    end
  else
    auction_cost = "N/A"
    SendChatMessage("iEPGP: "..auction_item_link.." open for bidding (closing in ".. auction_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
  end

  C_ChatInfo.SendAddonMessage("iEPGP", ADDON_API_VERSION .. "\t" .. "open\t" .. auction_item_link .. "\t" .. auction_cost .. "\t" .. auction_quantity .. "\t" .. auction_duration .. "\t" .. tostring(auction_lit), "RAID")

  iepgp_a4 = C_Timer.NewTimer(auction_duration - 10, function() SendChatMessage("iEPGP: "..bid_item.." bids closing in 10 seconds!", "RAID_WARNING") end)
  iepgp_a3 = C_Timer.NewTimer(auction_duration - 3, function() SendChatMessage("iEPGP: Closing in 3", "RAID") end)
  iepgp_a2 = C_Timer.NewTimer(auction_duration - 2, function() SendChatMessage("iEPGP: Closing in 2", "RAID") end)
  iepgp_a1 = C_Timer.NewTimer(auction_duration - 1, function() SendChatMessage("iEPGP: Closing in 1", "RAID") end)
  iepgp_a0 = C_Timer.NewTimer(auction_duration, end_bids)
  
  auction_string = nil;
end

function terminate_alert_timers()
  if iepgp_a4 ~= nil then iepgp_a4:Cancel() end
  if iepgp_a3 ~= nil then iepgp_a3:Cancel() end
  if iepgp_a2 ~= nil then iepgp_a2:Cancel() end
  if iepgp_a1 ~= nil then iepgp_a1:Cancel() end
  if iepgp_a0 ~= nil then iepgp_a0:Cancel() end
end

function close_bids(player)
  if not is_lootmaster(player) or player == nil then
    return;
  end

  if bid_item == nil then
    SendChatMessage("iEPGP: Could not close bids, no item is currently open for bidding.", "WHISPER", nil, player)
    return;
  end

  terminate_alert_timers()
  end_bids()
end

function end_bids()
  local ms_bidders_text = ""
  local os_bidders_text = ""

  for i=1,getn(ms_bidders) do
    local name = ms_bidders[i];
    if strlen(ms_bidders_text) > 0 then
      ms_bidders_text = ms_bidders_text .. ", " .. name;
    else
      ms_bidders_text = name;
    end
  end

  for i=1,getn(os_bidders) do
    local name = os_bidders[i];
    if strlen(os_bidders_text) > 0 then
      os_bidders_text = os_bidders_text .. ", " .. name;
    else
      os_bidders_text = name;
    end
  end
  
  if (ms_bidders_text ~= "") then
    SendChatMessage("iEPGP: MS bids for "..bid_item..": "..ms_bidders_text, "RAID");
  elseif (os_bidders_text ~= "") then
    SendChatMessage("iEPGP: OS bids for "..bid_item..": "..os_bidders_text, "RAID");
  else
    SendChatMessage("iEPGP: No bids for "..bid_item..".", "RAID");
  end

  -- C_ChatInfo.SendAddonMessage("iEPGP", ADDON_API_VERSION .. "\t" .. "close", "RAID")
  SendChatMessage("iEPGP: Bids closed for "..bid_item, "RAID")
  bid_item = nil;
  ms_bidders = {};
  os_bidders = {};
end

function cancel_bid(bidders, gpPlayer)
  local cleaned = false;
  if tContains(bidders, gpPlayer) then
    for i=1,getn(bidders) do
      if bidders[i] == gpPlayer then
        tremove(bidders, i)
        cleaned = true;
        break
      end
    end
  end
  return cleaned, bidders;
end

function do_bid(spec, gpPlayer)
  if not can_bid(player) or gpPlayer == nil then
    return;
  end

  if bid_item == nil then
    SendChatMessage("iEPGP: No item is currently open for bidding.", "WHISPER", nil, gpPlayer)
    return;
  end

  spec = strlower(spec);
  gpPlayer = strsplit("-", gpPlayer);

  if spec == "ms" or spec == "main" then
    if tContains(ms_bidders, gpPlayer) then
      SendChatMessage("iEPGP: You've already bid main spec on "..bid_item..".", "WHISPER", nil, gpPlayer)
    else
      local cleaned, os_bidders = cancel_bid(os_bidders, gpPlayer);
      if cleaned then
        SendChatMessage("iEPGP: Your bid has been updated to main spec for "..bid_item..".", "WHISPER", nil, gpPlayer)
      else
        SendChatMessage("iEPGP: Main spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
      end
      tinsert(ms_bidders, gpPlayer)
    end
  elseif spec == "os" or spec == "off" or spec == "offspec" then
    if tContains(os_bidders, gpPlayer) then
      SendChatMessage("iEPGP: You've already bid off spec on "..bid_item..".", "WHISPER", nil, gpPlayer)
    else
      local cleaned, ms_bidders = cancel_bid(ms_bidders, gpPlayer);
      if cleaned then
        SendChatMessage("iEPGP: Your bid has been updated to off spec for "..bid_item..".", "WHISPER", nil, gpPlayer)
      else
        SendChatMessage("iEPGP: Off spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
      end
      tinsert(os_bidders, gpPlayer)
    end
  elseif spec == "cancel" then
    local cleaned_ms, ms_bidders = cancel_bid(ms_bidders, gpPlayer);
    local cleaned_os, os_bidders = cancel_bid(os_bidders, gpPlayer);
    if cleaned_ms or cleaned_os then
      SendChatMessage("iEPGP: Your bid has successfully been withdrawn.", "WHISPER", nil, gpPlayer)
    else
      SendChatMessage("iEPGP: You do not appear to have a bid active on the current item.", "WHISPER", nil, gpPlayer)
    end
  else
    SendChatMessage("iEPGP: Bid not accepted for "..bid_item..". Please specify spec, e.g `!bid ms` or `!bid os`.", "WHISPER", nil, gpPlayer)
    return;
  end
end
