# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showOnlineList = ->
  $('#new-form').html("<%= j (render 'new') %>");
  $('#new-form').slideDown(350);

