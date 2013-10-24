# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rgeo-activerecord"
  s.version = "0.4.6"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Azuma"]
  s.date = "2012-12-12"
  s.description = "RGeo is a geospatial data library for Ruby. RGeo::ActiveRecord is an optional RGeo module providing some spatial extensions to ActiveRecord, as well as common tools used by RGeo-based spatial adapters."
  s.email = "dazuma@gmail.com"
  s.extra_rdoc_files = ["History.rdoc", "README.rdoc"]
  s.files = ["History.rdoc", "README.rdoc"]
  s.homepage = "http://dazuma.github.com/rgeo-activerecord"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "virtuoso"
  s.rubygems_version = "1.8.23"
  s.summary = "An RGeo module providing spatial extensions to ActiveRecord."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rgeo>, [">= 0.3.20"])
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.3"])
      s.add_runtime_dependency(%q<arel>, [">= 2.0.6"])
    else
      s.add_dependency(%q<rgeo>, [">= 0.3.20"])
      s.add_dependency(%q<activerecord>, [">= 3.0.3"])
      s.add_dependency(%q<arel>, [">= 2.0.6"])
    end
  else
    s.add_dependency(%q<rgeo>, [">= 0.3.20"])
    s.add_dependency(%q<activerecord>, [">= 3.0.3"])
    s.add_dependency(%q<arel>, [">= 2.0.6"])
  end
end
