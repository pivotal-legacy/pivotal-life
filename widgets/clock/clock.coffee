class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@showTime, 500)

  showTime: =>
    now = moment()
    @set('time', now.format('h:mm A');)
    @set('date', now.format('ddd MMM D, YYYY');)
