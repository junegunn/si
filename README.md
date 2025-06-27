# SI

Formats a number with [SI prefix (Metric prefix)](http://en.wikipedia.org/wiki/SI_prefix).

## Installation

Add this line to your application's Gemfile:

    gem 'si'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install si

## Usage

### `si`

Express a numeric value with SI prefix.

```ruby
require 'si'

0.9.si            # '900m'
9.si              # '9'
98.si             # '98'
987.si            # '987'
9876.si           # '9.88k'
98765.si          # '98.8k'
987654.si         # '988k'
9876543.si        # '9.88M'
98765432.si       # '98.8M'
987654321.si      # '988M'
9876543210.si     # '9.88G'
98765432100.si    # '98.8G'
987654321000.si   # '988G'
9876543210000.si  # '9.88T'
# ...

```

#### Options

| Option       | Default   | Description                                                                                                 |
| ------------ | --------- | ----------------------------------------------------------------------------------------------------------- |
| `:length`    | 3         | Number of digits                                                                                            |
| `:base`      | 1000      | For [binary prefix](http://en.wikipedia.org/wiki/Binary_prefix), set this to 1024 instead of default 1000   |
| `:space`     | `''`      | Space between number and prefix. Set to `' '` to get `9.88 T` instead of `9.88T`                            |
| `:min_exp`   | -8        | Down to <strong>y</strong>octo                                                                              |
| `:max_exp`   | 8         | Up to <strong>Y</strong>otta                                                                                |

```ruby
9876543210000.si(length: 5)  # '9.8765T'

# For convenience, a single Fixnum is recognized as :length value
9876543210000.si(5)             # '9.8765T'
```

### `si_bytes`

Formats the number of bytes using SI prefixes (base 1000).

```ruby
13255342817.si_bytes  # '13.3GB'
```

### `bin_bytes`

Formats the number of bytes using binary prefixes (base 1024).

```ruby
13255342817.bin_bytes  # '12.3GiB'
```

## SI module methods: convert / revert

```ruby
SI.convert(9876543210000, length: 5)  # '9.8765T'
SI.revert('100k', base: 1024)         # 102400.0
```

## Avoiding monkey-patching

Require 'si/minimal' instead to avoid monkey-patching numeric classes.

```ruby
require 'si/minimal'

SI.convert(987654321, 3)  # 988M
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
