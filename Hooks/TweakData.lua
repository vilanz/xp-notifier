Hooks:Add("ChatManagerOnSendMessage", "ChatManagerOnSendMessage_testing_stuff", function (channel, senderId, message)
    if (message == "ping") then
        managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", "pong!")
    end
end)
