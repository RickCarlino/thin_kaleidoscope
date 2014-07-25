require 'kaleidoscope/color'
require 'kaleidoscope/color_set'

describe Kaleidoscope::ColorSet do

  let (:color_samples) do
    ['#FF0000', # Red
     '#00FF00', # Green
     '#0000FF'] # Blue
  end

  let (:set) { Kaleidoscope::ColorSet.new(color_samples) }


  describe '#find_closest_to' do

    let(:dark_green) { Kaleidoscope::Color.new('#006400') }

    it '#should find the identical color' do
      closest_color = set.find_closest_to(dark_green)
      expect(closest_color.to_hex).to eq('#00ff00')
    end

  end

end
