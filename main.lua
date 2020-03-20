local epgp = CreateFrame("Frame")
--epgp:RegisterEvent("CHAT_MSG_GUILD")
--epgp:RegisterEvent("CHAT_MSG_WHISPER")
epgp:RegisterEvent("CHAT_MSG_RAID")
epgp:RegisterEvent("CHAT_MSG_RAID_LEADER")
epgp:SetScript("OnEvent", function(self, event, message, sender, ...)
  message = strtrim(message, " ")
  command, arguments = strsplit(" ", message, 2)
  command = strlower(command)
  if command == "!bid" then do_bid(arguments, sender)
  elseif command == "!open" then open_bids(arguments, sender)
  elseif command == "!bis" then epgp_unknown_command(arguments, sender)
  elseif command == "!help" then epgp_help_command(arguments, sender)
  elseif command == "!close" then close_bids(sender)
  end
end)

function is_lootmaster(name)
  if name == "Exzaw-Arugal" or name == "Victorious-Arugal" or name == "Gracious-Arugal" then
    return true;
  end
  return false;
end

function epgp_unknown_command(arguments, player)
  SendChatMessage("IntensityEPGP: Unknown command. Type !bid ms, !bid os, or !bid cancel.", "WHISPER", nil, player)
end

function epgp_help_command(arguments, player)
  SendChatMessage("IntensityEPGP: After bidding has opened (look for the raid warning), type !bid ms (for main spec), !bid os (for off spec), or !bid cancel (to retract bids).", "WHISPER", nil, player)
end

function open_bids(item, player)
  if not is_lootmaster(player) then
    return;
  end

  if bid_item ~= nil then
    SendChatMessage("IntensityEPGP: Bids not opened, close previous item first.", "RAID")
    return;
  end

  itemname = GetItemInfo(item)
  if itemname == nil then
    SendChatMessage("IntensityEPGP: Bids not opened, invalid item.", "RAID")
    return;
  end

  bid_item = item;
  SendChatMessage("IntensityEPGP: "..item.." open for bidding! Type !bid ms (for main spec) or !bid os (for off spec)", "RAID_WARNING");
end

function close_bids(player)
  if not is_lootmaster(player) then
    return;
  end

  if bid_item == nil then
    SendChatMessage("IntensityEPGP: Could not close bids, no item is currently open for bidding.", "WHISPER", nil, player)
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

  print('Main spec bidders')
  print(ms_bidders_text)
  print('Off spec bidders')
  print(os_bidders_text)

  if (ms_bidders_text ~= "") then
    SendChatMessage("IntensityEPGP: MS bids for "..bid_item..": "..ms_bidders_text, "RAID");
  elseif (os_bidders_text ~= "") then
    SendChatMessage("IntensityEPGP: OS bids for "..bid_item..": "..os_bidders_text, "RAID");
  else
    SendChatMessage("IntensityEPGP: No bids for "..bid_item..".", "RAID");
  end

  SendChatMessage("IntensityEPGP: Bids closed for "..bid_item, "RAID")
  bid_item = nil;
  ms_bidders = {};
  os_bidders = {};
end

function do_bid(spec, gpPlayer)
  -- can_bid
  if bid_item == nil then
    SendChatMessage("IntensityEPGP: No item is currently open for bidding.", "WHISPER", nil, gpPlayer)
    return;
  end

  spec = strlower(spec);
  gpPlayer = strsplit("-", gpPlayer);

  if spec == "ms" or spec == "main" then
    SendChatMessage("IntensityEPGP: Main spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
    tinsert(ms_bidders, gpPlayer)
  elseif spec == "os" or spec == "off" or spec == "offspec" then
    SendChatMessage("IntensityEPGP: Off spec bid accepted for "..bid_item..".", "WHISPER", nil, gpPlayer)
    tinsert(os_bidders, gpPlayer)
  elseif spec == "cancel" then
    if tContains(ms_bidders, gpPlayer) then
      for i=1,getn(ms_bidders) do
        if ms_bidders[i] == gpPlayer then
          tremove(ms_bidders, i)
          SendChatMessage("IntensityEPGP: Your bid has successfully been withdrawn.", "WHISPER", nil, gpPlayer)
          break
        end
      end
    elseif tContains(os_bidders, gpPlayer) then
      for i=1,getn(os_bidders) do
        if os_bidders[i] == gpPlayer then
          tremove(os_bidders, i)
          SendChatMessage("IntensityEPGP: Your bid has successfully been withdrawn.", "WHISPER", nil, gpPlayer)
          break
        end
      end
    else
      SendChatMessage("IntensityEPGP: You do not appear to have a bid active on the current item.", "WHISPER", nil, gpPlayer)
    end
  else
    SendChatMessage("IntensityEPGP: Bid not accepted for "..bid_item..". Please specify spec, e.g `!bid ms` or `!bid os`.", "WHISPER", nil, gpPlayer)
    return;
  end
end

bid_item = nil;
ms_bidders = {};
os_bidders = {};
