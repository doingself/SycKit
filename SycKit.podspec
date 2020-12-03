#
#  Be sure to run `pod spec lint SycKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #
  spec.name         = "SycKit"
  spec.version      = "0.0.1"
  # 简要描述
  spec.summary      = "封装一些常用方法."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  # 详细描述
  spec.description  = <<-DESC
  封装一些常用方法. 所有内容通过 `yc` 进行调用.
                   DESC

  spec.homepage     = "https://github.com/doingself/SycKit"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #
  spec.author             = { "syc" => "daviondk@163.com" }
  # Or just: spec.author    = "syc"
  # spec.authors            = { "syc" => "daviondk@163.com" }
  # spec.social_media_url   = "https://twitter.com/syc"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #
  # 最低支持 iOS 版本
  spec.platform = :ios, "12.0"
  # spec.platform     = :ios
  # spec.platform     = :ios, "5.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #
  # git 仓库
  spec.source       = { :git => "https://github.com/doingself/SycKit.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #
  # 需要包含的源文件
  #'*'表示匹配所有文件
  #'*.{h,m}' 表示匹配所有以.h和.m结尾的文件
  #'**' 表示匹配所有子目录
  # spec.source_files  = 'SycKit/Classes/**/*', "SycKit/Classes/**/*.{h,m}"
  # spec.exclude_files = "Classes/Exclude"
  # spec.public_header_files = "Classes/**/*.h"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #
  # 资源文件
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"
  # spec.resource_bundles = "Resources/*.bundle"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
  # 依赖的非系统库
  # spec.vendored_frameworks = 'XXXX/*.framework'
  # spec.vendored_libraries = 'XXXX/*.a'
  # 依赖的系统库
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"
  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.
  
  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
  # 是否支持ARC
  #spec.requires_arc = true
  
  # 如果使用 use_frameworks! 指定时，pod 应包含静态库框架
  # 由于需要依赖的三方库都是静态库,如果这里不指定本库为静态库
  # 则cocoapods中默认会编译成动态库,而此动态库中依赖了静态库,会导致编译失败, 因此这里需要指定编译成静态库
  #spec.static_framework = true
  
  # 是否已弃用该库
  #spec.deprecated = false
  
  # 依赖的第三方库
  # spec.dependency "JSONKit", "~> 1.4"
  
  spec.swift_version = '5.0'
  
  # 默认加载 Core, 不设置则加载全部
  spec.default_subspecs = 'Core'
  
  spec.subspec 'Core' do |ss|
      ss.source_files  = [
      'SycKit/Classes/SycCore/**/*',
      "SycKit/Classes/SycCore/**/*.{swift,h,m,plist}"
      ]
  end
  
  spec.subspec 'Foundation' do |ss|
      ss.source_files  = [
      'SycKit/Classes/SycFoundation/**/*',
      "SycKit/Classes/SycFoundation/**/*.{swift,h,m,plist}"
      ]
      ss.dependency 'SycKit/Core'
  end
  
  spec.subspec 'UI' do |ss|
      ss.source_files  = [
      'SycKit/Classes/SycUI/**/*',
      "SycKit/Classes/SycUI/**/*.{swift,h,m,plist}"
      ]
      
      # 指定资源,比如xib,图片等资源都是
      ss.resource_bundles = {
          'SycKit' => [
          'SycKit/Classes/SycUI/**/*.{storyboard,xib,cer,json,plist}',
          'SycKit/Assets/*.{bundle,xcassets,imageset,png}', # 图片
          'SycKit/Assets/Localizable/*.lproj' # 国际化
          ]
      }
      
      ss.frameworks = 'UIKit'
      ss.dependency 'SycKit/Core'
      #ss.dependency 'AFNetworking', '~> 2.3'
  end
  
end
