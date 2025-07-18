DEFAULT_AUCTION_DURATION = 20;
MIN_AUCTION_DURATION = 15;
MAX_AUCTION_DURATION = 60;
DEFAULT_LOOT_CONTROLLER_RANK = 3; -- Top two ranks. 0=GM, 1=Super Officer, 2=Officer etc
ADDON_API_VERSION = "1.1";
AUCTION_SPLIT_DELIMETER = "\t\t\t\t\t\t"

bid_item = nil;
loot_export_csv = "";
ms_bidders = {};
os_bidders = {};
loot_export_enabled = false;
item_data = {{"Bindings of Transcendence",1000,FALSE,""},{"Netherwind Bindings",500,FALSE,""},{"Nemesis Bracers",500,FALSE,""},{"Bloodfang Bracers",1000,FALSE,""},{"Stormrage Bracers",1000,FALSE,""},{"Dragonstalker's Bracers",1000,FALSE,""},{"Bracers of Ten Storms",500,FALSE,""},{"Bracelets of Wrath",0,FALSE,""},{"Arcane Infused Gem",200,FALSE,""},{"The Black Book",200,FALSE,""},{"Mantle of the Blackwing Cabal",2000,FALSE,""},{"Gloves of Rapid Evolution",200,FALSE,""},{"Spineshatter",500,FALSE,""},{"The Untamed Blade",500,FALSE,""},{"Belt of Transcendence",1000,FALSE,""},{"Netherwind Belt",500,FALSE,""},{"Nemesis Belt",500,FALSE,""},{"Bloodfang Belt",1000,FALSE,""},{"Stormrage Belt",500,FALSE,""},{"Dragonstalker's Belt",1000,FALSE,""},{"Belt of Ten Storms",500,FALSE,""},{"Waistband of Wrath",0,FALSE,""},{"Mind Quickening Gem",3000,FALSE,""},{"Rune of Metamorphosis",200,FALSE,""},{"Helm of Endless Rage",2000,FALSE,""},{"Pendant of the Fallen Dragon",200,FALSE,""},{"Red Dragonscale Protector",1500,FALSE,""},{"Dragonfang Blade",2500,FALSE,"Warrior (Tank) Non Orc=Rogue>Hunter"},{"Boots of Transcendence",1250,FALSE,""},{"Netherwind Boots",500,FALSE,""},{"Nemesis Boots",1250,FALSE,""},{"Bloodfang Boots",1250,FALSE,""},{"Stormrage Boots",500,FALSE,""},{"Dragonstalker's Greaves",1250,FALSE,""},{"Greaves of Ten Storms",500,FALSE,""},{"Sabatons of Wrath",0,FALSE,""},{"Lifegiving Gem",0,FALSE,""},{"Venomous Totem",200,FALSE,""},{"Black Brood Pauldrons",200,FALSE,""},{"Bracers of Arcane Accuracy",2000,TRUE,""},{"Heartstriker",500,FALSE,""},{"Maladath, Runed Blade of the Black Flight",3500,TRUE,"Warrior (Tank) Non Orc=Warrior (DPS) Non Orc=Rogue"},{"Head of the Broodlord Lashlayer",0,FALSE,""},{"Handguards of Transcendence",1250,FALSE,""},{"Netherwind Gloves",1250,FALSE,""},{"Nemesis Gloves",500,FALSE,""},{"Bloodfang Gloves",1250,FALSE,""},{"Stormrage Handguards",1250,FALSE,""},{"Dragonstalker's Gauntlets",1250,FALSE,""},{"Gauntlets of Ten Storms",1250,FALSE,""},{"Gauntlets of Wrath",0,FALSE,""},{"Primalist's Linked Leggings",1000,FALSE,""},{"Drake Talon Pauldrons",2000,FALSE,""},{"Cloak of Firemaw",2000,TRUE,""},{"Black Ash Robe",200,FALSE,""},{"Firemaw's Clutch",2000,FALSE,""},{"Taut Dragonhide Belt",500,FALSE,""},{"Claw of the Black Drake",1500,FALSE,""},{"Drake Talon Cleaver",1500,FALSE,""},{"Shadow Wing Focus Staff",1500,FALSE,""},{"Ring of Blackrock",1500,FALSE,""},{"Rejuvenating Gem",3000,TRUE,""},{"Handguards of Transcendence",1250,FALSE,""},{"Netherwind Gloves",1250,FALSE,""},{"Nemesis Gloves",500,FALSE,""},{"Bloodfang Gloves",1250,FALSE,""},{"Stormrage Handguards",1250,FALSE,""},{"Dragonstalker's Gauntlets",1250,FALSE,""},{"Gauntlets of Ten Storms",1250,FALSE,""},{"Gauntlets of Wrath",0,FALSE,""},{"Drake Fang Talisman",3000,TRUE,"Warrior (Tank)=Druid (Feral)=Rogue>Warrior (DPS)>Hunter=Shaman (Ench)"},{"Drake Talon Pauldrons",2000,FALSE,""},{"Ebony Flame Gloves",2000,FALSE,""},{"Taut Dragonhide Belt",2000,FALSE,""},{"Malfurion's Blessed Bulwark",2000,FALSE,"Druid (Feral)"},{"Dragonbreath Hand Cannon",0,FALSE,""},{"Drake Talon Cleaver",1500,FALSE,""},{"Shadow Wing Focus Staff",1500,FALSE,""},{"Band of Forced Concentration",2500,TRUE,""},{"Ring of Blackrock",1500,FALSE,""},{"Handguards of Transcendence",1250,FALSE,""},{"Netherwind Gloves",1250,FALSE,""},{"Nemesis Gloves",500,FALSE,""},{"Bloodfang Gloves",1250,FALSE,""},{"Stormrage Handguards",1250,FALSE,""},{"Dragonstalker's Gauntlets",1250,FALSE,""},{"Gauntlets of Ten Storms",1250,FALSE,""},{"Gauntlets of Wrath",0,FALSE,""},{"Styleen's Impeding Scarab",0,FALSE,""},{"Drake Talon Pauldrons",2000,FALSE,""},{"Shroud of Pure Thought",2000,FALSE,""},{"Taut Dragonhide Belt",2000,FALSE,""},{"Emberweave Leggings",200,FALSE,""},{"Dragon's Touch",1000,FALSE,""},{"Drake Talon Cleaver",1500,FALSE,""},{"Herald of Woe",1500,FALSE,""},{"Shadow Wing Focus Staff",1500,FALSE,""},{"Circle of Applied Force",2500,FALSE,"Warrior (Tank)=Melee DPS"},{"Ring of Blackrock",1500,FALSE,""},{"Pauldrons of Transcendence",1500,FALSE,""},{"Netherwind Mantle",500,FALSE,""},{"Nemesis Spaulders",500,FALSE,""},{"Bloodfang Spaulders",1500,FALSE,""},{"Stormrage Pauldrons",500,FALSE,""},{"Dragonstalker's Spaulders",1500,FALSE,""},{"Epaulets of Ten Storms",500,FALSE,""},{"Pauldrons of Wrath",0,FALSE,""},{"Taut Dragonhide Shoulderpads",1000,FALSE,""},{"Elementium Threaded Cloak",0,FALSE,""},{"Taut Dragonhide Gloves",200,FALSE,""},{"Angelista's Grasp",200,FALSE,""},{"Primalist's Linked Waistguard",500,FALSE,""},{"Empowered Leggings",2000,FALSE,""},{"Shimmering Geta",200,FALSE,""},{"Chromatic Boots",2000,TRUE,""},{"Ashjre'thul, Crossbow of Smiting",5000,TRUE,""},{"Elementium Reinforced Bulwark",0,FALSE,""},{"Claw of Chromaggus",2000,FALSE,""},{"Chromatically Tempered Sword",3500,TRUE,"Warrior (DPS) Non Orc=Rogue>Warrior (DPS) Orc>Warrior (Tank) Orc"},{"Robes of Transcendence",1500,FALSE,""},{"Netherwind Robes",500,FALSE,""},{"Nemesis Robes",500,FALSE,""},{"Bloodfang Chestpiece",1500,FALSE,""},{"Stormrage Chestguard",500,FALSE,""},{"Dragonstalker's Breastplate",1500,FALSE,""},{"Breastplate of Ten Storms",500,FALSE,""},{"Breastplate of Wrath",0,FALSE,""},{"Head of Nefarian",2500,FALSE,"Physical DPS"},{"Therazane's Link",2000,FALSE,"Shaman (Ench)"},{"Lok'amir il Romathis",3500,TRUE,"Druid (Resto)=Shaman (Resto/Ele)=Priest"},{"Crul'shorukh, Edge of Chaos",3500,TRUE,"Warrior (Tank) Orc=Warrior (DPS) Orc>Warrior (Tank) Non Orc=Warrior (DPS) Non Orc"},{"Ashkandi, Greatsword of the Brotherhood",500,FALSE,""},{"Staff of the Shadow Flame",5000,TRUE,"Mage=Warlock"},{"Mish'undare, Circlet of the Mind Flayer",2000,TRUE,""},{"Prestor's Talisman of Connivery",2500,TRUE,"Druid (Feral)=Rogue=Hunter"},{"Cloak of the Brood Lord",500,FALSE,""},{"Boots of the Shadow Flame",2000,FALSE,"Druid (Feral)=Rogue=Shaman (Ench)>Warrior (DPS)"},{"Archimtiros' Ring of Reckoning",500,FALSE,""},{"Pure Elementium Band",2500,TRUE,""},{"Neltharion's Tear",3000,TRUE,"Mage=Warlock=Shaman (Ele)>Shadow Priest"},{"Cloak of Draconic Might",2000,TRUE,"Warrior (Tank)=Warrior (DPS)=Druid (Feral)=Shaman (Ench)>Rogue"},{"Interlaced Shadow Jerkin",200,FALSE,""},{"Boots of Pure Thought",2000,FALSE,""},{"Ringo's Blizzard Boots",2000,FALSE,""},{"Band of Dark Dominion",2500,FALSE,""},{"Essence Gatherer",500,FALSE,""},{"Doom's Edge",3500,TRUE,"Warrior - Orc>Warrior -  Non Orc>Hunter"},{"Draconic Avenger",2000,FALSE,"Shaman (Ench)"},{"Draconic Maul",2500,FALSE,"Druid (Feral)"},{"Arcanist Boots",300,FALSE,""},{"Cenarion Boots",300,FALSE,""},{"Felheart Gloves",300,FALSE,""},{"Gauntlets of Might",0,FALSE,""},{"Earthfury Boots",300,FALSE,""},{"Choker of Enlightenment",500,FALSE,""},{"Arcanist Leggings",300,FALSE,""},{"Cenarion Leggings",300,FALSE,""},{"Felheart Pants",300,FALSE,""},{"Giantstalker's Leggings",300,FALSE,""},{"Earthfury Legguards",300,FALSE,""},{"Legplates of Might",0,FALSE,""},{"Nightslayer Pants",300,FALSE,""},{"Pants of Prophecy",300,FALSE,""},{"Earthshaker",300,FALSE,""},{"Eskhandar's Right Claw",500,FALSE,""},{"Medallion of Steadfast Might",0,FALSE,""},{"Striker's Mark",2000,FALSE,"Warrior (Tank)=Warrior (DPS)=Rogue"},{"Giantstalker's Boots",300,FALSE,""},{"Gloves of Prophecy",300,FALSE,""},{"Earthfury Gauntlets",300,FALSE,""},{"Nightslayer Gloves",300,FALSE,""},{"Sabatons of Might",0,FALSE,""},{"Arcanist Crown",300,FALSE,""},{"Cenarion Helm",300,FALSE,""},{"Circlet of Prophecy",300,FALSE,""},{"Felheart Horns",300,FALSE,""},{"Giantstalker's Helmet",300,FALSE,""},{"Helm of Might",0,FALSE,""},{"Earthfury Helmet",300,FALSE,""},{"Nightslayer Cover",300,FALSE,""},{"Aurastone Hammer",300,FALSE,""},{"Brutality Blade",2500,TRUE,"Warrior -  Non Orc=Rogue>Hunter"},{"Drillborer Disk",0,FALSE,""},{"Gutgore Ripper",300,FALSE,""},{"Arcanist Mantle",300,FALSE,""},{"Cenarion Spaulders",300,FALSE,""},{"Felheart Shoulder Pads",300,FALSE,""},{"Earthfury Epaulets",300,FALSE,""},{"Seal of the Archmagus",300,FALSE,""},{"Arcanist Gloves",300,FALSE,""},{"Boots of Prophecy",300,FALSE,""},{"Cenarion Gloves",300,FALSE,""},{"Felheart Slippers",300,FALSE,""},{"Giantstalker's Gloves",300,FALSE,""},{"Nightslayer Boots",300,FALSE,""},{"Giantstalker's Epaulets",300,FALSE,""},{"Mantle of Prophecy",300,FALSE,""},{"Nightslayer Shoulder Pads",300,FALSE,""},{"Pauldrons of Might",0,FALSE,""},{"Shadowstrike",300,FALSE,""},{"Arcanist Robes",300,FALSE,""},{"Breastplate of Might",0,FALSE,""},{"Cenarion Vestments",300,FALSE,""},{"Felheart Robes",300,FALSE,""},{"Giantstalker's Breastplate",300,FALSE,""},{"Earthfury Vestments",300,FALSE,""},{"Nightslayer Chestpiece",300,FALSE,""},{"Robes of Prophecy",300,FALSE,""},{"Azuresong Mageblade",1500,FALSE,""},{"Blastershot Launcher",500,FALSE,"Warrior (Tank)=Warrior (DPS)=Rogue"},{"Staff of Dominance",1000,FALSE,""},{"Ancient Petrified Leaf",2500,FALSE,""},{"Cauterizing Band",2500,TRUE,"Healer without Cauterizing Band>Healer"},{"Core Forged Greaves",0,FALSE,""},{"Core Hound Tooth",2500,TRUE,""},{"Hyperthermically Insulated Lava Dredger",200,FALSE,""},{"Fireguard Shoulders",0,FALSE,""},{"Fireproof Cloak",200,FALSE,""},{"Gloves of the Hypnotic Flame",200,FALSE,""},{"Sash of Whispered Secrets",300,FALSE,""},{"The Eye of Divinity",2500,TRUE,""},{"Wild Growth Spaulders",2000,TRUE,""},{"Wristguards of True Flight",500,FALSE,"Shaman (Ench)"},{"Bloodfang Pants",1250,FALSE,""},{"Dragonstalker's Legguards",1250,FALSE,""},{"Legplates of Ten Storms",500,FALSE,""},{"Leggings of Transcendence",1250,FALSE,""},{"Legplates of Wrath",0,FALSE,""},{"Nemesis Leggings",500,FALSE,""},{"Netherwind Pants",500,FALSE,""},{"Stormrage Legguards",500,FALSE,""},{"Band of Accuria",2000,TRUE,"Warrior (Tank)=Physical DPS"},{"Band of Sulfuras",500,FALSE,""},{"Bonereaver's Edge",500,FALSE,""},{"Choker of the Fire Lord",2500,TRUE,"Caster DPS"},{"Cloak of the Shrouded Mists",2000,FALSE,"Warrior (Tank)=Rogue=Hunter"},{"Crown of Destruction",2000,FALSE,"Shaman (Ench)>Hunter=Warrior (DPS)"},{"Dragon's Blood Cape",0,FALSE,""},{"Essence of the Pure Flame",200,FALSE,""},{"Malistar's Defender",300,FALSE,""},{"Onslaught Girdle",2000,TRUE,""},{"Perdition's Blade",3500,TRUE,"Warrior (Tank) Non Orc=Rogue"},{"Shard of the Flame",200,FALSE,""},{"Spinal Reaper",1500,FALSE,"Shaman (Ench)"},{"Eye of Sulfuras",0,FALSE,""},{"Cenarion Bracers",300,FALSE,""},{"Cenarion Belt",300,FALSE,""},{"Giantstalker's Bracers",300,FALSE,""},{"Giantstalker's Belt",300,FALSE,""},{"Arcanist Bindings",300,FALSE,""},{"Arcanist Belt",300,FALSE,""},{"Earthfury Bracers",300,FALSE,""},{"Earthfury Belt",300,FALSE,""},{"Vambraces of Prophecy",300,FALSE,""},{"Girdle of Prophecy",300,FALSE,""},{"Nightslayer Bracelets",300,FALSE,""},{"Nightslayer Belt",300,FALSE,""},{"Felheart Bracers",300,FALSE,""},{"Felheart Belt",300,FALSE,""},{"Bracers of Might",0,FALSE,""},{"Belt of Might",0,FALSE,""},{"Aged Core Leather Gloves",2000,TRUE,"Warrior (Tank) Non Orc=Rogue"},{"Crimson Shocker",200,FALSE,""},{"Fire Runed Grimoire",300,FALSE,""},{"Flameguard Gauntlets",1000,FALSE,""},{"Flamewaker Legplates",0,FALSE,""},{"Heavy Dark Iron Ring",0,FALSE,""},{"Magma Tempered Boots",200,FALSE,""},{"Mana Igniting Cord",2000,TRUE,""},{"Manastorm Leggings",200,FALSE,""},{"Obsidian Edged Blade",200,FALSE,""},{"Quick Strike Ring",2000,TRUE,"Warrior (Tank)=Melee DPS"},{"Ring of Spell Power",2000,TRUE,""},{"Robe of Volatile Power",1000,FALSE,""},{"Salamander Scale Pants",1000,FALSE,""},{"Sorcerous Dagger",500,FALSE,""},{"Talisman of Ephemeral Power",2000,TRUE,"Caster DPS"},{"Wristguards of Stability",2000,TRUE,"Warrior (DPS)=Druid (Feral)"},{"Aegis of Preservation",200,FALSE,""}}

local epgp = CreateFrame("Frame")
epgp:RegisterEvent("CHAT_MSG_RAID")
epgp:RegisterEvent("CHAT_MSG_RAID_LEADER")
epgp:SetScript("OnEvent", function(self, event, message, sender, ...)
  local message = strtrim(message, " ")
  local command, arguments = strsplit(" ", message, 2)
  command = strlower(command)
  if command == "!bid" then do_bid(arguments, sender)
  elseif command == "!open" then open_bids(arguments, sender)
  elseif command == "!bis" then do_bid(arguments, sender)
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

function lookup_item_data(query_item_name)
  for i=1,getn(item_data) do
    local item_name = item_data[i][1]
    local item_price = item_data[i][2]
    local is_lit = item_data[i][3]
    local class_priorities = item_data[i][4]
    if item_name == query_item_name then
      return item_price, is_lit, class_priorities
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

  auction_cost, auction_lit, class_priorities = lookup_item_data(auction_item_name)
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
  
  if class_priorities ~= nil then
    if class_priorities ~= "" then
      SendChatMessage(auction_item_link .. " has the following class priorities: " .. class_priorities, "RAID")
    end
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
