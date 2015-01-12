Pod::Spec.new do |s|
  s.name         = "ILTesting"
  s.version      = "0.0.1"
  s.summary      = "Various helper classes to assist when testing for iOS and Mac OS X."
  s.homepage     = "https://github.com/InfiniteLoopDK/ILTesting"
  s.license      = "MIT"
  s.author       = "Claus Broch"
  s.source       = { :git => "https://github.com/InfiniteLoopDK/ILTesting.git", :commit => "d33c6dc00c10f8db39d1c44d2db5fbe5b3bc7e49" }
  s.source_files = "ILCannedURLProtocol.{h,m}"
  s.requires_arc = false
  s.frameworks   = "CoreGraphics"
  s.prefix_header_contents = "#import <CoreGraphics/CGBase.h>"
end
