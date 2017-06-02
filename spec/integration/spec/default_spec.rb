describe package("wget") do
  it { should be_installed }
end

describe package("wget"), dry_run: true do
  it { should_not be_installed }
end
