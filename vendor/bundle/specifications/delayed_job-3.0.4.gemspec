# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "delayed_job"
  s.version = "3.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Griffin", "Brian Ryckbost", "Steve Richert", "Chris Gaffney", "Brandon Keepers", "Tobias L\u{fc}tke", "David Genord II"]
  s.date = "2012-11-09"
  s.description = "Delayed_job (or DJ) encapsulates the common pattern of asynchronously executing longer tasks in the background. It is a direct extraction from Shopify where the job table is responsible for a multitude of core tasks.\n\nThis gem is collectiveidea's fork (http://github.com/collectiveidea/delayed_job)."
  s.email = ["brian@collectiveidea.com"]
  s.extra_rdoc_files = ["README.textile"]
  s.files = ["README.textile"]
  s.homepage = "http://github.com/collectiveidea/delayed_job"
  s.rdoc_options = ["--main", "README.textile", "--inline-source", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Database-backed asynchronous priority queue system -- Extracted from Shopify"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_development_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_development_dependency(%q<actionmailer>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<activerecord>, ["~> 3.0"])
      s.add_dependency(%q<actionmailer>, ["~> 3.0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<activerecord>, ["~> 3.0"])
    s.add_dependency(%q<actionmailer>, ["~> 3.0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end
