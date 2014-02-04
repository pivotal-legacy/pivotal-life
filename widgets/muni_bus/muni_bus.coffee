class Dashing.MuniBus extends Dashing.Widget

  ready: ->
    $('.stops').isotope({
      itemSelector : '.stop'
      masonryHorizontal: {
        rowHeight: 290
      }
      sortBy: 'name', sortAscending: true
      getSortData: {
        name: ($elem) =>
          $elem.find('caption').text()
      }
    });

  onData: (data) ->
    @set('data', data.data)
