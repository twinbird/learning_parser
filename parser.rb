class Program
  attr_accessor :read_ptr
  attr_reader :code

  def initialize(code)
    @code = code
    @read_ptr = 0
  end

  def char
    return @code[@read_ptr]
  end

  def next
    @read_ptr += 1
  end
end

def expr(prog)
  val = term(prog)
  while (prog.char == '+' || prog.char == '-') do
    op = prog.char
    prog.next
    val2 = term(prog)
    val += val2 if op == '+'
    val -= val2 if op == '-'
  end
  return val
end

def term(prog)
  val = factor(prog)
  while (prog.char == '*' || prog.char == '/') do
    op = prog.char
    prog.next
    val2 = factor(prog)
    val *= val2 if op == '*'
    val /= val2 if op == '/'
  end
  return val
end

def factor(prog)
  return number(prog) if prog.char =~ /\d/
  prog.next
  ret = expr(prog)
  prog.next
  return ret
end

def number(prog)
  n = prog.char.to_i
  prog.next
  while (prog.char =~ /\d/) do
    nn = prog.char.to_i
    prog.next
    n = n * 10 + nn
  end
  return n
end

def main
  prog = Program.new("1+2*6/(10-7)")
  puts expr(prog)
end

main
