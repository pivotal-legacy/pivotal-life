class Dashing.Calendar extends Dashing.Widget

  ready: =>
    @index = 0
    setInterval(@updateEvent, 15000)

  onData: (data) =>	
    @events = data.events
    @updateEvent()

  updateEvent: =>
    event = @events[@index++ % @events.length] || {title: 'Nothing left to do', body: 'but go drink', where: 'beers in the fridge'}
    diff = moment(event.when_start).diff(moment())
    if diff<0
      event.time = "Ends "+moment(event.when_end).fromNow()
    else
      event.time = moment(event.when_start).calendar()
    @set('Event',event)
