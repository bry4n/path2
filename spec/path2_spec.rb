require File.expand_path("../spec_helper", __FILE__)

describe Path do

  let(:path) { Path("/dummy") }
  
  it "#current" do
    path.current.should == "/dummy"
  end

  it "#entries" do
    path.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/spec"]
  end

  it "#find" do
    path.find("spec").should == "/dummy/spec"
  end

  it "#grep" do
    path.grep(/lib$/).should == ["/dummy/lib"]
  end

  it "#join" do
    path.join("lib").should be_kind_of(Path)
    path.join("lib").current.should == "/dummy/lib"
  end

  it "#walk" do
    expect { path.walk("lib") }.to raise_error(LocalJumpError)
    path.current.should == "/dummy"
    path.walk("lib") do |path|
      path.current.should == "/dummy/lib"
    end
    path.current.should == "/dummy"
  end

  it "#exists?" do
    path.exists?.should be_true
    path.exists?("lib").should be_true
    path.exists?("blah").should be_false
  end

  it "#reload" do
    path.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/spec"]
    FileUtils.touch "/dummy/reload.rb"
    path.reload.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/reload.rb", "/dummy/spec"]
  end

  it "#push" do
    path.reload.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/reload.rb", "/dummy/spec"]
    FileUtils.mkdir_p "/dummy2"
    FileUtils.mkdir_p "/dummy2/push"
    path.push "/dummy2"
    path.entries.should == ["/dummy/.vim", "/dummy/bin", "/dummy/lib", "/dummy/reload.rb", "/dummy/spec", "/dummy2/push"]
  end

end
