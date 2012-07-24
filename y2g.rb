def match_package(str)
  str.match(/package\s.*;/)
end

def match_import(str)
  str.match(/import\s.*;/)
end

def match_class(str)
  str.match(/class\s*[A-Z]\w*/)
end

def match_java_code(str)
  str.match(/[^%^\/].*/)
end

def match_token(str)
  str.match(/%token\s*<.*>[\s\w]*/)
end

def match_type(str)
  str.match(/%type\s*<.*>\s*(\w*,?\s*)*/)
end

def create_token_list(tokens)
  token_list = "";
  tokens.each do |token|
    if not token_list.include? ", " + token + ", "
      token_list += token + ", ";
    end
  end
  token_list
end


src = File.new("/home/chaitanya/projects/yaccToGrammar/DefaultRubyBeaverParser.y")
dest = File.new("#{ARGV[1]}.grammar", 'w')
input = src.read
#split the input into 3 sections as per convention of yacc file
section1 = (input.match(/%{(\n|.)*%}/)).to_s
section2 = (input.match(/%}(\n|.)*%%(\n|.)*%%/)).to_s.gsub! "%}", ""
section3 = (section2.match(/%%(\n|.)*%%/)).to_s.gsub! "%%", ""
section2.gsub! section3, ""
section2.gsub! "%%", ""
(section3.scan(/\/\/.+/)).each do |arg|
  section3[arg] = ''
