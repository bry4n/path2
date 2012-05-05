require 'thread'

class Path

  def initialize(*args)
    @id                   = generate_id
    @self                 = "path2_#{@id}"
    @semaphore            = Mutex.new
    @entries              = build_entries(*args)
    Thread.current[@self] = {}
  end

  def find(arg)
    cache("find_#{arg}") do
      grep(/#{arg}/)
    end
  end

  def grep(pattern)
    entries.grep(pattern)
  end

  def entries
    @entries ||= []
  end

  def push(*paths)
    @entries.concat(build_entries(*paths)).uniq!
  end

  def pop(*args)
    args.each do |x|
      @entries.delete_if {|y| File.expand_path(x) == y }
    end
  end

  private

  def dir(path)
    Dir["#{path}/**/*"]
  end

  def build_entries(*paths)
    @semaphore.synchronize {
      paths.map{|path| dir(File.expand_path(path)) }.flatten.uniq
    }
  end
  
  def cache(name, &block)
    _thread(name) || _thread(name, &block)
  end

  def _thread(name, &block)
    if block_given?
      Thread.current[@self][name] = block.call
    else
      Thread.current[@self][name]
    end
  end
  
  def generate_id
    Time.now.to_i
  end

end

def Path(*args)
  Path.new(*args)
end
