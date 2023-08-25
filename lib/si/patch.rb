['Float', 'Fixnum', 'Bignum', 'Rational', 'Integer'].each do |const|
  next unless Object.const_defined?(const)

  Object.const_get(const).class_eval do
    include SI
  end
end
