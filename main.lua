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
item_prices = {{"Bloodsea Brigand's Vest",2000},{"Soul-Strider Boots",2000},{"Leggings of the Vanquished Champion",2000},{"Leggings of the Vanquished Defender",2000},{"Leggings of the Vanquished Hero",2000},{"Frayed Tether of the Drowned",2500},{"Fathom-Brooch of the Tidewalker",200},{"Sextant of Unstable Currents",1000},{"World Breaker",2000},{"Ranger-General's Chestguard",2000},{"Robe of Hateful Echoes",1000},{"Boots of the Shifting Nightmare",500},{"Band of Vile Aggression",2500},{"Ring of Lethality",2500},{"Brighthelm of Justice",1000},{"Fathomstone",2000},{"Idol of the Crescent Goddess",200},{"Pauldrons of the Wardancer",1000},{"Shoulderpads of the Stranger",2000},{"Living Root of the Wildheart",200},{"Scarab of Displacement",3500},{"Blackfathom Warbands",2000},{"Wraps of Purification",2000},{"Serpent Spine Longbow",5000},{"Krakken-Heart Breastplate",1000},{"Vestments of the Sea-Witch",2000},{"Fang of Vashj",3500},{"Cobra-Lash Boots",2000},{"Coral Band of the Revived",2500},{"Ring of Endless Coils",2500},{"Glorious Gauntlets of Crestfall",2000},{"Helm of the Vanquished Champion",2000},{"Helm of the Vanquished Defender",2000},{"Helm of the Vanquished Hero",2000},{"Lightfathom Scepter",3500},{"Runetotem's Mantle",1000},{"Prism of Inner Calm",200},{"Belt of One-Hundred Deaths",2000},{"Orca-Hide Boots",2000},{"Gloves of the Vanquished Champion",2000},{"Gloves of the Vanquished Defender",2000},{"Gloves of the Vanquished Hero",2000},{"Fang of the Leviathan",3500},{"Girdle of the Invulnerable",2000},{"True-Aim Stalker Bands",1000},{"Tsunami Talisman",3500},{"Coral-Barbed Shoulderpads",1000},{"Razor-Scale Battlecloak",1000},{"Gnarled Chestpiece of the Ancients",200},{"Warboots of Obliteration",2000},{"Band of the Vigilant",1000},{"Ring of Sundered Souls",2500},{"Pendant of the Lost Ages",1000},{"Talon of Azshara",3500},{"Illidari Shoulderpads",200},{"Mantle of the Tireless Tracker",1000},{"Pauldrons of the Argent Sentinel",1000},{"Serpent-Coil Braid",1000},{"Girdle of the Tidal Call",200},{"Luminescent Rod of the Naaru",2000},{"Boots of Courage Unending",2000},{"Pendant of the Perilous",2500},{"Totem of the Maelstrom",200},{"Serpentshrine Shuriken",2000},{"Spyglass of the Hidden Fleet",1000},{"Wildfury Greatstaff",3500},{"Glowing Breastplate of Truth",1000},{"Boots of Effortless Striking",200},{"Tempest-Strider Boots",2000},{"Velvet Boots of the Guardian",2000},{"Ancestral Ring of Conquest",1000},{"The Seal of Danzalar",2500},{"Mallet of the Tides",3500},{"Choker of Animalistic Fury",1000},{"Libram of Absolute Truth",200},{"Earring of Soulful Meditation",1000},{"Cord of Screaming Terrors",1000},{"Bracers of Eradication",2000},{"Grove-Bands of Remulos",2000},{"Mantle of the Elven Kings",2000},{"Fire-Cord of the Magus",2000},{"Bark-Gloves of Ancient Wisdom",1000},{"Bands of the Celestial Archer",1000},{"Girdle of Fallen Stars",2000},{"Seventh Ring of the Tirisfalen",2500},{"Arcanite Steam-Pistol",2000},{"Band of Al'ar",2500},{"Claw of the Phoenix",3500},{"Fire Crest Breastplate",1000},{"Gloves of the Searing Grip",2000},{"Mindstorm Wristbands",2000},{"Netherbane",3500},{"Phoenix-Ring of Rebirth",1000},{"Phoenix-Wing Cloak",2500},{"Talisman of the Sun King",200},{"Talon of Al'ar",3500},{"Talon of the Phoenix",3500},{"Tome of Fiery Redemption",1000},{"Cowl of the Grand Engineer",1000},{"Fel Reaver's Piston",200},{"Fel-Steel Warhelm",1000},{"Girdle of Zaetar",2000},{"Pauldrons of the Vanquished Champion",2000},{"Pauldrons of the Vanquished Defender",2000},{"Pauldrons of the Vanquished Hero",2000},{"Void Reaver Greaves",2000},{"Warp-Spring Coil",3500},{"Wristguards of Determination",2000},{"Boots of the Resilient",2000},{"Ethereum Life-Staff",1000},{"Girdle of the Righteous Path",2000},{"Greaves of the Bloodwarder",2000},{"Heartrazor",1000},{"Solarian's Sapphire",200},{"Star-Soul Breeches",200},{"Star-Strider Boots",2000},{"Trousers of the Astromancer",2000},{"Vambraces of Ending",2000},{"Void Star Talisman",200},{"Wand of the Forgotten Star",2000},{"Worldstorm Gauntlets",2000},{"Band of the Ranger-General",2500},{"Chestguard of the Vanquished Champion",2000},{"Chestguard of the Vanquished Defender",2000},{"Chestguard of the Vanquished Hero",2000},{"Crown of the Sun",200},{"Gauntlets of the Sun King",2000},{"Leggings of Murderous Intent",2000},{"Rod of the Sun King",3500},{"Royal Cloak of the Sunstriders",2500},{"Royal Gauntlets of Silvermoon",2000},{"Sunhawk Leggings",2000},{"Sunshower Light Cloak",2500},{"Thalassian Wildercloak",2500},{"The Nexus Key",3500},{"Twinblade of the Phoenix",5000},{"Verdant Sphere",2500},{"Ashes of Al'ar",0},{"Pattern: Boots of the Long Road",1000},{"Pattern: Boots of Blasting",2000},{"Pattern: Boots of Natural Grace",2000},{"Pattern: Boots of Utter Darkness",2000},{"Pattern: Boots of the Crimson Hawk",200},{"Pattern: Hurricane Boots",1000},{"Plans: Red Havoc Boots",1000},{"Plans: Boots of the Protector",2000},{"Brute Cloak of the Ogre-Magi",200},{"Belt of Divine Inspiration",200},{"Malefic Mask of the Shadows",200},{"Maulgar's Warhelm",200},{"Bladespire Warbands",200},{"Hammer of the Naaru",200},{"Pauldrons of the Fallen Champion",1000},{"Pauldrons of the Fallen Defender",1000},{"Pauldrons of the Fallen Hero",1000},{"Cowl of Nature's Breath",200},{"Gronn-Stitched Girdle",200},{"Gauntlets of the Dragonslayer",200},{"Windshear Boots",200},{"Gauntlets of Martial Perfection",200},{"Teeth of Gruul",200},{"Eye of Gruul",200},{"Dragonspine Trophy",3500},{"Leggings of the Fallen Champion",1000},{"Leggings of the Fallen Defender",1000},{"Leggings of the Fallen Hero",1000},{"Bloodmaw Magus-Blade",2000},{"Axe of the Gronn Lords",200},{"Aldori Legacy Defender",2000},{"Shuriken of Negation",200},{"Collar of Cho'gall",200},{"Cloak of the Pit Stalker",200},{"Soul-Eater's Handwraps",200},{"Liar's Tongue Gloves",200},{"Terror Pit Girdle",200},{"Thundering Greathelm",200},{"Girdle of the Endless Pit",200},{"Eye of Magtheridon",3500},{"Karaborian Talisman",200},{"Glaive of the Pit",200},{"Crystalheart Pulse-Staff",200},{"Aegis of the Vindicator",2000},{"Eredar Wand of Obliteration",1000},{"Chestguard of the Fallen Champion",1000},{"Chestguard of the Fallen Defender",1000},{"Chestguard of the Fallen Hero",1000},{"Magtheridon's Head",2500},{"Pit Lord's Satchel",0}}

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
