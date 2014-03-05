class Dashing.Clock extends Dashing.Widget

  ready: =>
    setInterval(@rotateTime, 8000)
    @currentCity = -1
    @cities = [{ "New York": "America/Toronto" }
    { "Los Angeles": "America/Los_Angeles" }
    { Boston: "America/Toronto" }
    { "San Francisco": "America/Los_Angeles" }
    { Toronto: "America/Toronto" }
    { London: "Europe/London" }
    { Chicago: "America/Chicago" }
    { Boulder: "America/Phoenix" }
    { Denver: "America/Phoenix" }
    { "Palo Alto": "America/Los_Angeles" }
    ]

  rotateTime: =>
    @currentCity = ((@currentCity+1) % @cities.length)
    currentCityName = Object.keys(@cities[@currentCity])[0]
    @set('date', moment().format("ddd MMM D, YYYY"))
    @set('time', moment.tz(new Date(), @cities[@currentCity][currentCityName]).format("h:mm A"))
    @set('city', currentCityName)
