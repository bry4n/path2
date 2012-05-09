require 'small/array'

class Path

  def initialize(*args)
    @options              = args.extract_options!
    @options[:recursive]  ||= false
    @options[:short]      ||= false
    @root                 = (args.shift || Dir.pwd)
    @entries              = tree
    args.each &method(:<<)
  end

  def recursive!
    @options[:recursive] = true
    reload!
  end

  def size
    directory? ? entries.size : File.size(current)
  end

  def file?
    !directory?
  end

  def stat
    File.stat(current)
  end

  def directory?
    File.directory?(current)
  end 

  def dirname
    directory? ? current : File.dirname(current)
  end

  def basename
    File.basename(current)
  end

  def split
    File.split(current)
  end

  def current
    File.expand_path(@root)
  end

  def exists?(path = nil)
    File.exists?((path ? [current, path].join("/") : current))
  end

  def reload!
    @entries = tree
  end

  def reload
    Path.new(@root, @options)
  end

  def find(arg)
    grep(/#{arg}/).first
  end
  
  def grep(pattern)
    entries.grep(pattern)
  end

  def join(path)
    Path.new([@root, path].join("/"), @options)
  end

  def walk(path)
    yield join(path)
  ensure
    self
  end

  def entries
    @entries ||= []
  end

  def push(*paths)
    paths.each do |path|
      entries.concat(Path.new(path, @options).tree).uniq!
    end
  end
  alias :<< :push

  def ignore(path)
    reject(/#{path}/)
  end

  def reject(pattern)
    @entries = (entries - grep(pattern))
    self
  end

  def to_s
    current
  end

  def inspect
    "#<Path @root=\"#{current}\" >"
  end

  def tree(path = nil)
    tree = []
    Dir.foreach((path ||= (@options[:short] ? @root : dirname))) do |entry|
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
