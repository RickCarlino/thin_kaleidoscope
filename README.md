# Thin Kaleidoscope

This is an adaptation to the [Kaleidoscope](https://github.com/JoshSmith/kaleidoscope) gem by [Josh Smith](https://github.com/JoshSmith).

Like the original Kaleidoscope, it is able to do color proximity estimations.

Unlike the original, it does not do anything other than colorspace conversions and color proximity matching. It makes no assumptions about usage. It has no PaperClip nor does it rely on RMagick.

# Usage

**NOTE:** This Gem will clobber the real Kaleidocope. If you need support for PaperClip or features other than color comparison/conversion, use the [main fork](https://github.com/JoshSmith/kaleidoscope).

### Gemfile

```
  gem "thin_kaleidoscope"
```
### Example Code

```ruby

  #Some colors...

  red      = '#FF0000'
  green    = '#00FF00'
  blue     = '#0000FF'

  # Define the colors to compare by...

  your_colors = Kaleidoscope::ColorSet.new [Red, Green, Blue]
  
  # Define the color that you want to match...

  dark_green = Kaleidoscope::Color.new('#006400')

  the_match = your_colors.find_closest_to(dark_green)

  the_match.rgb == green # => true
```
# License
  See LICENSE.txt