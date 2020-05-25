str = "xyz"

enum = str.enum_for(:each_byte)
enum.each { |b| puts b }
# => 120
# => 121
# => 122

# protect an array from being modified by some_method
a = [1, 2, 3]
Integer(a.to_enum)

module Enumerable
  # a generic method to repeat the values of any enumerable
  def repeat(n)
    raise ArgumentError, "#{n} is negative!" if n < 0
    unless block_given?
      return to_enum(__method__, n) do # __method__ is :repeat here
        sz = size     # Call size and multiply by n...
        sz * n if sz  # but return nil if size itself is nil
      end
    end
    each do |*val|
      n.times { yield *val }
    end
  end
end

%i[hello world].repeat(2) { |w| puts w }
  # => Prints 'hello', 'hello', 'world', 'world'
enum = (1..14).repeat(3)
  # => returns an Enumerator when called without a block
enum.first(4) # => [1, 1, 1, 2]
enum.size # => 42

module Mod
  def hello
    "Hello from Mod.\n"
  end
end

class Klass
  def hello
    "Hello from Klass.\n"
  end
end

k = Klass.new
k.hello         #=> "Hello from Klass.\n"
k.extend(Mod)   #=> #<Klass:0x401b3bc8>
k.hello         #=> "Hello from Mod.\n"