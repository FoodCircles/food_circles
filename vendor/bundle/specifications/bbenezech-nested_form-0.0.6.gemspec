# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "bbenezech-nested_form"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.4") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Bates", "Andrea Singh"]
  s.date = "2012-03-30"
  s.description = "Gem to conveniently handle multiple models in a single form with Rails 3 and jQuery or Prototype. Version maintained by fxposter, with some patches aimed at RailsAdmin."
  s.email = "ryan@railscasts.com"
  s.homepage = "http://github.com/bbenezech/nested_form"
  s.require_paths = ["lib"]
  s.rubyforge_project = "bbenezech-nested_form"
  s.rubygems_version = "1.8.23"
  s.summary = "Gem to conveniently handle multiple models in a single form. Version maintained by fxposter, with some patches aimed at RailsAdmin."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec-rails>, ["~> 2.6.0"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
    else
      s.add_dependency(%q<rspec-rails>, ["~> 2.6.0"])
      s.add_dependency(%q<mocha>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec-rails>, ["~> 2.6.0"])
    s.add_dependency(%q<mocha>, [">= 0"])
  end
end
