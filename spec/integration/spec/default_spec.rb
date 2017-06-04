describe package("zsh") do
  it { should be_installed }
end

describe package("zsh"), dry_run: true do
  it { should_not be_installed }
end
