require 'small/array'

class Path

  def initialize(*args)
    @options              = args.extract_options!
    @options[:recursive]  ||= false
    @options[:short]      ||= false
    @root                 = args.shift
    @entries              = tree
    args.each &method(:<<)
  end

  def current
    File.expand_path(@root)
  end

  def exists?(path = nil)
    File.exists?((path ? [current, path].join("/") : current))
  end

  def reload
    Path.new(@root, @options)
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

  def <<(*paths)
    paths.each do |path|
      entries.concat(Path.new(path, @options).tree).uniq!
    end
  end
  alias :push :<<

  def to_s
    current
  end

  def inspect
    "#<Path @root=\"#{current}\" @entries_size=\"#{entries.size}\">"
  end

  def tree(path = nil)
    tree = []
    raise "#{current} is not directory." unless File.directory?(current)
    Dir.foreach((path ||= (@options[:short] ? @root : current))) do |entry|
      next if ['..','.'].include?(entry)
      entry = File.join(path, entry)
      if @options[:recursive] && File.directory?(entry)
        tree << tree(entry)
      else
        tree << entry
      end
    end
    tree.flatten
  end

end

def Path(*args)
  Path.new(*args)
end
