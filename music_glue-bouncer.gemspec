Gem::Specification.new do |s|
  s.name = %q{music_glue-bouncer}
  s.version = "0.4.3"

  s.authors = ["Jonathan Dance", "Adam Carlile"]
  s.email = ["jd@heroku.com", "adam@musicglue.com"]
  s.homepage = "https://github.com/adamcarlile/music_glue-bouncer"
  s.description = "ID please."
  s.summary = "Rapidly add MusicGlue OAuth to your Ruby app."
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = Dir.glob("{lib,spec}/**/*").concat([
    "README.md",
    "Gemfile",
    "Rakefile",
  ])
  s.require_paths = ["lib"]
  s.test_files = Dir.glob("spec/**/*").concat([
    "Gemfile",
    "Rakefile",
  ])
  s.license = 'MIT'

  s.add_runtime_dependency("omniauth-music_glue", [">= 0.1.0"])
  s.add_runtime_dependency("sinatra", ["~> 1.0"])
  s.add_runtime_dependency("faraday", ["~> 0.8"])
  s.add_runtime_dependency("rack", ["~> 1.0"])

  s.add_development_dependency("rake")
  s.add_development_dependency("minitest", "~> 5.0")
  s.add_development_dependency("minitest-spec-context")
  s.add_development_dependency("rack-test")
  s.add_development_dependency("mocha")
  s.add_development_dependency("delorean")
end
