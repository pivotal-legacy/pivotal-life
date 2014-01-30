if (!window.Dashing)
  window.Dashing = {}
  class Dashing.Widget
    get: (key) =>
      @[key]
    set: (key, val) =>
      @[key] = val

  window.setDataOnWidget = (widget, data) =>
    widget.set(key, val) for key, val of data
    widget.onData(data)

  window.Dashing.Widget.prototype.__super__ = {
    constructor: =>
  }
  window.Dashing.Widget.accessor = (name, other) =>
    @[name] = other
