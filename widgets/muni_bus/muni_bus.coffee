class Dashing.MuniBus extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    @set('data', data.data)
    stops = for stop, ignore of data.data
      stop
    @set('stop', stops.sort())
