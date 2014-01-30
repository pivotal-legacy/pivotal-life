class Dashing.NewFaces extends Dashing.Widget

  ready: =>
    @currentFaceIdx = 0
    setInterval(@rotate, 30000)
#    if @get('new_faces')
#      @currentFaceIdx--
#      @rotate()


  onData: (data) =>
    @set('item', data.new_faces[0])

  rotate: =>
    @currentFaceIdx = ((@currentFaceIdx+1) % @get('new_faces').length)
    @set('item', @get('new_faces')[@currentFaceIdx])
