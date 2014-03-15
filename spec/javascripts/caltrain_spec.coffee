describe("Caltrain widget", =>

  it("shows NB and SB trains in separate columns", =>
    caltrain = new Dashing.Caltrain()
    caltrain.ready()
    data = [
        { route: "LOCAL", minutes: 5, direction: "NB" },
        { route: "BULLET", minutes: 57, direction: "SB" },
        { route: "LIMITED", minutes: 31, direction: "SB" },
        { route: "BULLET", minutes: 17, direction: "NB" }
    ]
    setDataOnWidget(caltrain, {data: data})
    expect(caltrain.departures).toEqual(
      NB: [
        { route: "LOCAL", minutes: 5, direction: "NB" },
        { route: "BULLET", minutes: 17, direction: "NB" }
      ],
      SB: [
        { route: "LIMITED", minutes: 31, direction: "SB" },
        { route: "BULLET", minutes: 57, direction: "SB" }
      ]
    )
  )
)
