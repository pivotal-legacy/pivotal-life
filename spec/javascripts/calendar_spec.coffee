describe("Calendar widget", =>
  calendar = undefined
  event1 = undefined
  event2 = undefined

  beforeEach(=>
    spyOn(window, "setInterval")

    calendar = new Dashing.Calendar()
    calendar.ready()
    event1 = {photo_url: '/abc/xyz', first_name: "Joe", last_name: "Pivot"}
    event2 = {photo_url: '/abc/xxz', first_name: "Jane", last_name: "Pivot"}
    setDataOnWidget(calendar, {events: [ event1, event2 ]})
  )

  it("rotates events", =>
    expect(window.setInterval).toHaveBeenCalled()
    expect(window.setInterval.calls.mostRecent().args[1]).toBe(15000)

    rotateFunction = window.setInterval.calls.mostRecent().args[0]

    expect(calendar.get("Event")).toEqual(event1)
    rotateFunction.call()
    expect(calendar.get("Event")).toEqual(event2)
    rotateFunction.call()
    expect(calendar.get("Event")).toEqual(event1)
    rotateFunction.call()
    expect(calendar.get("Event")).toEqual(event2)
  )
)
