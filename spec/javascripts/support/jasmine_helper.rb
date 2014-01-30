require 'rack/coffee'

class ShimCoffeeRack

  def initialize(app, opts = {})
    @coffee = Rack::Coffee.new(app, {:urls => ['/widgets', '/spec/javascripts']})
  end

  def call(env)
    @coffee.call(env)
  end
end

module Jasmine
  class Configuration
    attr_accessor :src_files, :spec_files
  end
end


Jasmine.configure do |config|
  coffee_src_files = config.src_files.call
  coffee_spec_files = config.spec_files.call
  config.src_files = -> {
    (coffee_src_files+coffee_spec_files).map do |src_file|
      src_file.gsub(/\.coffee$/, '.js')
    end
  }

  config.spec_files = -> {
    []
  }

  config.add_rack_app(ShimCoffeeRack)

end

