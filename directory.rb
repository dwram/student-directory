require './loading_functions'
# require './saving_functions'
require './csv_save_functions'
require './printing_functions'
require './csv_load_functions'
@students = []

def input_students
  STDOUT.puts "Please enter the names of new students \nTo finish, just hit enter twice"
  STDOUT.puts '-------------'
  name = STDIN.gets.chomp
  until name.empty?
    @students << { name: name, cohort: :november }
    STDOUT.puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def reset
  STDOUT.puts 'Resetting student directory'
  @students = []
end

def show_students
  print_header
  print_students_list
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
    save_csv
  when '4'
    STDOUT.puts 'Enter the name of the file you wish to load'
    load_csv
  when '5'
    print_specific_letter
  when '6'
    print_shorter_than
  when '7'
    reset
  when '9'
    exit # this will cause the program to terminate
  else
    STDOUT.puts 'Enter was invalid, try again'
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
