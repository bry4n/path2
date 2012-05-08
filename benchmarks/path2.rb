$:.unshift "lib"

require 'small/benchmark'
require 'path2'

path = Path(".")
path2 = Path(".", :recursive => true)

p path.find "path2.gemspec"
p path.grep /path/

p path2.find "lib/path2.rb"
p path2.grep /lib/

benchmark do |b|
  
  b.report("path2#find (non-recursive)") do
    run 100_000 do
      path.find "path2.gemspec"
    end
  end

  b.report("path2#find (recursive)") do
    run 100_000 do
      path2.find "lib/path2.rb"
    end
  end

  b.report("path2#grep (non-recursive)") do
    run 100_000 do
      path.grep /path/
    end
  end

  b.report("path2#grep (recursive)") do
    run 100_000 do
      path2.grep /lib/
    end
  end

end
