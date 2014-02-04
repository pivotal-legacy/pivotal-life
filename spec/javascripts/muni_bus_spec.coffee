describe("MUNI Bus", =>
  muniBus = undefined
  beforeEach(=>
    muniBus = new Dashing.MuniBus()
  )
  it("sorts the data by Stop names", =>
    setDataOnWidget(muniBus, data: {
      "c": {b: 46}
      "a": {z: 1},
      "b": {x: 7}
    })
    expect(muniBus.get("stop")).toEqual(["a", "b", "c"])
  )
)
