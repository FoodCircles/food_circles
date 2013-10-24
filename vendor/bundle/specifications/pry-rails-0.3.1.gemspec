# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pry-rails"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Robin Wenglewski"]
  s.date = "2013-06-07"
  s.email = ["robin@wenglewski.de"]
  s.homepage = "https://github.com/rweng/pry-rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Use Pry as your rails console"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pry>, [">= 0.9.10"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<rr>, [">= 0"])
    else
      s.add_dependency(%q<pry>, [">= 0.9.10"])
      s.add_dependency(%q<appraisal>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<rr>, [">= 0"])
    end
  else
    s.add_dependency(%q<pry>, [">= 0.9.10"])
    s.add_dependency(%q<appraisal>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<rr>, [">= 0"])
  end
end
