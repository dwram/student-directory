require 'csv'

# LOAD FUNCTIONS

def load_csv
  file_name = select_csv
  loader(file_name)
end

def loader(file_name)
  count = 0
  if File.exist?(file_name)
    CSV.foreach("./#{file_name}", 'r') do |row|
      name, cohort = row
      @students << { name: name, cohort: cohort.to_sym }
      count += 1
    end
    STDOUT.puts "Loaded #{count} students from file #{file_name}."
    STDOUT.puts "Added #{count} students: #{@students.size} students currently held." if count < @students.size
  else
    STDOUT.puts "ERR: #{file_name} does not exist."
  end
end