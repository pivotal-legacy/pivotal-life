require 'spec_helper'
require 'timecop'
require 'webmock'
include WebMock::API

describe NewFacesFetcher do
  let(:pivots_url) {'http://pivots/url'}

  before(:each) do
    Timecop.travel(Time.local(2013, 5, 25))
    stub_request(:get, pivots_url).to_return(:body => File.read('spec/fixtures/pivots_users.json'))
  end

  describe '#[]' do
    let(:fetcher) { NewFacesFetcher.new(pivots_url) }

    it 'returns new Pivots from a location' do
      expect(fetcher['San Francisco']).to match_array([{:first_name=>"Jessica", :last_name=>"Crabb", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1003/IMG_1307.JPG", :title=>"Designer"}, {:first_name=>"Christopher", :last_name=>"Amavisca", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1001/IMG_1316.JPG", :title=>"Engineer"}, {:first_name=>"Abraham", :last_name=>"Raher", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/760/IMG_1257.JPG", :title=>"Technical Writer"}, {:first_name=>"Rawan", :last_name=>"Teplinski", :photo_url=>"https://pivotalpivots2.herokuapp.com/assets/default_directory_profile_photo.png", :title=>"Associate HR Generalist"}, {:first_name=>"Jesse", :last_name=>"Alford", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/755/IMG_1237.JPG", :title=>"Exploratory Tester"}, {:first_name=>"Nikhil", :last_name=>"Gajwani", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/757/IMG_1242.JPG", :title=>"Engineer"}, {:first_name=>"Molly", :last_name=>"Trombley-McCann", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/756/IMG_1233.JPG", :title=>"Engineer"}, {:first_name=>"Christopher", :last_name=>"Jobst", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/711/IMG_1222.JPG", :title=>"Engineer"}, {:first_name=>"David", :last_name=>"Lee", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/712/IMG_1208.JPG", :title=>"Product Manager"}, {:first_name=>"Max", :last_name=>"Hufnagel", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/714/IMG_1244.JPG", :title=>"Technical Writer"}])
      expect(fetcher['Toronto']).to match_array([{:first_name=>"Dominic", :last_name=>"Leung", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/1000/dominic_leung.jpg", :title=>"Design"}, {:first_name=>"Li Sheng", :last_name=>"Tai", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/956/pivots-image20131230-19368-199zggb", :title=>"Engineer"}, {:first_name=>"Allen", :last_name=>"Nizi", :photo_url=>"https://pivotalpivots2.herokuapp.com/assets/default_directory_profile_photo.png", :title=>"Sales"}, {:first_name=>"Stephanie", :last_name=>"White", :photo_url=>"https://pivotalpivots2.herokuapp.com/assets/default_directory_profile_photo.png", :title=>"Marketing"}, {:first_name=>"Xibin", :last_name=>"Ma", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/952/pivots-image20131230-19368-1q7spxt", :title=>"Engineer"}, {:first_name=>"Tomasz", :last_name=>"Rybakiewicz", :photo_url=>"https://pivotalpivots2.herokuapp.com/assets/default_directory_profile_photo.png", :title=>"Engineer"}, {:first_name=>"Josh", :last_name=>"Tighe", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/946/pivots-image20131230-19368-cpk11a", :title=>"Engineer"}, {:first_name=>"Kevin", :last_name=>"Hurley", :photo_url=>"https://pivotalpivots2.herokuapp.com/assets/default_directory_profile_photo.png", :title=>"Social Media"}, {:first_name=>"Kush", :last_name=>"Patel", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/975/pivots-image20131230-19368-52mpgw", :title=>"Engineer (Contractor)"}, {:first_name=>"Sammy", :last_name=>"Davis-Mendelow", :photo_url=>"http://pivots.pivotallabs.com.s3.amazonaws.com/uploads/user/photo/947/pivots-image20131230-19368-16iuaxn", :title=>"Engineer"}])
    end
  end
end
