require 'benchmark'

## /opt/rubies/rbx-2.2.3/bin/ruby
## > ruby 03_summation_optimization/sums.rb
##        user     system      total        real
##  last six numbers: 940314
##   3.682826   0.088958   3.771784 (  3.592792)
##  last six numbers: 940314
##   7.010272   0.396651   7.406923 (  1.503909)
##
## (20140604, BWT)

class Summit
  attr_accessor :n, :total

  def initialize(n)
    @n = n
    @total = 0
  end

  def threadless
    @total = 0
    outer = []

    n.times do |i|
      a = [1] + (1..i).to_a
      outer << a.inject(:*)
    end

    @total = outer.inject(:+)
    puts "last six numbers: #{@total % 1000000}"
    @total
  end

  def threaded(concurrency = 32)
    @total = 0
    outer       = []
    bundle_size = n / concurrency + 1

    (0..n-1).each_slice(bundle_size) do |m|
      @th = Thread.new do
        m.each do |i|
          a = [1] + (1..i).to_a
          outer << a.inject(:*)
        end
      end
    end

    @th.join
    @total = outer.inject(:+)
    puts "last six numbers: #{@total % 1000000}"
    @total
  end
end

Benchmark.bm do |x|
  s = Summit.new(3500)
  x.report { s.threadless }
  x.report { s.threaded }
end
