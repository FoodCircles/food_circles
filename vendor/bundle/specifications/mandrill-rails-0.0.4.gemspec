# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mandrill-rails"
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Paul Gallagher"]
  s.date = "2013-04-29"
  s.description = "Rails integration for Mandrill"
  s.email = ["gallagher.paul@gmail.com"]
  s.homepage = "https://github.com/evendis/mandrill-rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Provides webhook processing and event decoration to make using Mandrill with Rails just that much easier"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.3"])
      s.add_development_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_development_dependency(%q<guard-rspec>, ["~> 1.2.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0.3"])
      s.add_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.11"])
      s.add_dependency(%q<guard-rspec>, ["~> 1.2.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0.3"])
    s.add_dependency(%q<bundler>, [">= 1.1.0"])
    s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.11"])
    s.add_dependency(%q<guard-rspec>, ["~> 1.2.0"])
  end
end
