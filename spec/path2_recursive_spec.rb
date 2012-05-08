
require File.expand_path("../spec_helper", __FILE__)

describe Path do

  let(:path) { Path("/dummy", :recursive => true) }
  
  it "#entries" do
    path.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/spec", "/dummy/lib/dummy", "/dummy/lib/dummy/hello.rb"]
  end

  it "#find" do
    path.find("hello.rb").should == "/dummy/lib/dummy/hello.rb"
  end

  it "#grep" do
    path.grep(/dummy$/).should == ["/dummy/lib/dummy"]
  end

end
