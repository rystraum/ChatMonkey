# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

last_request = ""

getDateString = (date) ->
  # 2011-11-07 09:38:39
  date.getFullYear() + "-" + add0(date.getMonth()) + "-" + add0(date.getDate())

getTimeString = (date) ->
  add0(date.getHours()) + ":" + add0(date.getMinutes()) + ":" + add0(date.getSeconds())

add0 = (string) ->
  if parseInt(string,10) < 10
    string = "0" + string
  else
    string

getDateObjectString = (date) ->
  getDateString(date) + " " + getTimeString(date)

somethingNew = ->
  if ($(".latest").size() > 0)
    document.title = "Chat: " + $(".latest").size() + " unread"
    $(".latest").each( (index) ->
      $(this).data('cssBG',$(this).css('background-color')) if !($(this).data('cssBG'))
      $(this).stop().animate({
          backgroundColor: "#80D080"
      })
    )
  else
    console.log "no new messages"


notNewAnymore = ->
  $(".latest").each( (index) ->
    bgc = $(this).data('cssBG')
    $(this).stop().animate({
        backgroundColor: bgc
    }).removeClass("latest")
  )
  document.title = "Chat"

updateChatroom = () ->
  chatroom_id = $("#chatroom-id").html()
  msg_id = $("#last-msg-id").html()
  user_email = $("#current-user").html()
  url = '/msgs/fetch.json?msg_id=' + msg_id + '&chatroom_id=' + chatroom_id
  $.getJSON(url, (data) ->
    items = []
    last = msg_id
    $.each(data, (key, val) ->
      whose = (email) -> if email == val.user.email then return 'mine' else return 'other'
      who = -> if val.user.display_name? then return val.user.display_name else return val.user.email.split("@")[0]
      email = '<span class="who">' + who() + ': </span>'
      time = '<dd class="when"><abbr class="timeago" title="' + val.created_at_in_iso + '">' + val.created_at_in_local + '</abbr></dd>'
      m = '<dl class="latest msg"><dt class="what">' + email + val.message + '</dt>' + time + '</dl>'
      html = '<div class='+whose(user_email)+'>'+m+'</div>'
      items.push(html)
      if val.id > last
        last = val.id
    )
    $("#messages-list").prepend items.join("")
    $("#last-msg-id").html last
    $("abbr.timeago",$("#messages-list")).timeago()
    somethingNew()
  )

sendMessage = () ->
  chatroom_id = $("#chatroom-id").html()
  url = "/chatrooms/" + chatroom_id + "/msgs.js"
  params = $("#new_msg").serialize()
  $.post(url,params,() ->
    $("#msg_message").val("")
    updateChatroom()
  )

isEmpty = ( inputStr ) ->
  if ( null == inputStr || "" == inputStr )
    return true
  else
    return false

$(document).ready ->

  if(not isEmpty($("#last-msg-id").html()) and not isEmpty($("#messages-list").html()))
    setInterval(updateChatroom, 10000)

  $("#msg_message").autoResize()
  $("#msg_message").keypress (event) ->
    notNewAnymore()
    if event.ctrlKey and (event.keyCode == 13 or event.keyCode == 10)
      $("#send-message").click()

  $("#send-message").click( (event) ->
    event.preventDefault()
    sendMessage()
  )

