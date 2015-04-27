# Convert avi, mp4 and mkv files for AppleTV 2 preset
# The Story
# I have just downloaded a new movie into the uTorrent/Done folder and now I
# want to convert it for watching on my AppleTV 2
source_directory = '/Volumes/Media/uTorrent/Done'
completed_directory = '/Users/rick/uTorrent/Converted'
Dir.chdir(source_directory)
# The file could be mkv, avi or mp4 so I need to figure out which
possible_extensions = ['.mkv','.avi','.mp4']
preset_to_use = 'AppleTV 2'
# I need to take a list of all of the files in the directory and for each file
# determine if the extension is mkv, avi or mp4
source_files = Dir.glob("**/*")
source_files.each do |file|
  if possible_extensions.include? File.extname(file)
    new_file = File.split(file)[1].gsub(/[^0-9a-z.]/i, '.')
    File.rename(file, new_file)
    puts "Begin Handbrake of #{new_file}..."
    exec "/Users/rick/Handbrake/HandBrakeCLI -i '#{new_file}' -o '#{completed_directory}/#{new_file[0..-5]}_handbraked.mp4' --preset='#{preset_to_use}' -F --subtitle-burn" if fork.nil?
    puts "Handbrake is processing #{new_file}....."
    Process.wait
    puts "Handbrake process of #{new_file} is complete."
    File.delete(new_file)
  end
end
