# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
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
  $(".latest").animate({
      backgroundColor: "#abcdef"
  })

notNewAnymore = ->
  $(".latest").animate({
      backgroundColor: "inherit"
  }).removeClass("latest")

updateChatroom = () ->
  chatroom_id = $("#chatroom-id").html()
  msg_id = $("#last-msg-id").html()
  url = '/msgs/fetch.json?msg_id=' + msg_id + '&chatroom_id=' + chatroom_id
  $.getJSON(url, (data) ->
    items = []
    last = msg_id
    $.each(data, (key, val) ->
      email = val.user.email.split("@")[0]
      console.log email
      html = '<dl class="latest"><dt>' + val.message + '</dt><dd class="latest">' + email + '<span class="timestamp">' + val.created_at + '</span></dd></dl>'
      items.push(html)
      console.log items
      if val.id > last
        last = val.id
    )
    $("#messages-list").prepend items.join("")
    $("#last-msg-id").html last
    somethingNew()
  )

sendMessage = () ->
  chatroom_id = $("#chatroom-id").html()
  url = "/chatrooms/" + chatroom_id + "/msgs.js"
  params = $("#new_msg").serialize()
  console.log params
  $.post(url,params,() ->
    $("#msg_message").val("")
    updateChatroom()
  )

$(document).ready ->
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

