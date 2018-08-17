Pod::Spec.new do |s|

  s.name          = "KFBlankSlate"
  s.version       = "1.0"
  s.summary       = "showing the custom view for empty/loading/network error, based on DZNEmptyDataSet."
  s.homepage      = "https://github.com/moliya/KFBlankSlate"
  s.license       = "MIT"
  s.author        = {'Carefree' => '946715806@qq.com'}
  s.source        = { :git => "https://github.com/moliya/KFBlankSlate.git", :tag => s.version}
  s.source_files  = "KFBlankSlate/*.{h,m}"
  s.requires_arc  = true
  s.platform      = :ios, '8.0'

  s.dependency "DZNEmptyDataSet"
end
