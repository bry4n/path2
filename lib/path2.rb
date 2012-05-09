require 'thread'

class Path

  def initialize(*args)
    @options              = args.last.is_a?(Hash) ? args.pop : {}
    @options[:recursive]  ||= false
    @options[:short]      ||= false
    @root                 = args.first
    @entries              = build_entries(@root)
  end

  def current
    File.expand_path(@root)
  end

  def exists?(path = nil)
    if path
      File.exists?([current, path].join("/"))
    else
      File.exists?(current)
    end
  end

  def reload
    Path.new(@root)
  end

  def find(arg)
    grep(/#{arg}/).first
  end

  def join(path)
    Path.new([@root, path].join("/"), @options)
  end

  def walk(path)
    yield Path.new([@root, path].join("/"), @options)
  ensure
    self
  end

  def grep(pattern)
    entries.grep(pattern)
  end

  def entries
    @entries ||= []
  end

  def push(*paths)
    paths.each do |path|
      entries.concat(Path.new(path).entries).uniq!
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

  def build_entries(path)
    path = File.expand_path(path) unless @options[:short]
    dir(path).uniq
  end
  
end

def Path(*args)
  Path.new(*args)
end
