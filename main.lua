DEFAULT_AUCTION_DURATION = 20;
MIN_AUCTION_DURATION = 15;
MAX_AUCTION_DURATION = 60;
DEFAULT_LOOT_CONTROLLER_RANK = 1; -- Top two ranks. 0=GM, 1=Officer etc

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

  if bid_item ~= nil then
    SendChatMessage("iEPGP: Bids not opened, close previous item first.", "RAID");
    return;
  end

  local auction_item, auction_cost, auction_quantity, auction_duration = strsplit("--", gp_string);

  local auction_item_name, auction_item_link = GetItemInfo(auction_item);
  if auction_item_name == nil then
    SendChatMessage("iEPGP: Bids not opened, invalid item.", "RAID");
    return;
  end

  auction_cost = tonumber(auction_cost);
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

  -- Eventually deprecate this, support particular types of messages
  C_ChatInfo.SendAddonMessage("iEPGP", auction_item_link .. "\t" .. auction_cost .. "\t" .. auction_quantity .. "\t" .. auction_duration, "RAID")
  -- This should be what needs to be used
  -- C_ChatInfo.SendAddonMessage("iEPGP", "open\t" .. auction_item_link .. "\t" .. auction_cost .. "\t" .. auction_quantity .. "\t" .. auction_duration, "RAID")

  iepgp_a4 = C_Timer.NewTimer(auction_duration - 10, alert4)
  iepgp_a3 = C_Timer.NewTimer(auction_duration - 3, alert3)
  iepgp_a2 = C_Timer.NewTimer(auction_duration - 2, alert2)
  iepgp_a1 = C_Timer.NewTimer(auction_duration - 1, alert1)
  iepgp_a0 = C_Timer.NewTimer(auction_duration, end_bids)
end

function alert4()
  SendChatMessage("iEPGP: "..bid_item.." bids closing in 10 seconds!", "RAID_WARNING");
end

function alert3()
  SendChatMessage("iEPGP: Closing in 3", "RAID");
end

function alert2()
  SendChatMessage("iEPGP: Closing in 2", "RAID");
end

function alert1()
  SendChatMessage("iEPGP: Closing in 1", "RAID");
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

  -- C_ChatInfo.SendAddonMessage("iEPGP", "close\t", "RAID")
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
      SendChatMessage("iEPGP: Main spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
      tinsert(ms_bidders, gpPlayer)
    end
  elseif spec == "os" or spec == "off" or spec == "offspec" then
    if tContains(os_bidders, gpPlayer) then
      SendChatMessage("iEPGP: You've already bid off spec on "..bid_item..".", "WHISPER", nil, gpPlayer)
    else
      SendChatMessage("iEPGP: Off spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
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

bid_item = nil;
ms_bidders = {};
os_bidders = {};
