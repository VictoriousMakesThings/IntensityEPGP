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
item_prices = {{"Blessed Adamantite Bracers",2000,false},{"Blood-stained Pauldrons",200,false},{"Bracers of Martyrdom",2000,false},{"Bracers of the Pathfinder",1000,false},{"Chronicle of Dark Secrets",2000,false},{"Cuffs of Devastation",2000,false},{"Deadly Cuffs",2000,false},{"Furious Shackles",1000,false},{"Howling Wind Bracers",1000,false},{"Rejuvenating Bracers",1000,false},{"Stillwater Boots",2000,false},{"Tracker's Blade",1000,false},{"Anetheron's Noose",2000,false},{"Archbishop's Slippers",200,false},{"Bastion of Light",1000,false},{"Blade of Infamy",3500,false},{"Don Alejandro's Money Waist",2000,false},{"Enchanted Leather Sandals",200,false},{"Glimmering Steel Mantle",1000,false},{"Golden Links of Restoration",200,false},{"Hatefury Mantle",1000,false},{"Pillar of Ferocity",5000,false},{"Quickstrider Moccasins",1000,false},{"The Unbreakable Will",1000,false},{"Angelista's Sash",2000,false},{"Beast-tamer's Shoulder",1000,false},{"Belt of Seething Fury",200,false},{"Belt of the Crescent Moon",2000,false},{"Black Featherlight Boots",1000,false},{"Blue Suede Shoes",1000,false},{"Hammer of Atonement",1000,false},{"Kaz'rogal's Hardened Heart",1000,false},{"Leggings of Channeled Elements",2000,false},{"Razorfury Mantle",200,false},{"Sun-touched Chain Leggings",1000,false},{"Valestalker Girdle",1000,false},{"Boundless Agony",3500,false},{"Bow-stitched Leggings",2000,false},{"Don Rodrigo's Poncho",200,false},{"Girdle of Hope",2000,false},{"Glory of the Defender",1000,false},{"Gloves of the Forgotten Conqueror",2000,false},{"Gloves of the Forgotten Protector",2000,false},{"Gloves of the Forgotten Vanquisher",2000,false},{"Shady Dealer's Pantaloons",1000,false},{"Antonidas's Aegis of Rapt Concentration",2000,false},{"Apostle of Argus",1000,false},{"Bristleblitz Striker",5000,true},{"Cataclysm's Edge",5000,false},{"Helm of the Forgotten Conqueror",2000,false},{"Helm of the Forgotten Protector",2000,false},{"Helm of the Forgotten Vanquisher",2000,false},{"Leggings of Eternity",2000,false},{"Legguards of Endless Rage",1000,false},{"Mail of Fevered Pursuit",200,false},{"Midnight Chestguard",2000,false},{"Robes of Rhonin",1000,false},{"Savior's Grasp",1000,false},{"Scepter of Purification",2000,false},{"Tempest of Chaos",3500,true},{"Design: Flashing Crimson Spinel",0,false},{"Design: Great Lionseye",0,false},{"Design: Inscribed Pyrestone",0,false},{"Design: Mystic Lionseye",0,false},{"Design: Shifting Shadowsong Amethyst",0,false},{"Design: Sovereign Shadowsong Amethyst",0,false},{"Design: Stormy Empyrean Sapphire",0,false},{"Design: Veiled Pyrestone",0,false},{"Pepe's Shroud of Pacification",1000,false},{"Claw of Molten Fury",1000,false},{"Fist of Molten Fury",200,false},{"Boots of Oceanic Fury",2000,false},{"Eternium Shell Bracers",1000,false},{"Fists of Mukoa",2000,false},{"Guise of the Tidal Lurker",1000,false},{"Halberd of Desolation",5000,false},{"Head of Soothing Currents",1000,false},{"Mantle of Darkness",1000,false},{"Pearl Inlaid Boots",2000,false},{"Ring of Calming Waves",2500,false},{"Ring of Captured Storms",1000,false},{"Rising Tide",1000,false},{"Slippers of the Seacaller",2000,false},{"The Maelstrom's Fury",3500,false},{"Tide-stomper's Greaves",2000,false},{"Band of the Abyssal Lord",1000,false},{"Bands of the Coming Storm",200,false},{"Choker of Endless Nightmares",2500,false},{"Felstone Bulwark",2000,false},{"Idol of the White Stag",1000,false},{"Legionkiller",1000,false},{"Naturalist's Preserving Cinch",2000,false},{"Nether Shadow Tunic",1000,false},{"Pauldrons of Abyssal Fury",1000,false},{"Syphon of the Nathrezim",3500,false},{"The Brutalizer",3500,false},{"Waistwrap of Infinity",2000,false},{"Wraps of Precise Flight",200,false},{"Amice of Brilliant Light",200,false},{"Blind-Seers Icon",1000,false},{"Flashfire Girdle",2000,false},{"Focused Mana Bindings",1000,false},{"Grips of Silent Justice",2000,false},{"Kilt of Immortal Nature",1000,false},{"Myrmidon's Treads",1000,false},{"Praetorian's Legguards",2000,false},{"Ring of Deceitful Intent",2500,false},{"Shadow-walker's Cord",1000,false},{"Shoulder of the Hidden Predator",200,false},{"Spiritwalker Gauntlets",1000,false},{"The Seeker's Wristguards",2000,false},{"Wristbands of Divine Influence",1000,false},{"Softstep Boots of Tracking",2000,false},{"Botanist's Hands of Growth",2000,false},{"Cowl of Benevolence",1000,false},{"Gauntlets of Enforcement",2000,false},{"Girdle of Lordaeron's Fallen",2000,false},{"Insidious Bands",2000,false},{"Rifle of the Stoic Guardian",5000,false},{"Robe of the Shadow Council",200,false},{"Shadowmoon Destroyer's Drape",2500,false},{"Soul Cleaver",1000,false},{"Totem of Ancestral Guidance",2000,false},{"Twisted Blades of Zarak",2000,false},{"Waist of Primal Majesty",2000,false},{"Blood-cursed Shoulderpads",1000,false},{"Garments of Temperance",200,false},{"Girdle of Mighty Resolve",2000,false},{"Girdle of Stability",1000,false},{"Leggings of Divine Retribution",2000,false},{"Messenger of Fate",200,false},{"Shadowmoon Insignia",3500,false},{"Shroud of Forgiveness",1000,false},{"Staff of Immaculate Recovery",500,false},{"Unstoppable Aggressor's Ring",2500,false},{"Vest of Mounting Assault",1000,false},{"Wand of Prismatic Focus",2000,false},{"Boneweave Girdle",1000,false},{"Crown of Empowered Fate",1000,false},{"Dreadboots of the Legion",2000,false},{"Elunite Empowered Bracers",1000,false},{"Gloves of Unfailing Faith",1000,false},{"Grips of Damnation",2000,false},{"Naaru-Blessed Life Rod",2000,false},{"Naturewarden's Treads",2000,false},{"Pendant of Titans",1000,false},{"The Wavemender's Mantle",1000,false},{"Torch of the Damned",5000,false},{"Touch of Inspiration",1000,false},{"Translucent Spellthread Necklace",2500,false},{"Blade of Savagery",3500,false},{"Heartshatter Breastplate",1000,false},{"Leggings of Devastation",1000,false},{"Nadina's Pendant of Purity",2500,false},{"Pauldrons of the Forgotten Conqueror",2000,false},{"Pauldrons of the Forgotten Protector",2000,false},{"Pauldrons of the Forgotten Vanquisher",2000,false},{"Shadowmaster's Boots",2000,false},{"Tome of the Lightbringer",2000,false},{"Leggings of the Forgotten Conqueror",2000,false},{"Leggings of the Forgotten Protector",2000,false},{"Leggings of the Forgotten Vanquisher",2000,false},{"Belt of Divine Guidance",2000,false},{"Cloak of the Illidari Council",2500,false},{"Forest Prowler's Head",1000,false},{"Helm of the Illidari Shatterer",1000,false},{"Madness of the Betrayer",3500,true},{"Veil of Turning Leaves",200,false},{"Black Bow of the Betrayer",1000,false},{"Bulwark of Azzinoth",2000,false},{"Chestguard of the Forgotten Conqueror",2000,false},{"Chestguard of the Forgotten Protector",2000,false},{"Chestguard of the Forgotten Vanquisher",2000,false},{"Cowl of the Illidari High Lord",2000,false},{"Crystal Spire of Karabor",3500,true},{"Cursed Vision of Sargeras",2000,true},{"Faceplate of the Impenetrable",2000,false},{"Memento of Tyrande",3500,true},{"Shard of Azzinoth",1000,false},{"Shroud of the Highborne",2500,true},{"Stormrage Signet Ring",2500,false},{"The Skull of Gul'dan",3500,true},{"Warglaive of Azzinoth",3500,false},{"Warglaive of Azzinoth",2000,false},{"Zhar'doom Greatstaff of the Devourer",5000,true},{"Shroud of the Final Stand",1000,false},{"Treads of the Den Mother",2000,false},{"Pillager's Gauntlets",1000,false},{"Girdle of the Lightbearer",200,false},{"Band of Devastation",2500,false},{"Blessed Band of Karabor",2500,false},{"Ring of Ancient Knowledge",2500,false},{"Swiftsteel Bludgeon",1000,false},{"Illidari Runeshield",1000,false},{"Nethervoid Cloak",2500,false},{"Hammer of Judgement",3500,false},{"Boots of the Divine Light",2000,false},{"Chestguard of Relentless Storms",2000,false},{"Choker of Serrated Blades",2500,false},{"Hellfire-Encased Pendant",1000,false},{"Pattern: Bindings of Lightning Reflexes",0,false},{"Pattern: Bracers of Nimble Thought",0,false},{"Pattern: Bracers of Renewed Life",0,false},{"Pattern: Living Earth Bindings",0,false},{"Pattern: Swiftheal Wraps",0,false},{"Pattern: Swiftheal Mantle",1000,false},{"Pattern: Mantle of Nimble Thought",1000,false},{"Pattern: Swiftstrike Bracers",0,false},{"Plans: Dawnsteel Bracers",0,false},{"Plans: Swiftsteel Bracers",0,false},{"Glowing Breastplate of Truth",1000,false},{"Boots of Effortless Striking",200,false},{"Tempest-Strider Boots",2000,false},{"Velvet Boots of the Guardian",2000,false},{"Ancestral Ring of Conquest",1000,false},{"The Seal of Danzalar",2500,false},{"Mallet of the Tides",3500,false},{"Choker of Animalistic Fury",1000,false},{"Libram of Absolute Truth",200,false},{"Earring of Soulful Meditation",1000,false},{"Cord of Screaming Terrors",1000,false},{"Bracers of Eradication",2000,false},{"Grove-Bands of Remulos",2000,false},{"Ranger-General's Chestguard",2000,false},{"Robe of Hateful Echoes",1000,false},{"Boots of the Shifting Nightmare",500,false},{"Band of Vile Aggression",2500,false},{"Ring of Lethality",2500,false},{"Brighthelm of Justice",1000,false},{"Fathomstone",2000,false},{"Idol of the Crescent Goddess",200,false},{"Pauldrons of the Wardancer",1000,false},{"Shoulderpads of the Stranger",2000,false},{"Living Root of the Wildheart",200,false},{"Scarab of Displacement",3500,false},{"Blackfathom Warbands",2000,false},{"Wraps of Purification",2000,false},{"Razor-Scale Battlecloak",1000,false},{"Gnarled Chestpiece of the Ancients",200,false},{"Warboots of Obliteration",2000,false},{"Band of the Vigilant",1000,false},{"Ring of Sundered Souls",2500,false},{"Pendant of the Lost Ages",1000,false},{"Talon of Azshara",3500,false},{"Illidari Shoulderpads",200,false},{"Mantle of the Tireless Tracker",1000,false},{"Pauldrons of the Argent Sentinel",1000,false},{"Serpent-Coil Braid",1000,false},{"Girdle of the Tidal Call",200,false},{"Luminescent Rod of the Naaru",2000,false},{"Bloodsea Brigand's Vest",2000,false},{"Soul-Strider Boots",2000,false},{"Leggings of the Vanquished Champion",2000,false},{"Leggings of the Vanquished Defender",2000,false},{"Leggings of the Vanquished Hero",2000,false},{"Frayed Tether of the Drowned",2500,false},{"Fathom-Brooch of the Tidewalker",200,false},{"Sextant of Unstable Currents",1000,false},{"World Breaker",2000,false},{"Orca-Hide Boots",2000,false},{"Gloves of the Vanquished Champion",2000,false},{"Gloves of the Vanquished Defender",2000,false},{"Gloves of the Vanquished Hero",2000,false},{"Fang of the Leviathan",3500,false},{"Girdle of the Invulnerable",2000,false},{"True-Aim Stalker Bands",1000,false},{"Tsunami Talisman",3500,false},{"Coral-Barbed Shoulderpads",1000,false},{"Serpent Spine Longbow",5000,false},{"Krakken-Heart Breastplate",1000,false},{"Vestments of the Sea-Witch",2000,false},{"Fang of Vashj",3500,false},{"Cobra-Lash Boots",2000,false},{"Coral Band of the Revived",2500,false},{"Ring of Endless Coils",2500,false},{"Glorious Gauntlets of Crestfall",2000,false},{"Helm of the Vanquished Champion",2000,false},{"Helm of the Vanquished Defender",2000,false},{"Helm of the Vanquished Hero",2000,false},{"Lightfathom Scepter",3500,false},{"Runetotem's Mantle",1000,false},{"Prism of Inner Calm",200,false},{"Belt of One-Hundred Deaths",2000,false},{"Boots of Courage Unending",2000,false},{"Pendant of the Perilous",2500,false},{"Totem of the Maelstrom",200,false},{"Serpentshrine Shuriken",2000,false},{"Spyglass of the Hidden Fleet",200,false},{"Wildfury Greatstaff",3500,false},{"Arcanite Steam-Pistol",2000,false},{"Band of Al'ar",2500,false},{"Claw of the Phoenix",3500,false},{"Fire Crest Breastplate",1000,false},{"Gloves of the Searing Grip",2000,false},{"Mindstorm Wristbands",2000,false},{"Netherbane",3500,false},{"Phoenix-Ring of Rebirth",1000,false},{"Phoenix-Wing Cloak",2500,false},{"Talisman of the Sun King",200,false},{"Talon of Al'ar",3500,false},{"Talon of the Phoenix",3500,false},{"Tome of Fiery Redemption",1000,false},{"Cowl of the Grand Engineer",1000,false},{"Fel Reaver's Piston",200,false},{"Fel-Steel Warhelm",1000,false},{"Girdle of Zaetar",2000,false},{"Pauldrons of the Vanquished Champion",2000,false},{"Pauldrons of the Vanquished Defender",2000,false},{"Pauldrons of the Vanquished Hero",2000,false},{"Void Reaver Greaves",2000,false},{"Warp-Spring Coil",3500,false},{"Wristguards of Determination",2000,false},{"Boots of the Resilient",2000,false},{"Ethereum Life-Staff",1000,false},{"Girdle of the Righteous Path",2000,false},{"Greaves of the Bloodwarder",2000,false},{"Heartrazor",1000,false},{"Solarian's Sapphire",200,false},{"Star-Soul Breeches",200,false},{"Star-Strider Boots",2000,false},{"Trousers of the Astromancer",2000,false},{"Vambraces of Ending",2000,false},{"Void Star Talisman",200,false},{"Wand of the Forgotten Star",2000,false},{"Worldstorm Gauntlets",2000,false},{"Band of the Ranger-General",2500,false},{"Chestguard of the Vanquished Champion",2000,false},{"Chestguard of the Vanquished Defender",2000,false},{"Chestguard of the Vanquished Hero",2000,false},{"Crown of the Sun",200,false},{"Gauntlets of the Sun King",2000,false},{"Leggings of Murderous Intent",2000,false},{"Rod of the Sun King",3500,false},{"Royal Cloak of the Sunstriders",2500,false},{"Royal Gauntlets of Silvermoon",2000,false},{"Sunhawk Leggings",2000,false},{"Sunshower Light Cloak",2500,false},{"Thalassian Wildercloak",2500,false},{"The Nexus Key",3500,false},{"Twinblade of the Phoenix",5000,false},{"Verdant Sphere",2500,false},{"Ashes of Al'ar",0,false},{"Mantle of the Elven Kings",2000,false},{"Fire-Cord of the Magus",2000,false},{"Bark-Gloves of Ancient Wisdom",1000,false},{"Bands of the Celestial Archer",1000,false},{"Girdle of Fallen Stars",2000,false},{"Seventh Ring of the Tirisfalen",2500,false},{"Pattern: Boots of the Long Road",200,false},{"Pattern: Boots of Blasting",2000,false},{"Pattern: Boots of Natural Grace",200,false},{"Pattern: Boots of Utter Darkness",200,false},{"Pattern: Boots of the Crimson Hawk",200,false},{"Pattern: Hurricane Boots",200,false},{"Plans: Red Havoc Boots",200,false},{"Plans: Boots of the Protector",200,false},{"Brute Cloak of the Ogre-Magi",200,false},{"Belt of Divine Inspiration",200,false},{"Malefic Mask of the Shadows",200,false},{"Maulgar's Warhelm",200,false},{"Bladespire Warbands",200,false},{"Hammer of the Naaru",200,false},{"Pauldrons of the Fallen Champion",1000,false},{"Pauldrons of the Fallen Defender",1000,false},{"Pauldrons of the Fallen Hero",1000,false},{"Cowl of Nature's Breath",200,false},{"Gronn-Stitched Girdle",200,false},{"Gauntlets of the Dragonslayer",200,false},{"Windshear Boots",200,false},{"Gauntlets of Martial Perfection",200,false},{"Teeth of Gruul",200,false},{"Eye of Gruul",200,false},{"Dragonspine Trophy",3500,true},{"Leggings of the Fallen Champion",1000,false},{"Leggings of the Fallen Defender",1000,false},{"Leggings of the Fallen Hero",1000,false},{"Bloodmaw Magus-Blade",2000,false},{"Axe of the Gronn Lords",200,false},{"Aldori Legacy Defender",2000,false},{"Shuriken of Negation",200,false},{"Collar of Cho'gall",200,false},{"Cloak of the Pit Stalker",200,false},{"Soul-Eater's Handwraps",200,false},{"Liar's Tongue Gloves",200,false},{"Terror Pit Girdle",200,false},{"Thundering Greathelm",200,false},{"Girdle of the Endless Pit",200,false},{"Eye of Magtheridon",3500,false},{"Karaborian Talisman",200,false},{"Glaive of the Pit",200,false},{"Crystalheart Pulse-Staff",200,false},{"Aegis of the Vindicator",2000,false},{"Eredar Wand of Obliteration",1000,false},{"Chestguard of the Fallen Champion",1000,false},{"Chestguard of the Fallen Defender",1000,false},{"Chestguard of the Fallen Hero",1000,false},{"Magtheridon's Head",2500,false},{"Pit Lord's Satchel",0,false}}

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

function create_dumpframe(text)
  local s = CreateFrame("ScrollFrame", nil, UIParent, "UIPanelScrollFrameTemplate")
  s:SetSize(300,200)
  s:SetPoint("CENTER")
  s:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},})
  s:SetBackdropColor(0, 0, 0)
  local e = CreateFrame("EditBox", nil, s)
  e:SetMultiLine(true)
  e:SetFontObject(ChatFontNormal)
  e:SetWidth(300)
  s:SetScrollChild(e)

  e:SetText(text)
  e:HighlightText()

  e:SetScript("OnEscapePressed", function()
    s:Hide()
  end)

  --local b = CreateFrame("Button", "MyButton", s, "UIPanelButtonTemplate")
  --b:SetSize(80 ,22) -- width, height
  --b:SetText("Close")
  --b:SetPoint("CENTER")
  --b:SetScript("OnClick", function()
  --  s:Hide()
  --  b:Hide()
  --end)
end

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
