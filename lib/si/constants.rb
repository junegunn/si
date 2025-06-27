# frozen_string_literal: true

module SI
  PREFIXES = {
    -8 => 'y',
    -7 => 'z',
    -6 => 'a',
    -5 => 'f',
    -4 => 'p',
    -3 => 'n',
    -2 => 'μ',
    -1 => 'm',
    0 => '',
    1 => 'k',
    2 => 'M',
    3 => 'G',
    4 => 'T',
    5 => 'P',
    6 => 'E',
    7 => 'Z',
    8 => 'Y'
  }.freeze

  DEFAULT = {
    length: 3,
    base: 1000,
    space: '',
    min_exp: -8,
    max_exp: 8
  }.freeze
end
