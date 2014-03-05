describe("Clock widget", =>
  clock_widget = undefined

  beforeEach(=>
    clock_widget = new Dashing.Clock()
    jasmine.clock().install()
    clock_widget.ready()
  )

  afterEach(=>
    jasmine.clock().uninstall()
  )

  it("displays the time for a different office every 8 seconds", =>
    jasmine.clock().tick(8000)

    expect(clock_widget.get('date')).toEqual(moment().format("ddd MMM D, YYYY"))
    expect(clock_widget.get('time')).toEqual(moment.tz(new Date(), "America/Toronto").format("h:mm A"))
    expect(clock_widget.get('city')).toEqual("New York")

    jasmine.clock().tick(8000)

    expect(clock_widget.get('date')).toEqual(moment().format("ddd MMM D, YYYY"))
    expect(clock_widget.get('time')).toEqual(moment.tz(new Date(), "America/Los_Angeles").format("h:mm A"))
    expect(clock_widget.get('city')).toEqual("Los Angeles")
  )
)
