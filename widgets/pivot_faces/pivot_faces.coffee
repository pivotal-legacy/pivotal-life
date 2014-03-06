class Dashing.PivotFaces extends Dashing.Widget

  ready: =>
    @randomOrNewPivot = 1
    @currentNewFaceIdx = 0
    @currentRandomFaceIdx = -1
    setInterval(@rotate, 30000)


  onData: (data) =>
    @set('item', data.new_faces[0])

  rotate: =>
    if (@randomOrNewPivot % 2 == 0) then @swapNewFace() else @swapRandomFace()

    @randomOrNewPivot++

  swapNewFace: ->
    @currentNewFaceIdx = ((@currentNewFaceIdx + 1) % @get('new_faces').length)
    @set('item', @get('new_faces')[@currentNewFaceIdx])

  swapRandomFace: ->
    @currentRandomFaceIdx = ((@currentRandomFaceIdx + 1) % @get('random_faces').length)
    @set('item', @get('random_faces')[@currentRandomFaceIdx])

