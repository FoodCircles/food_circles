# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rack-mini-profiler"
  s.version = "0.1.26"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Saffron", "Robin Ward", "Aleks Totic"]
  s.date = "2013-04-11"
  s.description = "Profiling toolkit for Rack applications with Rails integration. Client Side profiling, DB profiling and Server profiling."
  s.email = "sam.saffron@gmail.com"
  s.extra_rdoc_files = ["Ruby/README.md", "Ruby/CHANGELOG"]
  s.files = ["Ruby/README.md", "Ruby/CHANGELOG"]
  s.homepage = "http://miniprofiler.com"
  s.require_paths = ["Ruby/lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Profiles loading speed for rack applications."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
      s.add_development_dependency(%q<activerecord>, ["~> 3.0"])
    else
      s.add_dependency(%q<rack>, [">= 1.1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
      s.add_dependency(%q<activerecord>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
    s.add_dependency(%q<activerecord>, ["~> 3.0"])
  end
end
