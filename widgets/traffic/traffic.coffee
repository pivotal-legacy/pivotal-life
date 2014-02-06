class Dashing.Traffic extends Dashing.Widget

  ready: ->
    @set('url', 'http://mapquest.com/embed?hk=1boLXro')
    setTimeout ->
      console.log('refresh')
      $(@).hide()
      $(@).show()
    , 3000

  onData: (data) ->
