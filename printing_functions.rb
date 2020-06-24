def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print_students_list
  @students.each_with_index do |profile, index|
    STDOUT.puts "#{index + 1}. #{profile[:name]} | Cohort: #{profile[:cohort]} "
  end
end

def print_specific_letter
  STDOUT.puts 'Print student names starting with...'
  start_with = STDIN.gets.chomp
  container = []
  @students.each do |profiles|
    container << profiles[:name].capitalize if profiles[:name][0].downcase == start_with
  end
  STDOUT.puts container
  STDOUT.puts "There are #{container.size} students with names starting with #{start_with}"
end

def print_shorter_than
  STDOUT.puts 'Print student names with less characters than...'
  less_than = STDIN.gets.chomp.to_i
  @students.each do |profile|
    STDOUT.puts "#{profile[:name]} is less than #{less_than} characters long" if
        profile[:name].length < less_than
  end
end

def print_while
  STDOUT.puts 'Until loops...'
  count = @students.length - 1
  until count == -1
    p @students[count]
    count -= 1
  end
end

def print_footer
  STDOUT.puts "Overall, we have #{@students.count} students"
end

def print_menu
  STDOUT.puts '1. Input new student(s)'
  STDOUT.puts '2. Show current student directory'
  STDOUT.puts '3. Save current list of students'
  STDOUT.puts '4. Load a list of students'
  STDOUT.puts '5. Filter student directory by first character'
  STDOUT.puts '6. Filter student directory by name length'
  STDOUT.puts '7. Reset the directory'
  STDOUT.puts '9. Exit'
end

