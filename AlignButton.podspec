Pod::Spec.new do |s|

s.name         = "AlignButton"
s.version      = "1.1"
s.summary      = "UIButton文字和图片布局 for ios."
s.description  = <<-DESC
        UIButton文字和图片适配上下左右布局的控件
                DESC
s.homepage     = "https://github.com/yuankai01/AlignButton"
s.license          = { :type => "MIT", :file => "LICENSE" }
s.author       = { "yuankai01" => "735285388@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/yuankai01/AlignButton.git", :tag => s.version }
s.source_files = "AlignButton/*"
#s.framework    = "UIKit"
s.requires_arc = true

# s.frameworks = "SomeFramework", "AnotherFramework"

end
