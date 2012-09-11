# encoding: utf-8

require "si/version"

module SI
  PREFIXES = Hash[ -8.upto(8).zip(%[yzafpnμm kMGTPEZY].chars.map(&:strip)) ]
  DEFAULT = {
    :length  =>    3,
    :base    => 1000,
    :min_exp =>   -8,
    :max_exp =>    8,
  }

  def si options = {}
    options = DEFAULT.merge(options)
    length,
    min_exp,
    max_exp = options.values_at(:length, :min_exp, :max_exp)
    base    = options[:base].to_f
    minus   = self < 0 ? '-' : ''
    selfp   = self.abs

    PREFIXES.keys.sort.reverse.select { |exp| (min_exp..max_exp).include? exp }.each do |exp|
      denom = base ** exp
      if selfp >= denom || exp == min_exp
        val = selfp / denom
        val = val.round [length - val.to_i.to_s.length, 0].max
        val = val.to_i if exp == 0 && self.is_a?(Fixnum)
        val = val.to_s.ljust(length + 1, '0') if val.is_a?(Float)

        return "#{minus}#{val}#{PREFIXES[exp]}"
      end
    end

    nil
  end

  def si_byte length = 3
    self.si(:length => length, :base => 1024, :min_exp => 0) + 'B'
  end
end

class Float
  include SI
end

class Fixnum
  include SI
end

class Bignum
  include SI
end

