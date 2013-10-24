# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rack-pjax"
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gert Goet"]
  s.date = "2012-09-09"
  s.description = "Serve pjax responses through rack middleware"
  s.email = ["gert@thinkcreate.nl"]
  s.homepage = "https://github.com/eval/rack-pjax"
  s.require_paths = ["lib"]
  s.rubyforge_project = "rack-pjax"
  s.rubygems_version = "1.8.23"
  s.summary = "Serve pjax responses through rack middleware"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, ["~> 1.3"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.5"])
    else
      s.add_dependency(%q<rack>, ["~> 1.3"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<rack>, ["~> 1.3"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5"])
  end
end
