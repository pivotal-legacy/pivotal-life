class Dashing.Bart extends Dashing.Widget

  ready: =>

  onData: (data) =>
    this.set("trains", data.data)
