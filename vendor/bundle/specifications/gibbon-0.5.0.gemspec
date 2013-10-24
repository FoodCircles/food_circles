# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gibbon"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Amro Mousa"]
  s.date = "2013-07-23"
  s.description = "A wrapper for MailChimp API 2.0 and Export API 1.0"
  s.email = ["amromousa@gmail.com"]
  s.homepage = "http://github.com/amro/gibbon"
  s.licenses = ["MIT"]
  s.post_install_message = "IMPORTANT: Gibbon now targets MailChimp API 2.0, which is substantially different from API 1.3.\n                             Please use Gibbon 0.4.6 if you need to use API 1.3.\nIf you're upgrading from <0.5.0 your code WILL break."
  s.require_paths = ["lib"]
  s.rubyforge_project = "gibbon"
  s.rubygems_version = "1.8.23"
  s.summary = "A wrapper for MailChimp API 2.0 and Export API 1.0"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<multi_json>, [">= 1.3.4"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
    else
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<multi_json>, [">= 1.3.4"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<multi_json>, [">= 1.3.4"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
  end
end
