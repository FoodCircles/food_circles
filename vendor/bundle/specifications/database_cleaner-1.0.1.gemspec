# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "database_cleaner"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ben Mabey"]
  s.date = "2013-05-14"
  s.description = "Strategies for cleaning databases.  Can be used to ensure a clean state for testing."
  s.email = "ben@benmabey.com"
  s.extra_rdoc_files = ["LICENSE", "README.markdown", "TODO"]
  s.files = ["LICENSE", "README.markdown", "TODO"]
  s.homepage = "http://github.com/bmabey/database_cleaner"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Strategies for cleaning databases.  Can be used to ensure a clean state for testing."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
