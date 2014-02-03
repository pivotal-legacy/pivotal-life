class Dashing.MuniBus extends Dashing.Widget

  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    console.log(data)
    @set('data', data.data)
