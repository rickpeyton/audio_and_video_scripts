puts 'What directory contains the files you wish to concatenate?'
source_directory = gets.chomp.to_s
Dir.chdir(source_directory)
puts 'What is the file extension of the files you wish to concatenate?'
source_extension = gets.chomp.to_s
puts 'What would you like to name your new file?'
new_name = gets.chomp.to_s
#Remove all non-special characters from file names
source_files = Dir.glob("**/*.{#{source_extension}}")
source_files_renamed = []
source_files.each do |file|
  new_file = file.gsub(/[^0-9a-z. ]/i, '')
  File.rename("#{file}", "#{new_file}")
end
source_files = Dir.glob("**/*.{#{source_extension}}")

File.open("mylist.txt", "w") do |file|
  file.puts '# My concat list'
  source_files.each do |source|
    file.puts "file '#{source_directory}/#{source}'"
  end
end
exec "ffmpeg -f concat -i mylist.txt -c copy #{new_name}.#{source_extension}"
