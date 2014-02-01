describe("new faces", =>
  newFaces = undefined
  pivot1 = undefined
  pivot2 = undefined

  beforeEach(=>
    spyOn(window, "setInterval")

    newFaces = new Dashing.NewFaces()
    newFaces.ready()
    pivot1 = {photo_url: '/abc/xyz', first_name: "Joe", last_name: "Pivot"}
    pivot2 = {photo_url: '/abc/xxz', first_name: "Jane", last_name: "Pivot"}
    setDataOnWidget(newFaces, {new_faces: [ pivot1, pivot2 ]})
  )

  it("rotates", =>
    expect(window.setInterval).toHaveBeenCalled()
    expect(window.setInterval.calls.mostRecent().args[1]).toBe(30000)

    rotateFunction = window.setInterval.calls.mostRecent().args[0]

    expect(newFaces.get("item")).toEqual(pivot1)
    rotateFunction.call()
    expect(newFaces.get("item")).toEqual(pivot2)
    rotateFunction.call()
    expect(newFaces.get("item")).toEqual(pivot1)
    rotateFunction.call()
    expect(newFaces.get("item")).toEqual(pivot2)
  )
)
