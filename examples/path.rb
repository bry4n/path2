$:.unshift "lib"

require 'path2'

path = Path("/usr/local/Library", recursive: false)

p path.join("Formula").find "bash"
