describe("MUNI Bus", =>
  muniBus = undefined
  beforeEach(=>
    muniBus = new Dashing.MuniBus()
  )
  it("uses Isotope to sort the data by Stop names", =>
    setDataOnWidget(muniBus, data: {
      "c": {b: 46}
      "a": {z: 1},
      "b": {x: 7}
    })
    spyOn($.fn, 'isotope')

    muniBus.ready()

    isotopeObject = $.fn.isotope.calls.all()[0].object
    expect(isotopeObject).toEqual($('.stops'))
    isotopeConfig = $.fn.isotope.calls.all()[0].args[0]
    expect(isotopeConfig.itemSelector).toEqual('.stop')
    expect(isotopeConfig.masonryHorizontal).toEqual({rowHeight: 290})
    expect(isotopeConfig.sortBy).toEqual('name')
    expect(isotopeConfig.sortAscending).toEqual(true)
    expect(isotopeConfig.getSortData.name($('<table><caption>FOO</caption></table>'))).toEqual('FOO')
  )
)
