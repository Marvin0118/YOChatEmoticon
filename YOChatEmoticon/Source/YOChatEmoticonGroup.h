//
//  YOChatEmoticonGroup.h
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//  表情管理器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YOChatEmoticonType) {
    YOChatEmoticonTypeImage = 0, ///< 图片表情
    YOChatEmoticonTypeEmoji = 1, ///< Emoji表情
};

@class YOChatEmoticonGroup;

@interface YOChatEmoticon : NSObject

@property (nonatomic, strong) NSString *chs;  ///< 例如 [吃惊]
@property (nonatomic, strong) NSString *cht;  ///< 例如 [吃驚]
@property (nonatomic, strong) NSString *gif;  ///< 例如 d_chijing.gif
@property (nonatomic, strong) NSString *png;  ///< 例如 d_chijing.png
@property (nonatomic, strong) NSString *code; ///< 例如 0x1f60d
@property (nonatomic, assign) YOChatEmoticonType type;
@property (nonatomic,   weak) YOChatEmoticonGroup *group;

+ (NSArray *)modelPropertyBlacklist;

@end

@interface YOChatEmoticonGroup : NSObject

@property (nonatomic, strong) NSString *groupID; ///< 例如 com.sina.default
@property (nonatomic, assign) NSInteger version;
@property (nonatomic, strong) NSString *nameCN; ///< 例如 浪小花
@property (nonatomic, strong) NSString *nameEN;
@property (nonatomic, strong) NSString *nameTW;
@property (nonatomic, assign) NSInteger displayOnly;
@property (nonatomic, assign) NSInteger groupType;
@property (nonatomic, strong) NSArray<YOChatEmoticon *> *emoticons;

+ (NSDictionary *)modelCustomPropertyMapper;
+ (NSDictionary *)modelContainerPropertyGenericClass;
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
