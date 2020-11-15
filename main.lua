DEFAULT_AUCTION_DURATION = 20;
MIN_AUCTION_DURATION = 15;
MAX_AUCTION_DURATION = 60;
DEFAULT_LOOT_CONTROLLER_RANK = 2; -- Top two ranks. 0=GM, 1=Officer etc
ADDON_API_VERSION = "1.1";
AUCTION_SPLIT_DELIMETER = "\t\t\t\t\t\t"

bid_item = nil;
loot_export_csv = "";
ms_bidders = {};
os_bidders = {};
loot_export_enabled = false;
item_prices = {{"Bindings of Transcendence",1000},{"Netherwind Bindings",1000},{"Nemesis Bracers",200},{"Bloodfang Bracers",200},{"Stormrage Bracers",200},{"Dragonstalker's Bracers",1000},{"Judgement Bindings",200},{"Bracelets of Wrath",200},{"Arcane Infused Gem",200},{"The Black Book",200},{"Mantle of the Blackwing Cabal",2000},{"Gloves of Rapid Evolution",200},{"Spineshatter",500},{"The Untamed Blade",500},{"Belt of Transcendence",1000},{"Netherwind Belt",1000},{"Nemesis Belt",200},{"Bloodfang Belt",200},{"Stormrage Belt",200},{"Dragonstalker's Belt",1000},{"Judgement Belt",200},{"Waistband of Wrath",200},{"Mind Quickening Gem",3000},{"Rune of Metamorphosis",200},{"Helm of Endless Rage",200},{"Pendant of the Fallen Dragon",200},{"Red Dragonscale Protector",200},{"Dragonfang Blade",500},{"Boots of Transcendence",1000},{"Netherwind Boots",1000},{"Nemesis Boots",200},{"Bloodfang Boots",200},{"Stormrage Boots",200},{"Dragonstalker's Greaves",1000},{"Judgement Sabatons",200},{"Sabatons of Wrath",200},{"Lifegiving Gem",200},{"Venomous Totem",200},{"Black Brood Pauldrons",200},{"Bracers of Arcane Accuracy",1000},{"Heartstriker",500},{"Maladath, Runed Blade of the Black Flight",3500},{"Head of the Broodlord Lashlayer",0},{"Handguards of Transcendence",1000},{"Netherwind Gloves",1000},{"Nemesis Gloves",200},{"Bloodfang Gloves",200},{"Stormrage Handguards",200},{"Dragonstalker's Gauntlets",1000},{"Judgement Gauntlets",200},{"Gauntlets of Wrath",200},{"Scrolls of Blinding Light",200},{"Drake Talon Pauldrons",200},{"Cloak of Firemaw",200},{"Black Ash Robe",200},{"Firemaw's Clutch",200},{"Taut Dragonhide Belt",200},{"Legguards of the Fallen Crusader",200},{"Claw of the Black Drake",500},{"Drake Talon Cleaver",500},{"Shadow Wing Focus Staff",500},{"Ring of Blackrock",200},{"Rejuvenating Gem",3000},{"Handguards of Transcendence",1000},{"Netherwind Gloves",1000},{"Nemesis Gloves",200},{"Bloodfang Gloves",200},{"Stormrage Handguards",200},{"Dragonstalker's Gauntlets",1000},{"Judgement Gauntlets",200},{"Gauntlets of Wrath",200},{"Aegis of Preservation",200},{"Drake Fang Talisman",3000},{"Rejuvenating Gem",3000},{"Drake Talon Pauldrons",200},{"Ebony Flame Gloves",200},{"Taut Dragonhide Belt",200},{"Malfurion's Blessed Bulwark",200},{"Dragonbreath Hand Cannon",500},{"Drake Talon Cleaver",500},{"Shadow Wing Focus Staff",500},{"Band of Forced Concentration",200},{"Ring of Blackrock",200},{"Handguards of Transcendence",1000},{"Netherwind Gloves",1000},{"Nemesis Gloves",200},{"Bloodfang Gloves",200},{"Stormrage Handguards",200},{"Dragonstalker's Gauntlets",1000},{"Judgement Gauntlets",200},{"Gauntlets of Wrath",200},{"Rejuvenating Gem",3000},{"Styleen's Impeding Scarab",200},{"Drake Talon Pauldrons",200},{"Shroud of Pure Thought",200},{"Taut Dragonhide Belt",200},{"Emberweave Leggings",200},{"Dragon's Touch",500},{"Drake Talon Cleaver",500},{"Herald of Woe",500},{"Shadow Wing Focus Staff",500},{"Circle of Applied Force",2500},{"Ring of Blackrock",200},{"Pauldrons of Transcendence",1000},{"Netherwind Mantle",1000},{"Nemesis Spaulders",200},{"Bloodfang Spaulders",200},{"Stormrage Pauldrons",200},{"Dragonstalker's Spaulders",1000},{"Judgement Spaulders",200},{"Pauldrons of Wrath",200},{"Taut Dragonhide Shoulderpads",200},{"Elementium Threaded Cloak",200},{"Taut Dragonhide Gloves",200},{"Angelista's Grasp",200},{"Girdle of the Fallen Crusader",200},{"Empowered Leggings",2000},{"Shimmering Geta",200},{"Chromatic Boots",2000},{"Ashjre'thul, Crossbow of Smiting",5000},{"Elementium Reinforced Bulwark",200},{"Claw of Chromaggus",500},{"Chromatically Tempered Sword",3500},{"Robes of Transcendence",1000},{"Netherwind Robes",1000},{"Nemesis Robes",200},{"Bloodfang Chestpiece",200},{"Stormrage Chestguard",200},{"Dragonstalker's Breastplate",1000},{"Judgement Breastplate",200},{"Breastplate of Wrath",200},{"Head of Nefarian",2500},{"Therazane's Link",200},{"Lok'amir il Romathis",3500},{"Crul'shorukh, Edge of Chaos",3500},{"Ashkandi, Greatsword of the Brotherhood",500},{"Staff of the Shadow Flame",2000},{"Mish'undare, Circlet of the Mind Flayer",2000},{"Prestor's Talisman of Connivery",2500},{"Cloak of the Brood Lord",200},{"Boots of the Shadow Flame",2000},{"Archimtiros' Ring of Reckoning",200},{"Pure Elementium Band",2500},{"Neltharion's Tear",3000},{"Cloak of Draconic Might",200},{"Interlaced Shadow Jerkin",200},{"Boots of Pure Thought",2000},{"Ringo's Blizzard Boots",200},{"Band of Dark Dominion",2500},{"Essence Gatherer",500},{"Doom's Edge",500},{"Draconic Avenger",500},{"Draconic Maul",500},{"Barrage Shoulders",200},{"Breastplate of Annihilation",2000},{"Beetle Scaled Wristguards",0},{"Leggings of Immersion",200},{"Boots of the Fallen Prophet",200},{"Boots of the Redeemed Prophecy",200},{"Boots of the Unwavering Will",200},{"Amulet of Foul Warding",0},{"Pendant of the Qiraji Guardian",200},{"Cloak of Concentrated Hatred",2000},{"Ring of Swarming Thought",200},{"Hammer of Ji'zhi",500},{"Staff of the Qiraji Prophets",500},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Guise of the Devourer",2000},{"Ternary Mantle",2000},{"Cape of the Trinity",200},{"Robes of the Triumvirate",0},{"Triad Girdle",200},{"Angelista's Touch",200},{"Vest of Swift Execution",200},{"Ring of the Devoured",200},{"Petrified Scarab",0},{"Wand of Qiraji Nobility",2000},{"Angelista's Charm",200},{"Gloves of Ebru",200},{"Ooze-ridden Gauntlets",0},{"Boots of the Fallen Hero",2000},{"Mantle of Phrenic Power",200},{"Mantle of the Desert's Fury",200},{"Mantle of the Desert's Crusade ",200},{"Bile-Covered Gauntlets",0},{"Ukko's Ring of Darkness",0},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Creeping Vine Helm",200},{"Necklace of Purity",0},{"Robes of the Battleguard",200},{"Gloves of Enforcement",2000},{"Gauntlets of Steadfast Determination",200},{"Thick Qirajihide Belt",200},{"Leggings of the Festering Swarm",2000},{"Scalred Leggings of Qiraji Fury",200},{"Legplates of Blazing Light",2000},{"Recomposed Boots",0},{"Badge of the Swarmguard",3000},{"Sartura's Might",2000},{"Silithid Claw",500},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Mantle of Wicked Revenge",200},{"Pauldrons of the Unrelenting",200},{"Cloak of Untold Secrets",0},{"Robes of the Guardian Saint",2000},{"Silithis Carapace Chestguard",0},{"Scaled Sand Reaver Leggings",200},{"Hive Tunneler's Boots",200},{"Ancient Qiraji Ripper",3500},{"Barb of the Sand Reaver",500},{"Barbed Choker",2500},{"Fetish of the Sand Reaver",200},{"Libram of Grace",2000},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Gauntlets of Kalimdor",200},{"Gauntlets of the Righteous Champion",200},{"Slime-coated Leggings",0},{"Sharpened Silithid Femur",3500},{"Ring of the Qiraji Fury",2500},{"Scarab Brooch",200},{"Idol of Health",2000},{"Qiraji Bindings of Command",2000},{"Qiraji Bindings of Dominance",2000},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Cloak of the Golden Hive",200},{"Hive Defiler Wristguards",2000},{"Gloves of the Messiah",2000},{"Wasphide Gauntlets",2000},{"Ring of the Martyr",2500},{"Huhuran's Stinger",200},{"Qiraji Bindings of Command",2000},{"Qiraji Bindings of Dominance",2000},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Qiraji Execution Bracers",2000},{"Vek'lor's Gloves of Devastation",200},{"Royal Qiraji Belt",200},{"Boots of Epiphany",200},{"Ring of Emperor Vek'lor",200},{"Royal Scepter of Vek'lor",2000},{"Amulet of Vek'nilash",2500},{"Bracelets of Royal Redemption",2000},{"Gloves of the Hidden Temple",200},{"Regenerating Belt of Vek'nilash",200},{"Grasp of the Fallen Emperor",200},{"Belt of the Fallen Emperor",200},{"Kalimdor's Revenge",500},{"Vek'lor's Diadem",2000},{"Vek'Nilash's Circlet",2000},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Don Rigoberto's Lost Hat",2000},{"Burrower Bracers",200},{"The Burrower's Shell",200},{"Jom Gabbar",3000},{"Wormscale Blocker",200},{"Larvae of the Great Worm",2000},{"Ouro's Intact Hide",2000},{"Skin of the Great Sandworm",200},{"Imperial Qiraji Regalia",2000},{"Imperial Qiraji Armaments",3500},{"Mark of C'Thun",200},{"Cloak of Clarity",2500},{"Cloak of the Devoured",2500},{"Eyestalk Waist Cord",2000},{"Grasp of the Old God",2000},{"Belt of Never-ending Agony",2000},{"Dark Storm Gauntlets",2000},{"Gauntlets of Annihilation",2000},{"Ring of the Godslayer",2500},{"Vanquished Tentacle of C'Thun",200},{"Scepter of the False Prophet",3500},{"Death's Sting",3500},{"Dark Edge of Insanity",2000},{"Carapace of the Old God",2000},{"Husk of the Old God",2000},{"Eye of C'Thun",2500},{"Garb of Royal Ascension",0},{"Gloves of the Immortal",200},{"Gloves of the Redeemed Prophecy",200},{"Neretzek, The Blood Drinker",500},{"Anubisath Warhammer",3500},{"Ritssyn's Ring of Chaos",2500},{"Shard of the Fallen Star",200}}
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
    if item_name == query_item_name then
      return item_price
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

  auction_cost = get_item_gp(auction_item_name)
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
    SendChatMessage("iEPGP: "..auction_item_link.." (GP: " .. auction_cost .. ") open for bidding (closing in ".. auction_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
  else
    auction_cost = "N/A"
    SendChatMessage("iEPGP: "..auction_item_link.." open for bidding (closing in ".. auction_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
  end

  C_ChatInfo.SendAddonMessage("iEPGP", ADDON_API_VERSION .. "\t" .. "open\t" .. auction_item_link .. "\t" .. auction_cost .. "\t" .. auction_quantity .. "\t" .. auction_duration, "RAID")

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
