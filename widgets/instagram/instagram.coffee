class Dashing.Instagram extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @photoElem = $(@node).find('.photo-container')
    @nextPhoto()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextPhoto, 10000)

  nextPhoto: =>
    photos = @get('photo_urls')
    if photos
      @photoElem.fadeOut =>
        @currentIndex = Math.round(Math.random() * (photos.length - 1))
        @set 'current_photo', photos[@currentIndex]
