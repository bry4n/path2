$:.unshift "lib"

require 'path2'

path = Path("/usr/local/Library")

p path.find "Formula/bash"
