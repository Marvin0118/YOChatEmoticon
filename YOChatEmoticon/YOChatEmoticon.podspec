Pod::Spec.new do |s|
    s.name         = "YOChatEmoticon"
    s.version      = "1.0.0"
    s.summary      = "yun orangesky"
    s.homepage     = "https://www.baidu.com"
    s.license      = "MIT"
    s.author       = { "Marvin" => "yun.orangesky@gmail.com" }
    s.social_media_url = "https://www.baidu.com"
    s.platform     = :ios, '8.0'
    s.source       = { :git => "https://orangesky.visualstudio.com/DefaultCollection/Lottery139/_git/Lottery139", :branch => 'feature/ZQ/Module' }

    s.source_files  = 'Source', 'Source/**/*.{h,m,mm}'
    s.resource_bundles = {
      'ChatEmoticon' => ['Source/**/*.bundle/**.*']
    }
    s.public_header_files = "Source/**/*.h"
    s.requires_arc = true
    s.frameworks =  'UIKit','Foundation','AVFoundation';
    s.dependency 'YYCategories'
    s.dependency 'YYText'
    s.dependency 'YYModel'
    s.dependency 'SDWebImage'

end
