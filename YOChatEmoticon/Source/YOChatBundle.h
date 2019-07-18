//
//  YOChatBundle.h
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class YOChatEmoticonGroup;

@interface YOChatBundle : NSObject

+ (NSBundle *)emoticonBundle;

+ (NSRegularExpression *)regexEmoticon;

+ (NSDictionary *)emoticonDic;

+ (NSArray<YOChatEmoticonGroup *> *)emoticonGroups;

+ (UIImage *)imageNamed:(NSString *)imageName;

+ (UIImage *)imageWithPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
