

Pod::Spec.new do |s|


  s.name         = "DeviceInfor"
  s.version      = "0.0.1"
  s.summary      = "获取iPhone设备信息,模块的详细介绍:测试demo，为获取设备信息的工具"

  s.description  = <<-DESC
                    模块的详细介绍:测试demo，为获取设备信息的工具
                   DESC

  s.homepage     = "https://github.com/xiaoniu2014/DeviceInfor"

  s.license      = "MIT"

  s.author             = { "hongw" => "116445168@qq.com" }

  s.source       = { :git => "https://github.com/xiaoniu2014/DeviceInfor.git", :commit => "bdc237e2afff8f0a928af2bcfb9961ead55c5c1c" }

  s.source_files  = "DeviceInfor/Utility/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

end
