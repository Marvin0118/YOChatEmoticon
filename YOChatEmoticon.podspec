Pod::Spec.new do |s|
    s.name         = "YOChatEmoticon"
    s.version      = "1.0.3"
    s.summary      = "Marvin0118"
    s.homepage     = "https://github.com/Marvin0118"
    s.license      = "MIT"
    s.author       = { "Marvin" => "yun.orangesky@gmail.com" }
    s.social_media_url = "https://github.com/Marvin0118"
    s.platform     = :ios, '12.0'
    s.source       = { :git => "https://github.com/Marvin0118/YOChatEmoticon.git", :tag => s.version.to_s }

    s.source_files  = 'YOChatEmoticon/Source/**/*.{h,m,mm}'
    s.resource_bundles = {
      'ChatEmoticon' => ['YOChatEmoticon/Source/**/*.bundle/**.*']
    }
    s.public_header_files = "YOChatEmoticon/Source/**/*.h"
    s.requires_arc = true
    s.frameworks =  'UIKit','Foundation','AVFoundation';
    s.dependency 'YYCategories'
    s.dependency 'YYText'
    s.dependency 'YYModel'
    s.dependency 'SDWebImage'

end
