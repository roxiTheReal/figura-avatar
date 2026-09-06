function events.chat_receive_message(m, j)
  --m is what we want here, because j is the JSON and thats useless in this case
  local sender = m:match("^<([A-Za-z0-9]+).>.junix, meow") or m:match("^<([A-Za-z0-9]+).>.junixai, meow")
  if sender then
    -- make sure theres a sender, then whisper a message back to the sender. its a simple string, so you can put whatever you want in there
    silly:cat()
  end
end 