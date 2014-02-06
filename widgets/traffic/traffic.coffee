class Dashing.Traffic extends Dashing.Widget

  ready: ->
    @set('url', 'http://mapquest.com/embed?hk=1boLXro')
    setTimeout ->
      $(@).hide()
      $(@).show()
      $(@).css('height', '99%')
      $(@).css('height', '100%')
    , 10000

  onData: (data) ->
