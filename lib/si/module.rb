# frozen_string_literal: true

module SI
  class << self
    def convert(num, options = {})
      options = { length: options } if options.is_a?(Numeric)
      options = DEFAULT.merge(options)
      space, length, min_exp, max_exp = options.values_at(:space, :length, :min_exp, :max_exp)
      raise ArgumentError, 'Invalid length' if length < 2

      return num.is_a?(Float) ? "0.#{'0' * (length - 1)}" : '0' if num.zero?

      base = options[:base].to_f
      minus = num.negative? ? '-' : ''
      nump = num.abs

      PREFIXES.keys.sort.reverse.select { |exp| (min_exp..max_exp).include?(exp) }.each do |exp|
        denom = base**exp
        next unless nump >= denom || exp == min_exp

        val = nump / denom
        val = SI.round val, [length - val.to_i.to_s.length, 0].max
        val = val.to_i if exp.zero? && !num.is_a?(Float)
        val = val.to_s.ljust(length + 1, '0') if val.is_a?(Float)

        return "#{minus}#{val}#{space}#{PREFIXES[exp]}"
      end

      nil
    end

    def revert(str, options = {})
      options = Hash[DEFAULT.select { |k, _v| k == :base }].merge(options)
      pair    = PREFIXES.to_a.find { |_k, v| !v.empty? && str =~ /[0-9]#{v}$/ }

      if pair
        str[0...-1].to_f * (options[:base]**pair.first)
      else
        str.to_f
      end
    end

    if (RUBY_VERSION.split('.')[0, 2].map(&:to_i) <=> [1, 8]) == 1
      def round(val, ndigits)
        val.round ndigits
      end
    else
      def round(val, ndigits)
        exp = (10**ndigits).to_f
        val = ((val * exp).round / exp)
        ndigits.zero? ? val.to_i : val
      end
    end
  end

  def si(options = {})
    SI.convert(self, options)
  end

  # Deprecated. Only kept for backward compatibility.
  def si_byte(length = 3)
    "#{SI.convert(self, length: length, base: 1024, min_exp: 0)}B"
  end

  def si_bytes(options = {})
    options = { length: options } if options.is_a?(Numeric)
    options = { base: 1000, length: 3, min_exp: 0 }.merge(options)
    "#{SI.convert(self, options)}B"
  end

  def bin_bytes(options = {})
    options = { length: options } if options.is_a?(Numeric)
    options = { base: 1024, length: 3, min_exp: 0 }.merge(options)
    result = SI.convert(self, options)
    result.match?(/[0-9]$/) ? "#{result}B" : "#{result}iB"
  end
end
