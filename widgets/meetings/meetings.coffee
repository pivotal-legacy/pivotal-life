class Dashing.Meetings extends Dashing.Widget

  ready: ->

  onData: (data) ->

  changeRooms: (node, event) ->
    room = $("#roomSelect").attr("value")
    if room != ""
      window.location.replace('?room='+room)
