Pod::Spec.new do |s|
  s.name 		   	  = "BSErrorMessageView"
  s.version 		  = "1.1"
  s.summary      	= "Error message view for text field"
  s.homepage     	= "https://github.com/BenjaminSarkisyan/BSErrorMessageView"
  s.author       	= { "Beniamin Sarkisyan" => "beniamin.sarkisyan@gmail.com" }
  s.platform     	= :ios, "6.0"
  s.source        = { :git => "https://github.com/BenjaminSarkisyan/BSErrorMessageView.git" }
  s.source_files  = 'Source/*.{h,m}'
  s.resources     = "Source/BSResources.bundle"
  s.requires_arc 	= true
end