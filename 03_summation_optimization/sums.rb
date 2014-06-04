require 'benchmark'

## > which ruby
## /opt/rubies/ruby-1.9.3-p484/bin/ruby
## > ruby 03_summation_optimization/sums.rb
##        user     system      total        real
##  last six numbers: 940314
##   5.030000   0.040000   5.070000 (  5.065199)
##
## (20140604, BWT)

Benchmark.bm do |x|
  x.report do
    n = 3500
    total = 0

    n.times do |i|
      sum = 1
      i.times do |j|
        sum *= j+1
      end
      total += sum
    end

    puts "last six numbers: #{total % 1000000}"
  end
end
