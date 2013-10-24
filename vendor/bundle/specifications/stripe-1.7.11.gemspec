# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "stripe"
  s.version = "1.7.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ross Boucher", "Greg Brockman"]
  s.date = "2013-02-21"
  s.description = "Stripe is the easiest way to accept payments online.  See https://stripe.com for details."
  s.email = ["boucher@stripe.com", "gdb@stripe.com"]
  s.executables = ["stripe-console"]
  s.files = ["bin/stripe-console"]
  s.homepage = "https://stripe.com/api"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby bindings for the Stripe API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, ["~> 1.4"])
      s.add_runtime_dependency(%q<multi_json>, ["< 2", ">= 1.0.4"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<rest-client>, ["~> 1.4"])
      s.add_dependency(%q<multi_json>, ["< 2", ">= 1.0.4"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<rest-client>, ["~> 1.4"])
    s.add_dependency(%q<multi_json>, ["< 2", ">= 1.0.4"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
