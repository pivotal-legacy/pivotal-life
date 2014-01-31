describe("MUNI Powell widget", =>
  muniPowell = undefined

  beforeEach(=>
    muniPowell = new Dashing.MuniPowell()
    muniPowell.ready()
    data = {
      inbound: {
        J: [2, 24, 31],
        L: [2, 5, 17],
        M: [3, 37],
        N: [4, 52, 63]
      },
      outbound: {
        J: [6, 11, 33],
        K: [7, 18],
        L: [2, 6, 8],
        M: [5, 11, 13],
      }
    }
    setDataOnWidget(muniPowell, {data: data})
  )

  it("collates inbound and outbound times by Route/Line", =>
    expect(muniPowell.trains).toEqual({
      J: {inbound: [2, 24, 31], outbound: [6, 11, 33]},
      K: {inbound: [], outbound: [7, 18]},
      L: {inbound: [2, 5, 17], outbound: [2, 6, 8]},
      M: {inbound: [3, 37], outbound: [5, 11, 13]},
      N: {inbound: [4, 52, 63], outbound: []},
    })
  )
)
