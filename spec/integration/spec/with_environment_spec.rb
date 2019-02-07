describe file("/tmp/foo.txt") do
  its(:content) { should eq "FOO=foo" }
end
