# script autoloader
class Module
  def outername
    return @outer if @outer
    return '' if self.name == 'Object'

    self.name
  end

  def const_missing(name, outer = outername)
    key = "#{outer}::#{name}"
    dir = "Script/lib/#{key.underscore}"
    file = "#{dir}.rb"

    dputs "> #{dir}"

    if File.exist?(file)
      load_script(file)
      eval(key)
    elsif File.directory?(dir)
      cls = Module.new
      cls.instance_eval "@outer = '#{name}'"
      cls
    elsif outer.rindex('::') != nil
      # go up one level
      const_missing(name, outer[0...outer.rindex('::')])
    else
      super(name)
    end
  end
end
