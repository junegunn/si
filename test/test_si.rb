#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'test/unit'
require 'si'

class TestSI < Test::Unit::TestCase
  def test_si
    val = 0.000_000_000_000_000_000_000_000_0001234567

    %w[
      0.00012y
      0.00123y
      0.01235y
      0.12346y

      1.23457y
      12.3457y
      123.457y

      1.23457z
      12.3457z
      123.457z

      1.23457a
      12.3457a
      123.457a

      1.23457f
      12.3457f
      123.457f

      1.23457p
      12.3457p
      123.457p

      1.23457n
      12.3457n
      123.457n

      1.23457μ
      12.3457μ
      123.457μ

      1.23457m
      12.3457m
      123.457m
    
      1.23457
      12.3457
      123.457
    
      1.23457k
      12.3457k
      123.457k
    
      1.23457M
      12.3457M
      123.457M
    
      1.23457G
      12.3457G
      123.457G
    
      1.23457T
      12.3457T
      123.457T
    
      1.23457P
      12.3457P
      123.457P
    
      1.23457E
      12.3457E
      123.457E

      1.23457Z
      12.3457Z
      123.457Z

      1.23457Y
      12.3457Y
      123.457Y

      1234.57Y
      12345.7Y
      123457Y
      1234567Y
      12345670Y
      123456700Y
      1234567000Y
    ].each do |ret|
      assert_equal ret, val.si(:length => 6)
      assert_equal '-' + ret, (-val).si(:length => 6)
      val *= 10
    end
  end

  def test_si_base
    val = 807936
    %w[
      789k
      789M
      789G
      789T
      807936T
      827326464T
    ].each do |ret|
      assert_equal ret, val.si(:base => 1024, :max_exp => 4)
      val *= 1024
    end
  end

  def test_si_byte
    {
      1234132             => '1.18MB',
      123004132           => '117MB',
      123004999132        => '115GB',
      555123004999132     => '505TB',
      5555123004999132    => '4.93PB',
      3335555123004999132 => '2.89EB',
      0.001               => '0.00B',
      0.005               => '0.01B',
      0.01                => '0.01B',
      0.1                 => '0.10B',
      0                   => '0B',
      1                   => '1B',
      1.0                 => '1.00B',
      1.01                => '1.01B',
      10                  => '10B',
      10.0                => '10.0B',
      100                 => '100B',
      100.0               => '100B',
      0.0                 => '0.00B',
      0.123412            => '0.12B',
      0.0123412           => '0.01B',
      0.00123412          => '0.00B',
    }.each do |val, ret|
      assert_equal ret, val.si_byte

      if val == 0
        assert_equal ret, (-val).si_byte
      else
        assert_equal '-' + ret, (-val).si_byte unless val == 0
      end
    end
  end

  def test_readme
    {
      0.009         => '9.00m',
      0.09          => '90.0m',
      0.9           => '900m',
      9             => '9',
      98            => '98',
      987           => '987',
      9876          => '9.88k',
      98765         => '98.8k',
      987654        => '988k',
      9876543       => '9.88M',
      98765432      => '98.8M',
      987654321     => '988M',
      9876543210    => '9.88G',
      98765432100   => '98.8G',
      987654321000  => '988G',
      9876543210000 => '9.88T',
    }.each do |val, ret|
      assert_equal ret, val.si
    end

    assert_equal '9.8765T', 9876543210000.si(:length => 5)
    assert_equal '12.3GB', 13255342817.si_byte
  end

  def test_is
    assert_equal 9876543210000, 9876543210000.si.is
  end

  def test_edge_cases
    assert_equal '9.0000T', 9000000000001.si(:length => 5)
  end

  def test_shortcut
    assert_equal '123.5M', 123450000.si(4)
  end

  def test_module_methods
    assert_equal '9.8765T',          SI.convert(9876543210000, :length => 5)
    assert_equal 9876500000000,      SI.revert('9.8765T')
    assert_equal 9876500000,         SI.revert('9.8765G')
    assert_equal 9876500,            SI.revert('9.8765M')
    assert_equal 9.8765 * 1024 ** 2, SI.revert('9.8765M', :base => 1024)
    assert_equal 0.0098765,          SI.revert('9.8765m')
    assert_equal 0.0098765,          SI.revert('9.8765m')
    assert_equal 9.8765,             SI.revert('9.8765')
    assert_equal 0.0,                SI.revert('hello') # FIXME
  end

  def test_rational
    assert_equal '12.345n', (12345 * (10 ** -12)).si(5)
  end
end

