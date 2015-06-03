$(document).ajaxComplete (event, request) ->
  msg= null
  $('#flash_hook').empty()
  msg = request.getResponseHeader("X-Message")

  alert_type = 'alert-success'
  if msg != null
    $('#flash_hook').html( '<div class= "alert alert-success" id="java_alert">' + msg + '</div>')

   
  $('#java_alert').fadeTo(2000, 1000).slideUp 1000, ->
  return

 