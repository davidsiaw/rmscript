if $DEBUG || $TEST
  # Create a console object and redirect standard output to it.
  Win32API.new('kernel32', 'AllocConsole', 'V', 'L').call
  $stdout.reopen('CONOUT$')
  # Find the game title.
  ini = Win32API.new('kernel32', 'GetPrivateProfileString','PPPPLP', 'L')
  title = "\0" * 256
  ini.call('Game', 'Title', '', title, 256, '.\\Game.ini')
  title.delete!("\0")
  # Set the game window as the top-most window.
  hwnd = Win32API.new('user32', 'FindWindowA', 'PP', 'L').call('RGSS Player', title)  
  Win32API.new('user32', 'SetForegroundWindow', 'L', 'L').call(hwnd)
  # Set the title of the console debug window'
  Win32API.new('kernel32','SetConsoleTitleA','P','S').call("#{title} :  Debug Console")
  # Draw the header, displaying current time.
  puts ('=' * 75, Time.now, '=' * 75, "\n")
    
  def p(*args)
    puts args.map {|x| x.inspect}
  end

  def dputs(*args)
    puts *args
  end

  def dp(*args)
    p *args
  end

else
  def dputs(*args)
  end

  def dp(*args)
  end
end
