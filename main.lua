function checkPR(command, player)
  --SendChatMessage("PR unknown. You were not found in the guild database.", "WHISPER", nil, player)
  C_ChatInfo.SendAddonMessage("EPGPIntensity",
  "PR unknown. You were not found in the guild database.",
  "WHISPER", player)
end

local epgp = CreateFrame("Frame")
--epgp:RegisterEvent("CHAT_MSG_GUILD")
--epgp:RegisterEvent("CHAT_MSG_WHISPER")
epgp:RegisterEvent("CHAT_MSG_RAID")
epgp:RegisterEvent("CHAT_MSG_RAID_LEADER")
epgp:SetScript("OnEvent", function(self, event, message, sender, ...)
  message = strtrim(message, " ")
  command, arguments = strsplit(" ", message, 2)
  if command == "!bid" then do_bid(arguments, sender)
  elseif command == "!open" then open_bids(arguments, sender)
  elseif command == "!close" then close_bids(sender)
  end
end)

function is_lootmaster(name)
  if name == "Gracious-Arugal" or name == "Victorious-Arugal" then
    return true;
  end
  return false;
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
  SendChatMessage(item..": EPGP bids (No price)", "RAID_WARNING");
end

function close_bids(player)
  print("In close")
  if not is_lootmaster(player) then
    return;
  end

  if bid_item == nil then
    SendChatMessage("IntensityEPGP: Could not close bids, no item is currently open for bidding.", "WHISPER", nil, player)
    return;
  end

  -- Winner?

  SendChatMessage("IntensityEPGP: Bids closed for "..bid_item, "RAID")
  bid_item = nil;
  ms_bidders = {};
  os_bidders = {};
end

function do_bid(spec, player)
  -- can_bid
  if bid_item == nil then
    SendChatMessage("IntensityEPGP: No item is currently open for bidding.", "WHISPER", nil, player)
    return;
  end

  if spec == "ms" or spec == "main" then
    SendChatMessage("IntensityEPGP: Main spec bid accepted for "..bid_item..".", "WHISPER", nil, player)
    tinsert(ms_bidders, player)
  elseif spec == "os" or spec == "off" or spec == "offspec" then
    SendChatMessage("IntensityEPGP: Off spec bid accepted for "..bid_item..".", "WHISPER", nil, player)
    tinsert(os_bidders, player)
  else
    SendChatMessage("IntensityEPGP: Bid not accepted for "..bid_item..". Please specify spec, e.g `!bid ms` or `!bid os`.", "WHISPER", nil, player)
    return;
  end
end

function get_cdb_player(name)
  for i=1,getn(players_cdb) do
    if players_cdb[i].name==name then
      return players_cdb[i];
    end
  end
  return nil
end

function sum_earned(player)
  player = get_cdb_player(player)
  if player==nil then
    print("Player doesn't exist in database.")  
    return -1;
  end

  amount = 0;
  for i=1,getn(player.events) do
    amount = amount + player.events[i].amount
  end
  return amount;
end

function sum_spent(player)
  amount = 0;
  for i=1,getn(loot_history) do
    if loot_history[i].player == player then
      amount = amount + loot_history[i].currency_spent;
    end
  end
  return amount;
end

function award_raid(desc, team_name, currency_earned)
  description = desc;
  team = team_name;
  timestamp = time();
  amount = currency_earned;
  raiders = {}

  for i=1,GetNumGroupMembers() do
    name,a,a,a,class=GetRaidRosterInfo(i);
    tinsert(raiders, {
      name=name,
      class=class
    })
  end

  if getn(raiders) == 0 then
    print("Error: You are not in a raid group nor party.")
    return;
  end

  recipients = "";

  for i=1,getn(raiders) do
    player = get_cdb_player(raiders[i].name)
    
    if player==nil then
      print("Adding new player (".. raiders[i].name ..") to database")
      tinsert(players_cdb, {
        name=raiders[i].name,
        class=raiders[i].class,
        guild="Intensity", -- Placeholder
        events={{
          amount=amount,
          timestamp=timestamp,
          team=team,
          description=description
        }}
      })
    else
      tinsert(player.events, {
        amount=amount,
        timestamp=timestamp,
        team=team,
        description=description
      })
    end
    recipients = recipients .. " " .. raiders[i].name;
  end
  print("Awarded " .. amount .. " EP to:" .. recipients);
end

function create_player(player_name, class, guild)
  player = {
    name=player_name,
    class=class,
    guild=guild, -- Placeholder
    events={}
  };
  tinsert(players_cdb, player)
  print("Created player " .. player_name .. ".");

  return
end

function award_player(player_name, amount, team, description)
  player = get_cdb_player(player_name)
    
  if player==nil then
    -- print("Player doesn't exist in database. Use create_cdb_player() first.")
    -- return;
    create_player(player_name, "Unknown", "Intensity") -- Placeholder
  end

  timestamp = time();

  tinsert(player.events, {
    amount=amount,
    timestamp=timestamp,
    team=team,
    description=description
  })

  print("Awarded " .. amount .. " EP to: " .. player_name .. " (" .. description .. ")");
end

function award_players(recipients, amount, team, description)
  for i=1,getn(recipients) do
    award_player(recipients[i], amount, team, description)
  end
end

function award_item(player, item_name, cost, team_name)
  team = team_name;
  timestamp = time();
  location = GetRealZoneText();
  item_name = item_name;
  currency_spent = cost;
  player=player;

  tinsert(loot_history, {
    currency_spent=currency_spent,
    player=player,
    timestamp=timestamp,
    team=team,
    item_name=item_name,
    location=location
  })

  print("Awarded " .. item_name .. " to " .. player .. " for " .. cost .. ".");
end

function apply_decay(amount)
  total_members = 0;
  for i=1,getn(players_cdb) do
    earned = sum_earned(players_cdb[i].name)
    spent = sum_spent(players_cdb[i].name)
    decay_earned = earned * (1-amount);
    decay_spent = spent * (1-amount);
    
    decayed_earn = earned - decay_earned;
    decayed_spent = spent - decay_spent;

    award_player(players_cdb[i].name, -decayed_earn, "No Team", "Decay");
    award_item(players_cdb[i].name, "Decay", -decayed_spent, "No Team", "Decay")

    total_members = total_members + 1;
  end
  print("Applied ".. amount .. " decay to " .. total_members .. " in database.")
end

function player_summary(player_name)
  player = get_cdb_player(player_name)
    
  if player==nil then
    print("Player doesn't exist in database.")
    return;
  end

  earned = sum_earned(player.name);
  spent = sum_spent(player.name)
  pr = earned/spent;

  print("(" .. player.name .. ") - EP/Earned: "
      .. earned .. ". GP/Spent: " 
      .. spent .. ". PR: " .. pr)
  --print(" - Last 12 entries: ")
  --print(" - Last 5 pieces of gear: ")
end

players_cdb = {}
loot_history = {}

bid_item = nil;
ms_bidders = {};
os_bidders = {};


-- (DONE) award_raid - team, description, amount
-- (DONE) sum_spent
-- (DONE) sum_earned
-- (DONE) award_item - player, item_name, cost, team_name
-- (DONE) award_players - recipients, amount, team, description
-- (DONE) award_player - player_name, amount, team, description
-- (DONE) decay
-- (DONE-ish) summary

-- export
-- import

-- (Started) bid system