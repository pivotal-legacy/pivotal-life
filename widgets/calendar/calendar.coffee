class Dashing.Calendar extends Dashing.Widget

  ready: =>
    if !@pre? then @set('pre',0)
    setInterval(@updateTime, 5000+(1000*@pre))

  onData: (data) =>	
    @events = data.events
    @updateEvent()

  updateEvent: =>
    event = @events[@pre]
    @updateContent(event)
    @updateTime()

  updateContent: (event) =>
    @setBackgroundClassBy event.calendar
    @set('event',event)

  updateTime: =>
    if @event?
      event = @event
      diff = moment(event.when_start).diff(moment())
      if diff<0
        event.time = "Ends "+moment(event.when_end).fromNow()
      else
        event.time = moment(event.when_start).calendar()

      @unset('event')
      @set('event',event)

  setBackgroundClassBy: (name) =>
    @removeBackgroundClass()
    $(@node).addClass "calendar-name-#{name.toLowerCase()}"

  removeBackgroundClass: =>
    classNames = $(@node).attr("class").split " "

    for className in classNames
      match = /calendar-name-(.*)/.exec className
      $(@node).removeClass match[0] if match
