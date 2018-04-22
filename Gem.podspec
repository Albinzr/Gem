Pod::Spec.new do |s|
  s.name         = "Gem"
  s.version      = "1.0.2"
  s.summary      = "An extreme light weight system with high performance for managing all api calls in app with closure"
  s.homepage     = "https://github.com/Albinzr/Gem"
  s.license      = 'MIT'
  s.author       = { "Albin CR" => "albinzr@gmail.com" }
  s.source       = { :git => "https://github.com/Albinzr/Gem.git", :tag => "#{s.version}" }
  s.swift_version ="4.1"
  s.requires_arc = true
  s.platform     = :ios, '10.0'

  s.source_files  = "Gem", "Gem/**/*.swift"
  
end