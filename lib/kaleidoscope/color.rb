module Kaleidoscope

  RGB = Struct.new(:r, :g, :b)
  XYZ = Struct.new(:x, :y, :z)
  LAB = Struct.new(:l, :a, :b)

  class Color
    attr_reader :rgb

    def initialize(hex)
      # #FFFFFF ==> [255, 255, 255]
      validate(hex)
      r, g, b = hex.delete('#').scan(/../).map(&:hex)
      @rgb = RGB.new(r, g, b)
    end

    def validate(hex)
      unless hex.length == 7 && hex[0] == '#'
        raise MalformedHexValueError,
          'Hex values must be 7 letters in length and start with a `#`'
      end
    end

    # Create a color given a hexadecimal number, e.g. #FFFFFF
    def self.from_hex(hex)
      hex = strip_hex(hex)
      r, g, b = hex.scan(/../).map(&:hex)
      Color.new(r: r, g: g, b: b)
    end

    def red
      rgb.r
    end

    def green
      rgb.g
    end

    def blue
      rgb.b
    end

    def x
      xyz.x
    end

    def y
      xyz.y
    end

    def z
      xyz.z
    end

    def l
      lab.l
    end

    def a
      lab.a
    end

    def b
      lab.b
    end

    def to_hex
      hex = '%02x%02x%02x' % [red, green, blue]
      "\##{hex}"
    end

    def to_lab
      lab
    end

    def distance_from(color)
      euclidean_distance [self.l, self.a, self.b], [color.l, color.a, color.b]
    end

    private

      def self.strip_hex(hex)
        hex.delete('#')
      end

      def xyz
        @xyz ||= calculate_xyz
      end

      def lab
        @lab ||= calculate_lab
      end

      def euclidean_distance(a, b)
        a.zip(b).map { |x| (x[1] - x[0])**2 }.reduce(:+)
      end

      def calculate_xyz
        r = r_for_xyz(red / 255.0) * 100
        g = g_for_xyz(green / 255.0) * 100
        b = b_for_xyz(blue / 255.0) * 100

        # Observer. = 2°, Illuminant = D65
        x = x_for_xyz(r, g, b)
        y = y_for_xyz(r, g, b)
        z = z_for_xyz(r, g, b)

        XYZ.new(x, y, z).freeze
      end

      def calculate_lab
        x = xyz_for_lab(xyz[:x] / 95.047)
        y = xyz_for_lab(xyz[:y] / 100.000)
        z = xyz_for_lab(xyz[:z] / 108.883)

        # Observer= 2°, Illuminant= D65
        l = ( 116 * y ) - 16
        a = 500 * ( x - y )
        b = 200 * ( y - z )

        LAB.new(l, a, b).freeze
      end

      def r_for_xyz(r)
        if r > 0.04045
          ( ( r + 0.055 ) / 1.055 ) ** 2.4
        else
          r / 12.92
        end
      end

      def g_for_xyz(g)
        if g > 0.04045
          ( ( g + 0.055 ) / 1.055 ) ** 2.4
        else
          g / 12.92
        end
      end

      def b_for_xyz(b)
        if b > 0.04045
          ( ( b + 0.055 ) / 1.055 ) ** 2.4
        else
          b / 12.92
        end
      end

      def x_for_xyz(r, g, b)
        r * 0.4124 + g * 0.3576 + b * 0.1805
      end

      def y_for_xyz(r, g, b)
        r * 0.2126 + g * 0.7152 + b * 0.0722
      end

      def z_for_xyz(r, g, b)
        r * 0.0193 + g * 0.1192 + b * 0.9505
      end

      def xyz_for_lab(component)
        if component > 0.008856
          component ** ( 1.0 / 3.0 )
        else
          ( 7.787 * component ) + ( 16.0 / 116.0 )
        end
      end

  end
end