require_relative 'faces_fetcher'

class NewFacesFetcher < FacesFetcher
  def [](location)
    new_pivots(location)
  end
end
