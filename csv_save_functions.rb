require 'csv'
# TODO: Save should not contain duplicates
# SAVE METHODS

def save_csv
  file_name = select_csv
  STDOUT.puts 'Initialising save...'
  saving = CSV.open("./#{file_name}", 'ab') do |file|
    @students.each do |profile|
      row = [profile[:name], profile[:cohort]]
      file << row
    end
  end
  STDOUT.puts "Saved #{@students.count} profiles into #{file_name}."
end

def select_csv
  STDOUT.puts 'SAVE: Please enter filename/leave empty to use default students.csv'
  file_name = STDIN.gets.chomp
  file_name += '.csv'
  if file_name.empty? || file_name == '.csv'
    puts "No file selected, using default: #{file_name}... Appending..."
    return 'students.csv'
  elsif File.exist?(file_name)
    STDOUT.puts "File found: #{file_name}... Appending..."
    return file_name
  elsif !File.exist?(file_name)
    STDOUT.puts "Creating new file #{file_name}"
    return file_name
  end
end
