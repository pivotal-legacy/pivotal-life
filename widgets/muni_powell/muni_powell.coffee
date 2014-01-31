class Dashing.MuniPowell extends Dashing.Widget

  ready: =>

  onData: (data) =>
    trains = {}
    for direction in ['inbound', 'outbound']
      for train, times of data.data[direction]
        trains[train] ||= {inbound:[], outbound:[]}
        trains[train][direction] = times
    this.set("trains", trains)
