# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "activerecord-postgis-adapter"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Daniel Azuma"]
  s.date = "2012-12-12"
  s.description = "This is an ActiveRecord connection adapter for PostGIS. It is based on the stock PostgreSQL adapter, but provides built-in support for the spatial extensions provided by PostGIS. It uses the RGeo library to represent spatial data in Ruby."
  s.email = "dazuma@gmail.com"
  s.extra_rdoc_files = ["History.rdoc", "README.rdoc"]
  s.files = ["History.rdoc", "README.rdoc"]
  s.homepage = "http://dazuma.github.com/activerecord-postgis-adapter"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "virtuoso"
  s.rubygems_version = "1.8.23"
  s.summary = "An ActiveRecord adapter for PostGIS, based on RGeo."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rgeo-activerecord>, ["~> 0.4.6"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<rgeo-activerecord>, ["~> 0.4.6"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<rgeo-activerecord>, ["~> 0.4.6"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end
