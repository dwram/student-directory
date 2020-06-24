def try_load_students
  if ARGV.empty?
    file_name = 'students.csv'
    puts "No argument provided: Loading default file... #{file_name}"
  elsif !ARGV.empty?
    file_name = ARGV.first
    puts "File argument provided: Attempting to load... #{file_name}"
  end

  if File.exist?(file_name)
    load_students(file_name,1)
    #puts "Successfully imported #{@students.count} students from #{file_name}."
  else
    puts "File: #{file_name} does not exist."
    exit
  end
end

def load_students(filename = '', mode)
  if mode == 1
    if File.exist?(filename)
      file = File.open(filename, 'r') do |file_opened|
        file_opened.each_line do |line|
          name, cohort = line.chomp.split(',')
          @students << { name: name, cohort: cohort.to_sym }
        end
      end
      puts "Mode (#{mode}) | Loaded #{@students.count} profiles from #{filename} | File closed: #{file.closed?}"
    else
      puts "File: #{filename} does not exist"
    end
  end
end
