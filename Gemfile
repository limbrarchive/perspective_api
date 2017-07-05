source "https://rubygems.org"

gemspec

# Latest commits are frozen-string-literal friendly.
%w[
  rspec
  rspec-core
  rspec-expectations
  rspec-mocks
  rspec-support
].each do |library|
  gem library, :git => "https://github.com/rspec/#{library}.git"
end

# Unmerged pull requests for frozen string literals.
%w[
  addressable
  parser
  webmock
].each do |library|
  gem library,
    :git    => "https://github.com/pat/#{library}.git",
    :branch => "frozen-string-literals"
end
