class Dashing.GoTrainStatus extends Dashing.Widget

  ready: ->
    @el = $(@node).find('.go-train-status')

  onData: (data) ->
    @renderTable(data)

  renderTable: (data) =>
    status = @get('statusTable')
    @el.html(status)
