class Dashing.Calendar extends Dashing.Widget

  ready: =>
    @index = 0
    setInterval(@updateEvent, 15000)

  onData: (data) =>	
    @events = data.events
    @updateEvent()

  defaultEvent: {title: 'Nothing left to do', body: 'but go drink', where: 'beers in the fridge'}
  updateEvent: =>
    event = @events[@index++ % @events.length] || @defaultEvent
    diff = moment(event.when_start_raw*1000).diff(moment())
    if diff<0
      event.time = "Ends "+moment(event.when_end_raw*1000).fromNow()
    else
      event.time = moment(event.when_start_raw*1000).calendar()
    @set('Event',event)
    if (event == @defaultEvent)
      setTimeout(@updateEvent, 100)
