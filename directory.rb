@students = []

def try_load_students
  unless ARGV.empty?
    file_name = ARGV.first
    puts "File argument provided: Attempting to load... #{file_name}"
  end
  if ARGV.empty?
    file_name = 'students.csv'
    puts "No argument provided: Loading default file #{file_name}"
  end

  return if file_name.nil?

  if File.exist?(file_name)
    load_students(file_name)
    puts "Successfully imported #{@students.count} students from #{file_name}."
    return
  else
    puts "File: #{file_name} does not exist."
    exit
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print_students_list
  @students.each_with_index do |profile, index|
    puts "#{index + 1}. #{profile[:name]} | Cohort: #{profile[:cohort]} "
  end
end

def print_specific_letter
  puts 'Print student names starting with...'
  start_with = STDIN.gets.chomp
  @students.each do |profiles|
    puts profiles[:name].capitalize if profiles[:name][0].downcase == start_with
  end
end

def print_shorter_than
  puts 'Print student names with less characters than...'
  less_than = STDIN.gets.chomp.to_i
  @students.each do |profile|
    p "#{profile[:name]} is less than #{less_than} characters long" if
        profile[:name].length < less_than
  end
end

def print_while
  puts 'Until loops...'
  count = @students.length - 1
  until count == -1
    p @students[count]
    count -= 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} students"
end

def input_students
  puts "Please enter the names of new students \nTo finish, just hit enter twice"
  name = STDIN.gets.chomp
  until name.empty?
    @students << { name: name, cohort: :november }
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
  p @students
end

def show_students
  print_header
  print_students_list
  print_specific_letter
  print_shorter_than
  print_while
  print_footer
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
  when '4'
    load_students
  when '9'
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save list of students'
  puts '4. Load list of students'
  puts '9. Exit'
end

def save_students
  puts 'SAVE: Please enter filename/leave empty to save to default students.csv'
  filename = STDIN.gets.chomp
  if File.exist?(filename) || filename.empty?
    puts "File: #{filename} found! Appending..."
    file = File.open('students.csv', 'a')
  else
    puts "Creating new file #{filename}"
    file = File.open(filename, 'w')
  end
  @students.each do |profile|
    student_data = [profile[:name], profile[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
  puts "Saved #{@students.count} profiles into #{filename}"
end

def load_students(filename)
#puts 'LOAD: Please enter filename'
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << { name: name, cohort: cohort.to_sym }
  end
  file.close
  puts "Loaded #{@students.count} profiles from #{filename}"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
