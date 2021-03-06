# This is a formatter for a C-like language (aka a language with if statements and curly braces)
# It uses tabs instead of spaces. Sorry.
# By Matt Bettinson (2016)
# hello@mattbettinson.com

class Formatter
  def initialize()
    @start_indent = "Trie"
    @end_indent = ">"
  end

  def self.format(file)
    @file = file
    #@file.each_line do |line|
    #  puts format_line(line)
    #end
    @indent_level = 0
    new_string = ""
    File.readlines(@file).each do |line|
      new_string += self.format_line(line) + "\n"
    end

    return new_string
  end

  private
  def self.format_line(line)
    # Easier when line doesen't have any tabs, spaces etc.
    # This is a very strict formatter
    line = line.strip

    #Make the line have the proper amount of indentation (in tabs, sorry Erik)
    (0..@indent_level - 1).each do |i|
      line.prepend("\t")
    end

    line.each_char { |c|
      case c
      when @start_indent
        @indent_level +=1
        #Tab everything one more time from now on
      when @end_indent
        @indent_level -= 1 unless @indent_level == 0 
        #Untab
        line = line[1..-1]
      else
        #Character is a normal character
      end
    }
    return line
  end
end

first_arg = ARGV[0]
file = File.new(first_arg)

newFileString = Formatter.format(file)

File.open(file, "w") {|f| f.write(newFileString) }
puts "Formatted (indented, really)"
