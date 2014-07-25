require 'kaleidoscope'

describe Kaleidoscope::ColorSet do

  let (:color_samples) do
    ['#FF0000', # Red
     '#00FF00', # Green
     '#0000FF'] # Blue
  end

  let (:set) { Kaleidoscope::ColorSet.new(color_samples) }


  describe '#find_closest_to' do

    let(:dark_green) { Kaleidoscope::Color.new('#006400') }

    it '#should find a similar color' do
      closest_color = set.find_closest_to(dark_green)
      expect(closest_color.to_hex).to eq('#00ff00')
    end

    it '#finds other colors' do
      #Some colors...
      red      = '#FF0000'
      green    = '#00FF00'
      blue     = '#0000FF'

      # Define the colors to compare by...
      your_colors = Kaleidoscope::ColorSet.new [red, green, blue]

      # Define the color that you want to match...
      dark_green = Kaleidoscope::Color.new('#006400')

      the_match = your_colors.find_closest_to(dark_green)
      expect(the_match.rgb.to_hex).to eq(green)
    end

  end

end
