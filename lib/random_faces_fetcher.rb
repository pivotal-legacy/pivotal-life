require 'json'

class RandomFacesFetcher < FacesFetcher
  def [](location)
   (all_pivots(location) - new_pivots(location)).shuffle
  end
end