describe("new faces", =>
  pivotFaces = undefined
  pivot1 = undefined
  pivot2 = undefined
  pivot3 = undefined
  pivot4 = undefined

  beforeEach(=>
    spyOn(window, "setInterval")

    pivotFaces = new Dashing.PivotFaces()
    pivotFaces.ready()
    pivot1 = {photo_url: '/abc/xyz', first_name: "Joe", last_name: "Pivot"}
    pivot2 = {photo_url: '/abc/xxz', first_name: "Jane", last_name: "Pivot"}
    pivot3 = {photo_url: '/abc/xyz', first_name: "Bob", last_name: "Pivot"}
    pivot4 = {photo_url: '/abc/xxz', first_name: "Mary", last_name: "Pivot"}
    setDataOnWidget(pivotFaces, {new_faces: [ pivot1, pivot2 ], random_faces: [ pivot3, pivot4 ]})
  )

  it("rotates", =>
    expect(window.setInterval).toHaveBeenCalled()
    expect(window.setInterval.calls.mostRecent().args[1]).toBe(30000)

    rotateFunction = window.setInterval.calls.mostRecent().args[0]

    expect(pivotFaces.get("item")).toEqual(pivot1)
    rotateFunction.call()
    expect(pivotFaces.get("item")).toEqual(pivot3)
    rotateFunction.call()
    expect(pivotFaces.get("item")).toEqual(pivot2)
    rotateFunction.call()
    expect(pivotFaces.get("item")).toEqual(pivot4)
  )
)
