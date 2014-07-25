require 'spec_helper'
require 'kaleidoscope/color'
require 'kaleidoscope/color_set'

describe Kaleidoscope::Color do

  let (:color) { Kaleidoscope::Color.new('#FFFFFF') }


  describe '#new' do

    it 'creates a valid object' do
      expect(color.rgb.r).to eq(255)
      expect(color.rgb.g).to eq(255)
      expect(color.rgb.b).to eq(255)
    end

  end

end
