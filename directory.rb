@students = []

def try_load_students
  if ARGV.empty?
    file_name = 'students.csv'
    puts "No argument provided: Loading default file... #{file_name}"
  elsif !ARGV.empty?
    file_name = ARGV.first
    puts "File argument provided: Attempting to load... #{file_name}"
  end

  if File.exist?(file_name)
    load_students(file_name)
    puts "Successfully imported #{@students.count} students from #{file_name}."
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
  container = []
  @students.each do |profiles|
    container << profiles[:name].capitalize if profiles[:name][0].downcase == start_with
  end
  puts container
  puts "There are #{container.size} students with names starting with #{start_with}"
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
    puts "Enter the name of the file you wish to load"
    load_students(STDIN.gets.chomp)
  when '5'
    print_specific_letter
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
  puts '5. Filter students by first character'
  puts '9. Exit'
end

def save_students
  puts 'SAVE: Please enter filename/leave empty to save to default students.csv'
  filename = STDIN.gets.chomp
  if filename.empty?
    puts "No file selected, using default: #{filename}... Appending..."
    filename = 'students.csv'
  elsif File.exist?(filename)
    puts "File found: #{filename}... Appending..."
    filename = filename
  elsif !File.exist?(filename)
    puts "Creating new file #{filename}"
    filename = filename
  end
  file = File.open(filename, 'a') do |file_opened|
    @students.each do |profile|
      csv_line = [profile[:name], profile[:cohort]].join(',')
      file_opened.puts csv_line
    end
  end
  puts "Saved #{@students.count} profiles into #{filename} |"
end

def load_students(filename = '')
  if File.exist?(filename)
    file = File.open(filename, 'r') do |file_opened|
      file_opened.each_line do |line|
        name, cohort = line.chomp.split(',')
        @students << { name: name, cohort: cohort.to_sym }
        end
    end
    puts "Loaded #{@students.count} profiles from #{filename} | File closed: #{file.closed?}"
  else
    puts "File: #{filename} does not exist"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
