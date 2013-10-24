# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rails_admin"
  s.version = "0.0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Erik Michaels-Ober", "Bogdan Gaza", "Petteri Kaapa", "Benoit Benezech"]
  s.date = "2012-06-30"
  s.description = "RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data."
  s.email = ["sferik@gmail.com", "bogdan@cadmio.org", "petteri.kaapa@gmail.com"]
  s.homepage = "https://github.com/sferik/rails_admin"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Admin for Rails"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bbenezech-nested_form>, ["~> 0.0.6"])
      s.add_runtime_dependency(%q<sass-rails>, ["~> 3.1"])
      s.add_runtime_dependency(%q<bootstrap-sass>, [">= 2.0.3", "~> 2.0"])
      s.add_runtime_dependency(%q<jquery-ui-rails>, ["< 2", ">= 0.5"])
      s.add_runtime_dependency(%q<builder>, ["~> 3.0"])
      s.add_runtime_dependency(%q<coffee-rails>, ["~> 3.1"])
      s.add_runtime_dependency(%q<haml>, ["~> 3.1"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 1.0.17"])
      s.add_runtime_dependency(%q<kaminari>, ["~> 0.12"])
      s.add_runtime_dependency(%q<rack-pjax>, ["~> 0.5"])
      s.add_runtime_dependency(%q<rails>, ["~> 3.1"])
      s.add_runtime_dependency(%q<remotipart>, ["~> 1.0"])
      s.add_development_dependency(%q<cancan>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<carrierwave>, [">= 0"])
      s.add_development_dependency(%q<database_cleaner>, ["~> 0.8"])
      s.add_development_dependency(%q<devise>, [">= 0"])
      s.add_development_dependency(%q<dragonfly>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, ["~> 2.6"])
      s.add_development_dependency(%q<generator_spec>, [">= 0"])
      s.add_development_dependency(%q<launchy>, [">= 0"])
      s.add_development_dependency(%q<mini_magick>, [">= 0"])
      s.add_development_dependency(%q<paperclip>, ["~> 2.7"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
    else
      s.add_dependency(%q<bbenezech-nested_form>, ["~> 0.0.6"])
      s.add_dependency(%q<sass-rails>, ["~> 3.1"])
      s.add_dependency(%q<bootstrap-sass>, [">= 2.0.3", "~> 2.0"])
      s.add_dependency(%q<jquery-ui-rails>, ["< 2", ">= 0.5"])
      s.add_dependency(%q<builder>, ["~> 3.0"])
      s.add_dependency(%q<coffee-rails>, ["~> 3.1"])
      s.add_dependency(%q<haml>, ["~> 3.1"])
      s.add_dependency(%q<jquery-rails>, [">= 1.0.17"])
      s.add_dependency(%q<kaminari>, ["~> 0.12"])
      s.add_dependency(%q<rack-pjax>, ["~> 0.5"])
      s.add_dependency(%q<rails>, ["~> 3.1"])
      s.add_dependency(%q<remotipart>, ["~> 1.0"])
      s.add_dependency(%q<cancan>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<carrierwave>, [">= 0"])
      s.add_dependency(%q<database_cleaner>, ["~> 0.8"])
      s.add_dependency(%q<devise>, [">= 0"])
      s.add_dependency(%q<dragonfly>, [">= 0"])
      s.add_dependency(%q<factory_girl>, ["~> 2.6"])
      s.add_dependency(%q<generator_spec>, [">= 0"])
      s.add_dependency(%q<launchy>, [">= 0"])
      s.add_dependency(%q<mini_magick>, [">= 0"])
      s.add_dependency(%q<paperclip>, ["~> 2.7"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<timecop>, [">= 0"])
    end
  else
    s.add_dependency(%q<bbenezech-nested_form>, ["~> 0.0.6"])
    s.add_dependency(%q<sass-rails>, ["~> 3.1"])
    s.add_dependency(%q<bootstrap-sass>, [">= 2.0.3", "~> 2.0"])
    s.add_dependency(%q<jquery-ui-rails>, ["< 2", ">= 0.5"])
    s.add_dependency(%q<builder>, ["~> 3.0"])
    s.add_dependency(%q<coffee-rails>, ["~> 3.1"])
    s.add_dependency(%q<haml>, ["~> 3.1"])
    s.add_dependency(%q<jquery-rails>, [">= 1.0.17"])
    s.add_dependency(%q<kaminari>, ["~> 0.12"])
    s.add_dependency(%q<rack-pjax>, ["~> 0.5"])
    s.add_dependency(%q<rails>, ["~> 3.1"])
    s.add_dependency(%q<remotipart>, ["~> 1.0"])
    s.add_dependency(%q<cancan>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<carrierwave>, [">= 0"])
    s.add_dependency(%q<database_cleaner>, ["~> 0.8"])
    s.add_dependency(%q<devise>, [">= 0"])
    s.add_dependency(%q<dragonfly>, [">= 0"])
    s.add_dependency(%q<factory_girl>, ["~> 2.6"])
    s.add_dependency(%q<generator_spec>, [">= 0"])
    s.add_dependency(%q<launchy>, [">= 0"])
    s.add_dependency(%q<mini_magick>, [">= 0"])
    s.add_dependency(%q<paperclip>, ["~> 2.7"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<timecop>, [">= 0"])
  end
end
