@students = []

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each_with_index do |profile, index|
    puts "#{index+1}. #{profile[:name]} | Cohort: #{profile[:cohort]} "
  end
end

def print_specific_letter
  puts "Print student names starting with..."
  start_with = gets.chomp
  @students.each do |profiles|
    puts profiles[:name].capitalize if profiles[:name][0].downcase == start_with
  end
end

def print_shorter_than
  puts "Print student names with less characters than..."
  less_than = gets.chomp.to_i
  @students.each do |profile|
    p "#{profile[:name]} is less than #{less_than} characters long" if
        profile[:name].length < less_than
  end
end

def print_while
  puts "Until loops..."
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
  name = gets.chomp
  while !name.empty? do
    @students << {name: name, cohort: :november}
    puts "Now we have #{@students.count} students"
    name = gets.chomp
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
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save list of students to students.csv"
  puts "9. Exit"
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |profile|
    student_data = [profile[:name], profile[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu