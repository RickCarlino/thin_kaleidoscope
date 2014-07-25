require 'kaleidoscope/color'

module Kaleidoscope
  class ColorSet

    def initialize(hex_values)
      @colors = hex_values.map { |hex|
        Color.new(hex)
      }
    end

    def find_closest_to(target_color)
      colors.min_by { |color|
        color.distance_from(target_color)
      }
    end

    private

      attr_reader :colors
  end
end
