require 'thread'

class Path

  def initialize(*args)
    @options              = args.last.is_a?(Hash) ? args.pop : {}
    @options[:recursive]  ||= false
    @entries              = build_entries(*args)
  end

  def find(arg)
    grep(/#{arg}/).first
  end

  def join(path)
    Path.new(find(path))
  end

  def grep(pattern)
    entries.grep(pattern)
  end

  def entries
    @entries ||= []
  end

  def push(*paths)
    entries.concat(build_entries(*paths)).uniq!
  end

  def pop(*args)
    args.each do |x|
      entries.delete_if {|y| File.expand_path(x) == y }
    end
  end

  private

  def dir(path)
    if @options[:recursive]
      Dir["#{path}/*"] + Dir["#{path}/**/*"]
    else
      Dir["#{path}/*"]
    end
  end

  def build_entries(*paths)
    paths.map{|path| dir(File.expand_path(path)) }.flatten.uniq
  end
  
end

def Path(*args)
  Path.new(*args)
end
