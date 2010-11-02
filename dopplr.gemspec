# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dopplr}
  s.version = "0.2.0"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Richards"]
  s.date = %q{2009-08-09}
  s.summary = %q{A Ruby library for talking to the Dopplr API}
  s.homepage = %q{http://github.com/mikeric/dopplr}
  s.email = %q{mike22e@gmail.com}
  s.extra_rdoc_files = ["README.md"]
  s.require_paths = ["lib"]
  s.files = ["README.md",
             "lib/dopplr.rb",
             "lib/dopplr/base.rb",
             "lib/dopplr/city.rb",
             "lib/dopplr/oauth.rb",
             "lib/dopplr/place.rb",
             "lib/dopplr/search.rb",
             "lib/dopplr/search/city_search.rb",
             "lib/dopplr/search/place_search.rb",
             "lib/dopplr/traveller.rb",
             "lib/dopplr/traveller_place.rb",             
             "test/helpers.rb",
             "test/unit/base_test.rb",
             "test/unit/city_search_test.rb",
             "test/unit/city_test.rb",     
             "test/unit/oauth_test.rb",
             "test/unit/place_search_test.rb",
             "test/unit/place_test.rb",
             "test/unit/traveller_place_test.rb",
             "test/unit/traveller_test.rb"]
  
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
    
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 1.1.5"])
      s.add_development_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 1.1.5"])
      s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 1.1.5"])
    s.add_dependency(%q<thoughtbot-shoulda>, [">= 0"])
  end
end