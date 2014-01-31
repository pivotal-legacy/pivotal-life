class Dashing.Bart extends Dashing.Widget

  ready: =>

  onData: (data) =>
    console.log(data)
    this.set("trains", data.data)
