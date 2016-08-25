class Formatter
  def initialize
    @file = nil
    @indent_level = 0
  end

  def format(file)
    @file = file
    @file.each { |line| format_line(line) }
  end

  # Takes a line and outputs the formatted version
  def format_line(line)
    # Easier when line doesen't have any tabs, spaces etc. 
    # This is a very strict formatter
    line = line.strip
    
    #Make the line have the proper amount of indentation (in tabs, lol)
    (i .. @indent_level).each do |i|
      line.prepend("\t")
    end

    line.each_char { |c|
      case c
      when "{"
        @indent_level +=1
        #Tab everything one more time from now on
      when "}"
        @indent_level -= 1 unless @indent_level == 0 
        #Untab
      else
        #Character is a normal character
      end
    }
  end
end

formatter = Formatter.new

first_arg = ARGV[0]
file = File.new(first_arg)

puts formatter.format(file)
