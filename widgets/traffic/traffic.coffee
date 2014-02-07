class Dashing.Traffic extends Dashing.Widget

  ready: ->
    @set('url', 'http://mapquest.com/embed?hk=1boLXro')

  onData: (data) ->
