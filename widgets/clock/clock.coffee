class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@showTime, 500)

  showTime: =>
    today = new Date()
    @set('time', today.toLocaleTimeString())
    @set('date', today.toDateString())
