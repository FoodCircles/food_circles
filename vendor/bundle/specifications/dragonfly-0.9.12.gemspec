# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dragonfly"
  s.version = "0.9.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Evans"]
  s.date = "2012-04-08"
  s.description = "Dragonfly is a framework that enables on-the-fly processing for any content type.\n  It is especially suited to image handling. Its uses range from image thumbnails to standard attachments to on-demand text generation."
  s.email = "mark@new-bamboo.co.uk"
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md"]
  s.homepage = "http://github.com/markevans/dragonfly"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Ideal gem for handling attachments in Rails, Sinatra and Rack applications."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 0"])
      s.add_development_dependency(%q<capybara>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_development_dependency(%q<cucumber-rails>, ["~> 0.5.2"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<fog>, [">= 0"])
      s.add_development_dependency(%q<github-markup>, [">= 0"])
      s.add_development_dependency(%q<mongo>, [">= 0"])
      s.add_development_dependency(%q<couchrest>, ["~> 1.0"])
      s.add_development_dependency(%q<rack-cache>, [">= 0"])
      s.add_development_dependency(%q<rails>, ["~> 3.1.0"])
      s.add_development_dependency(%q<redcarpet>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<bluecloth>, [">= 0"])
      s.add_development_dependency(%q<bson_ext>, [">= 0"])
      s.add_development_dependency(%q<sqlite3-ruby>, [">= 0"])
    else
      s.add_dependency(%q<rack>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
      s.add_dependency(%q<cucumber-rails>, ["~> 0.5.2"])
      s.add_dependency(%q<database_cleaner>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<fog>, [">= 0"])
      s.add_dependency(%q<github-markup>, [">= 0"])
      s.add_dependency(%q<mongo>, [">= 0"])
      s.add_dependency(%q<couchrest>, ["~> 1.0"])
      s.add_dependency(%q<rack-cache>, [">= 0"])
      s.add_dependency(%q<rails>, ["~> 3.1.0"])
      s.add_dependency(%q<redcarpet>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<bluecloth>, [">= 0"])
      s.add_dependency(%q<bson_ext>, [">= 0"])
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<cucumber>, ["~> 0.10.0"])
    s.add_dependency(%q<cucumber-rails>, ["~> 0.5.2"])
    s.add_dependency(%q<database_cleaner>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<fog>, [">= 0"])
    s.add_dependency(%q<github-markup>, [">= 0"])
    s.add_dependency(%q<mongo>, [">= 0"])
    s.add_dependency(%q<couchrest>, ["~> 1.0"])
    s.add_dependency(%q<rack-cache>, [">= 0"])
    s.add_dependency(%q<rails>, ["~> 3.1.0"])
    s.add_dependency(%q<redcarpet>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<bluecloth>, [">= 0"])
    s.add_dependency(%q<bson_ext>, [">= 0"])
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
  end
end
