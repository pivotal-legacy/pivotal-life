class Dashing.Traffic extends Dashing.Widget

  ready: ->
    @set('url', 'http://mapquest.com/embed?hk=1boLXro')
    setTimeout =>
      $(@node).hide()
      $(@node).show()
      $(@node).css('height', '99%')
      $(@node).css('height', '100%')
    , 5000

  onData: (data) ->