end
(section3.scan(/\/\*[.\s]*\*\//)).each do |arg|
  section3[arg] = ''
end

#comments from section1
comments = section1.match(/\/\*(.|\n)*\*\//)
section1.gsub! comments.to_s, ""
section1.gsub! "%{", ""
section1.gsub! "%}", ""
section1 = section1.split "\n"
section2 = section2.split "\n"
#section3 = section3.split
count = 0


section3 = section3.split ' '
section3.delete ""
#p section3
embed = ""
tokens = []
types = {}

section3.each do |arg|
  arg.strip!
end

@section3 = section3

#process section1
section1.each do |line|

  if result = match_package(line)
    result = result.to_s.split
    result[1].gsub! ";" , '";'
    dest.write("%" + result[0] + ' "' + result[1])
  elsif result = match_import(line)
    result = result.to_s.split
    result[1].gsub! ";" , '";'
    dest.write("\n%" + result[0] + ' "' + result[1] )
  elsif result = match_java_code(line)
    embed += result.to_s + "\n"
  end
  if result = match_class(line)
    result = result.to_s.split
    dest.write("\n\n%" + result[0] + ' "' + ARGV[1] + '";')
  end
end

embed.gsub!(embed.scan(/.*{/)[0].to_s, '')
embed.gsub!(embed.scan(/\n\n/)[0].to_s, '')
dest.write "\n\n%embed{:\n" + embed + "\n:};"
@assoc = []

#process section2
section2.each do |line|
  if line.scan(/\/\*.*\*\//)[0]
    line.gsub!(line.scan(/\/\*.*\*\//)[0], '')
  end
  if result = match_token(line)
    result =  result.to_s
    result.gsub! "<", ""
    result.gsub! ">", ""
    result = result.split
    result[2..-1].each  do |element|
      tokens << element
    end
    if types[result[1].to_sym]
      types[result[1].to_sym] += [ result[2].to_s ]
    else
      types[result[1].to_sym] = [ result[2].to_s ]
    end
  elsif result = match_type(line)
    result = result.to_s
    result.gsub! "<", ""
    result.gsub! "<", ""
    result.gsub! ">", ""
    result.gsub! ",", ""
    result = result.split
    if types[result[1].to_sym]
      (2..result.length-1).each do |index|
        types[result[1].to_sym] += [result[index].to_s]
      end
    else

      (2..result.length-1).each do |index|

        types[result[1].to_sym] = [result[index].to_s]
      end
    end
  elsif
    if line.include? "%nonassoc"
      line.gsub! "%nonassoc", ''
      line = line.split.join ','
      line[-1] = ';'
      @assoc << "%nonassoc " + line
    elsif
      line.include? "%left"
      line.gsub! "%left", ''
      line = line.split.join ','
      line[-1] = ';'
      @assoc << "%left " + line
    elsif line.include? '%right'
      line.gsub! "%right", ''
      line = line.split.join ','
      line += ';'
      @assoc << "%right " + line
    end
  end
end
dest.write "\n\n%terminals "
dest.write " " + create_token_list(tokens)[0..-3]+";"

types.each_key do |type|
  dest.write "\n\n%typeof " + create_token_list(types[type])[0..-3] + " = " + '"' +  type.to_s  + '"' + ";"
end

@assoc.each do |association|
  dest.write association + "\n"
end

#process section3
class RecurseDescently

  def check_comment
    value = next_val
    @dest.write value + ' '
    if value.strip == "*/" or value.strip == "\n"
    else
      check_comment
    end
  end

  def initialize src, dest, section3, types
    @if_flag = 0
    @section3 = section3
    @dest = dest
    @index = -1
    @types = types
    @src = src
  end

  def next_val
    if @index ==  @section3.length - 1
      @dest.write "\n ;"
      @src.close
      @dest.close
      exit
    end
    @index = @index + 1
    @section3[@index]
  end


  def ruby_error_var var
    @dest.write var + ' '
  end

  def rest_of_return_value
    value = next_val
    if value[-1] == ';'
      @dest.write strip_dollar(value)
      rhs_production
    else
      @dest.write strip_dollar(value)
      rest_of_return_value
    end
  end

  def return_value
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      return_value
    elsif value.strip == '='
      @dest.write "\n result = "
      return_value
    elsif value[-1] == ';'
      @dest.write eval(value)
      javacode
    elsif value.include? '"$"'
      ruby_error_var(value)
      return_value
    else
      @dest.write eval(value) + " "
      return_value
    end
  end

  def eval val
    unless (val.include? '"' or val.include? "'" or val.strip == "$$")
      if val.match(/\$(<.+>)?/).to_s != '' 
        val.gsub!(val.match(/\$(<.+>)?/).to_s , "arg")
      end
    else
      if val.strip == "$$"
        @dest.write "#{@type} result = new #{@type};"
        @return_flag = 1
        return_value
      end
    end
    val
  end

  def check_end_of_action
    if @section3[@index+1] == ':'
      @dest.write "\n ; \n"
      parse_yacc_g
    else
      rhs_production
    end
  end

  def else_predicate
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      else_predicate
    elsif value == "}"
      @dest.write value
      if @section3[@index+1] == "if"
        else_statement
        # check where it returns!
      else
        @dest.write eval value
        else_predicate
      end
    else
      @dest.write eval value + ' '
      else_predicate
    end
  end
  
  def else_statement
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      else_statement
    elsif value.strip == "else"
      @dest.write "\n"+ value + " "
      else_statement
    elsif value == "if"
      @dest.write value
      # check else if example
      if_statement
    elsif value == "{"
      @dest.write(value + "\n")
      else_predicate
    else
      dest.write eval value + ' '
      else_statement
    end
  end

  def if_predicate
    @if_flag = 1
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      if_predicate
    elsif value == "}"
      @if_flag = 0
      @dest.write "\n" + value + "\n"
      if @section3[@index+1] == "else"
        else_statement
        # check where it returns!
      else
        javacode
      end
    elsif value.strip == "if" or value.include? "if"
      @dest.write "\n" + value 
      if_statement
    else
      @dest.write eval value + " "
      if_predicate
    end
  end

  def check_else
    @section3[@index] == "else"
  end

  def if_statement
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      if_statement
    elsif check_else
      @dest.write "else "
      else_statement
    elsif value == "{"
      @dest.write("\n" + value + "\n")
      if_predicate
    else
      @dest.write eval value + ' '
      if value[-1] == ')'
        if_predicate
      else
        if_statement
      end
    end
  end

  def lookahead
    if (@index == (@section3.length - 1) or @section3[@index+1][-1] == ':' or @section3[@index+2] == ':' or @section3[@index+2] == "{" or @section3[@index+1] == "|")
      true
    else
      false
    end
  end

  def javacode
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      javacode
    elsif value == '{'
      @dest.write(' ' + value + "\n")
      javacode
    elsif value == "}" and lookahead
      if @return_flag == 1
        @return_flag = 0
        @dest.write "\n return new Symbol(result);"
      else
        @dest.write "\n return new Symbol(arg1);"
      end
      if @if_flag == 1
        @dest.write "\n } \n"
        @if_flag = 0
        if_statement
      elsif @section3[@index+1] and @section3[@index+1].strip == "else"
        @dest.write "\n } \n"
        else_statement
      else
        @dest.write "\n :} \n "
        @java_flag = 0
        if @section3[@index+2] == ":" or (@section3[@index+1] and not @section3[@index+1].include?  "|" and @section3[@index+2] != "{")
          @dest.write ";\n"
          parse_yacc_g
        else
          rhs_production
        end
      end
    elsif value == "}"
      @dest.write "\n } \n"
      javacode
    elsif value.strip == "|"
      @rhs_index = 1
      @dest.write value + "\n"
      rhs_production
    elsif value.include? "if"
      @dest.write eval value
      if_statement
      javacode
    else
      @dest.write eval value + '  '
      javacode
    end
  end


  def rhs_production
    if @section3[@index+2] == ':' or @section3[@index+1] == ":"
      @dest.write "\n ; \n"
      parse_yacc_g
    else
      value = next_val
      if value.strip == "/*"
        @dest.write value
        check_comment
        rhs_production
      elsif value.strip == '{'
        @rhs_index = @rhs_index + 1
        @dest.write "\n {: \n"
        @java_flag = 1
        javacode
      elsif value.strip == '|'
        if @java_flag != 0
          @rhs_index = 1
        end
        @dest.write "| \n"
        rhs_production
      elsif value.include? "'" or value.include? '"'
        @dest.write value
        rhs_production
      elsif value.strip == '%prec'
        @dest.write(value + ' ')
        rhs_production
      else
        @dest.write(value + ".arg#{@rhs_index} ")
        @rhs_index = @rhs_index + 1
        rhs_production
      end
    end
  end

  def current_type value
    @types.keys.each do |key|
      @types[key].each do |val|
        if val.strip == value.strip
          @type = key
          @type
        end
      end
    end
  end

  def parse_yacc_g
    value = next_val
    if value.strip == "/*"
      @dest.write value
      check_comment
      parse_yacc_g
    elsif value == ":"
      current_type(@section3[@index-1])
      @dest.write " = "
      @rhs_index = 1
      rhs_production
    elsif value[-1] == ':'
      @dest.write(value[0..-2] + " = ")
      @rhs_index = 1
      rhs_production
    elsif value == "{"
      @dest.write "{: \n"
      javacode
    else
      @dest.write value
      if @section3[@index+1] == "{"
        @dest.write ".arg#{@rhs_index} "
      end
      parse_yacc_g
    end
  end
end

parser = RecurseDescently.new(src,dest,section3,types)
parser.parse_yacc_g
#wrap up the process

