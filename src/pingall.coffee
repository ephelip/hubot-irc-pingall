# Description:
#   Ping users from an irc channel
#
# Commands:
#   hubot pingall <message> - ping all users on the channel with the optional message
#
# Author:
#   ephelip

util = require 'util'

module.exports = (robot) ->
    robot.respond /pingall/i, (context) ->
        room = context.message.room

        users = Object.keys context.robot.adapter.bot.chans[room].users
        usersStr = users.toString()

        message = context.message.text
        message = message.replace 'nono pingall ', ""
        context.send '[' + usersStr + ']' + " " + message
