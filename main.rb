#==============================================================================
# ** Main
#------------------------------------------------------------------------------
#  After defining each class, actual processing begins here.
#==============================================================================

def load_script(name)
  script = File.read(name)
  eval script, binding, name
end

begin
  load_script('Script/prelude/debug.rb')
  load_script('Script/prelude/string.rb')
  load_script('Script/prelude/autoloader.rb')

  # Prepare for transition
  Graphics.freeze
  # Make scene object (title screen)
  $scene = Rmxp::Scene_Title.new
  # Call main method as long as $scene is effective
  while $scene != nil
    $scene.main
  end
  # Fade out
  Graphics.transition(20)
rescue Errno::ENOENT
  # Supplement Errno::ENOENT exception
  # If unable to open file, display message and end
  filename = $!.message.sub("No such file or directory - ", "")
  print("Unable to find file #{filename}.")
rescue => e
  p e
  open('log.txt', 'w') { |f|
    f.puts e
    f.puts e.backtrace
  }
  puts e.backtrace
  raise "Oh my god. This was not supposed to happen. Tell astrobunny about this"
end
