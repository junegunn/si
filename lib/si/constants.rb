# encoding: utf-8

module SI
  PREFIXES = Hash[ -8.upto(8).zip(%[yzafpnμm kMGTPEZY].chars.map(&:strip)) ]

  DEFAULT = {
    :length  =>    3,
    :base    => 1000,
    :min_exp =>   -8,
    :max_exp =>    8,
  }
end

