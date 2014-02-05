window.Util =
  updatedAtShortTime: ->
    if updatedAt = @get('updatedAt')
      timestamp = new Date(updatedAt * 1000)
      updatedTime = moment(timestamp);
      "Last updated at #{updatedTime.format('h:mm A')}"
