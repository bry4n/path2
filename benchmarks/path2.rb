$:.unshift "lib"

require 'small/benchmark'
require 'path2'

path = Path(".")
path2 = Path(".", :recursive => true)

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

  b.report("path#walk (non-recursive)") do
    run 100_000 do
      path.walk "lib" do |path|
        path.find "path2.rb"
      end
    end
  end

  b.report("path#walk (recursive)") do
    run 100_000 do
      path2.walk "lib" do |path|
        path2.find "path2.rb"
      end
    end
  end

  b.report("path#join (non-recursive)") do
    run 100_000 do
      path.join("lib").find "path2.rb"
    end
  end

  b.report("path#join (recursive)") do
    run 100_000 do
      path2.join("lib").find "path2.rb"
    end
  end

end
