local epgp = CreateFrame("Frame")
--epgp:RegisterEvent("CHAT_MSG_GUILD")
--epgp:RegisterEvent("CHAT_MSG_WHISPER")
epgp:RegisterEvent("CHAT_MSG_RAID")
epgp:RegisterEvent("CHAT_MSG_RAID_LEADER")
epgp:SetScript("OnEvent", function(self, event, message, sender, ...)
  local message = strtrim(message, " ")
  local command, arguments = strsplit(" ", message, 2)
  command = strlower(command)
  if command == "!bid" then do_bid(arguments, sender)
  elseif command == "!open" then open_bids(arguments, sender)
  elseif command == "!bis" then epgp_unknown_command(arguments, sender)
  elseif command == "!help" then epgp_help_command(arguments, sender)
  -- elseif command == "!close" then close_bids(sender)
  end
end)

function is_lootmaster(name)
  -- This only works if in range of the party/raid member, too limited for general use
  --local lootcaller = strsplit("-", name);
  --local guildName, guildRankName, guildRankIndex = GetGuildInfo(lootcaller);
  --if guildName ~= nil and guildRankIndex <= 1 then

  for i=1,GetNumGuildMembers() do
    guildname,rank,rankIndex=GetGuildRosterInfo(i);
    if guildname==name and rankIndex <= 1 then
      return true;
    end
  end

  return false;
end

function epgp_unknown_command(arguments, player)
  SendChatMessage("iEPGP: Unknown command. Type !bid ms, !bid os, or !bid cancel.", "WHISPER", nil, player)
end

function epgp_help_command(arguments, player)
  SendChatMessage("iEPGP: After bidding has opened (look for the raid warning), type !bid ms (for main spec), !bid os (for off spec), or !bid cancel (to retract bids).", "WHISPER", nil, player)
end

function open_bids(gp_string, player)
  if not is_lootmaster(player) then
    return;
  end

  if bid_item ~= nil then
    SendChatMessage("iEPGP: Bids not opened, close previous item first.", "RAID")
    return;
  end

  gp_item, gp_amount, gp_count, gp_duration = strsplit("--", gp_string)

  local gp_item_name, gp_item_link = GetItemInfo(gp_item)
  if gp_item_name == nil then
    SendChatMessage("iEPGP: Bids not opened, invalid item.", "RAID")
    return;
  end

  gp_amount = tonumber(gp_amount)
  gp_count = tonumber(gp_count)
  gp_duration = tonumber(gp_duration)

  if gp_duration == nil then
    gp_duration = 20
  elseif gp_duration < 15 then
    gp_duration = 15;
  elseif gp_duration > 60 then
    gp_duration = 60;
  end

  if gp_count == nil then
    gp_count = 1;
  end

  bid_item = gp_item_link;

  if gp_amount ~= nil then
    SendChatMessage("iEPGP: "..gp_item_link.." (GP: " .. gp_amount .. ") open for bidding (closing in ".. gp_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
  else
    gp_amount = "N/A"
    SendChatMessage("iEPGP: "..gp_item_link.." open for bidding (closing in ".. gp_duration .. " seconds)! Commands: \"!bid ms\", \"!bid os\"", "RAID_WARNING");
  end

  -- Eventually deprecate this, support particular types of messages
  C_ChatInfo.SendAddonMessage("iEPGP", gp_item_link .. "\t" .. gp_amount .. "\t" .. gp_count .. "\t" .. gp_duration, "RAID")
  -- This should be what needs to be used
  -- C_ChatInfo.SendAddonMessage("iEPGP", "open\t" .. gp_item_link .. "\t" .. gp_amount .. "\t" .. gp_count .. "\t" .. gp_duration, "RAID")

  C_Timer.After(gp_duration - 10, alert4)
  C_Timer.After(gp_duration - 3, alert3)
  C_Timer.After(gp_duration - 2, alert2)
  C_Timer.After(gp_duration - 1, alert1)
  C_Timer.After(gp_duration, close_bids)
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

function close_bids(player)
  if not is_lootmaster(player) or player ~= nil then
    return;
  end

  if bid_item == nil then
    SendChatMessage("iEPGP: Could not close bids, no item is currently open for bidding.", "WHISPER", nil, player)
    return;
  end

  ms_bidders_text = ""
  os_bidders_text = ""
  for i=1,getn(ms_bidders) do
    local name = ms_bidders[i];
    if strlen(ms_bidders_text)>0 then
      ms_bidders_text = ms_bidders_text .. ", " .. name;
    else
      ms_bidders_text = name;
    end
  end

  for i=1,getn(os_bidders) do
    local name = os_bidders[i];
    if strlen(os_bidders_text)>0 then
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

function do_bid(spec, gpPlayer)
  -- can_bid
  if bid_item == nil then
    SendChatMessage("iEPGP: No item is currently open for bidding.", "WHISPER", nil, gpPlayer)
    return;
  end

  spec = strlower(spec);
  gpPlayer = strsplit("-", gpPlayer);

  if spec == "ms" or spec == "main" then
    SendChatMessage("iEPGP: Main spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
    tinsert(ms_bidders, gpPlayer)
  elseif spec == "os" or spec == "off" or spec == "offspec" then
    SendChatMessage("iEPGP: Off spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
    tinsert(os_bidders, gpPlayer)
  elseif spec == "cancel" then
    if tContains(ms_bidders, gpPlayer) then
      for i=1,getn(ms_bidders) do
        if ms_bidders[i] == gpPlayer then
          tremove(ms_bidders, i)
          SendChatMessage("iEPGP: Your bid has successfully been withdrawn.", "WHISPER", nil, gpPlayer)
          break
        end
      end
    elseif tContains(os_bidders, gpPlayer) then
      for i=1,getn(os_bidders) do
        if os_bidders[i] == gpPlayer then
          tremove(os_bidders, i)
          SendChatMessage("iEPGP: Your bid has successfully been withdrawn.", "WHISPER", nil, gpPlayer)
          break
        end
      end
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
