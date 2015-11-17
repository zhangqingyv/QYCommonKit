#
#  Be sure to run `pod spec lint QYCommonKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "QYCommonKit"
  s.version      = "0.0.1"
  s.summary      = "A short description of QYCommonKit."

  s.description  = <<-DESC
                   A longer description of QYCommonKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/zhangqingyv/QYCommonKit"

  s.license      = "MIT"

  s.author             = { "Terry Zhang" => "zhangqingyu@gmail.com" }
  
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source       = { :git => "https://github.com/zhangqingyv/QYCommonKit.git" }

  s.source_files = '*/{QY}*.{h,m}'


end
