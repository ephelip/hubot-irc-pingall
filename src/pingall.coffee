# Description:
#   Ping users from an irc channel
#
# Commands:
#   hubot pingall <message> - ping all users on the channel with the optional message
#   hubot add pingall cron <crontab pattern> <"message"> - add a cron job to ping all users on the channel with message
#
# Author:
#   ephelip
#   sebastien.bourdelin@savoirfairelinux.com

util = require 'util'
HubotCron = require 'hubot-cronjob'

module.exports = (robot) ->
    robot.respond /pingall/i, (context) ->
        room = context.message.room

        users = Object.keys context.robot.adapter.bot.chans[room].users
        usersStr = users.toString()

        message = context.message.text
        message = message.replace robot.name + ' pingall', ""
        context.send '[' + usersStr + ']' + " " + message


module.exports = (robot) ->
    robot.respond /add pingall cron (.*) "(.*?)" *$/i, (context) ->
        room = context.message.room

        users = Object.keys context.robot.adapter.bot.chans[room].users
        usersStr = users.toString()

        # format cronjob
        timezone = 'America/Montreal'
        pattern = context.match[1]
        message = context.match[2]

        pingallCron = () ->
            context.send '[' + usersStr + ']' + " " + message
        
        try
            new HubotCron pattern, timezone, pingallCron
            context.send "New pingall cron added"
        catch error
            context.send "Error caught parsing crontab pattern: #{error}. See http://crontab.org/ for the syntax"
