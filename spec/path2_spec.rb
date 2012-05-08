require File.expand_path("../spec_helper", __FILE__)

describe Path do

  let(:path) { Path("/dummy") }
  
  it "#entries" do
    path.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/spec"]
  end

  it "#find" do
    path.find("spec").should == "/dummy/spec"
  end

  it "#grep" do
    path.grep(/lib$/).should == ["/dummy/lib"]
  end

end
