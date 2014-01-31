class Dashing.NewFaces extends Dashing.Widget

  ready: =>
    @currentFaceIdx = 0
    setInterval(@rotate, 30000)


  onData: (data) =>
    @set('item', data.new_faces[0])

  rotate: =>
    @currentFaceIdx = ((@currentFaceIdx+1) % @get('new_faces').length)
    @set('item', @get('new_faces')[@currentFaceIdx])
