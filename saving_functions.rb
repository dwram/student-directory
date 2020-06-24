# DEPRECATED
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
