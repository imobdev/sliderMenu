Pod::Spec.new do |s|
  s.name             = "sliderMenu"
  s.version          = "0.1.1"
  s.summary          = "left slider Menu."
 
  s.description      = <<-DESC
The sliderMenu  enables you to  easily make left slider menu!
                       DESC
 
  s.homepage         = 'https://github.com/imobdev/sliderMenu'
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Rajat Agarwal" => "rajat91agarwal@gmail.com" }
  s.source           = { :git => 'https://github.com/imobdev/sliderMenu.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'sliderMenu/*.{swift,h}'
  s.resources = "sliderMenu/*.{xib}"
 
end