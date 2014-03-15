class Dashing.Caltrain extends Dashing.Widget
  ready: =>
  onData: (snapshot) =>
    departures = {}
    for departure in snapshot.data
      departures[departure.direction] ||= []
      departures[departure.direction].push(departure)
      #departures[departure.direction] =
      departures[departure.direction].sort((left,right) ->
        left.minutes - right.minutes
      )
    this.set("departures", departures)
