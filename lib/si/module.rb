module SI
  class << self
    def convert num, options = {}
      options = { :length => options } if options.is_a?(Fixnum)
      options = DEFAULT.merge(options)
      length,
      min_exp,
      max_exp = options.values_at(:length, :min_exp, :max_exp)
      raise ArgumentError.new("Invalid length") if length < 2
      return num.is_a?(Fixnum) ? '0' : "0.#{'0' * (length - 1)}" if num == 0

      base    = options[:base].to_f
      minus   = num < 0 ? '-' : ''
      nump    = num.abs

      PREFIXES.keys.sort.reverse.select { |exp| (min_exp..max_exp).include? exp }.each do |exp|
        denom = base ** exp
        if nump >= denom || exp == min_exp
          val = nump / denom
          val = val.round [length - val.to_i.to_s.length, 0].max
          val = val.to_i if exp == 0 && num.is_a?(Fixnum)
          val = val.to_s.ljust(length + 1, '0') if val.is_a?(Float)

          return "#{minus}#{val}#{PREFIXES[exp]}"
        end
      end

      nil
    end

    def revert str, options = {}
      options = DEFAULT.select { |k, v| k == :base }.merge(options)
      pair    = PREFIXES.to_a.find { |k, v| v == str[-1] }

      if pair
        str[0...-1].to_f * (options[:base] ** pair.first)
      else
        str.to_f
      end
    end
  end

  def si options = {}
    SI.convert(self, options)
  end

  def si_byte length = 3
    SI.convert(self, :length => length, :base => 1024, :min_exp => 0) + 'B'
  end
end

