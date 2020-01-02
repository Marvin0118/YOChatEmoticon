//
//  YOChatBundle.m
//  ChatHall
//
//  Created by Marvin on 2019/4/15.
//  Copyright © 2019 IAN. All rights reserved.
//

#import "YOChatBundle.h"
#import "YOChatEmoticonGroup.h"
#import <YYModel/YYModel.h>
#import <YYCategories/YYCategories.h>

@implementation YOChatBundle

+ (NSBundle *)emoticonBundle {
    static NSBundle *bundle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *bundlePath = [[NSBundle bundleForClass:[YOChatBundle class]].resourcePath  stringByAppendingPathComponent:@"/ChatEmoticon.bundle"];
        bundle= [NSBundle bundleWithPath:bundlePath];
    });
    return bundle;
}

+ (NSRegularExpression *)regexEmoticon {
    static NSRegularExpression *regex;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"\\[[^ \\[\\]]+?\\]" options:kNilOptions error:NULL];
    });
    return regex;
}

+ (NSDictionary *)emoticonDic {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emoticonBundlePath = [[NSBundle bundleForClass:[YOChatBundle class]].resourcePath  stringByAppendingPathComponent:@"/ChatEmoticon.bundle"];
        dic = [self _emoticonDicFromPath:emoticonBundlePath];
    });
    return dic;
}

+ (NSMutableDictionary *)_emoticonDicFromPath:(NSString *)path {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    YOChatEmoticonGroup *group = nil;
    NSString *jsonPath = [path stringByAppendingPathComponent:@"info.json"];
    NSData *json = [NSData dataWithContentsOfFile:jsonPath];
    if (json.length) {
        group = [YOChatEmoticonGroup yy_modelWithJSON:json];
    }
    if (!group) {
        NSString *plistPath = [path stringByAppendingPathComponent:@"Info.plist"];
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        if (plist.count) {
            
            group = [YOChatEmoticonGroup yy_modelWithJSON:plist];
        }
    }
    for (YOChatEmoticon *emoticon in group.emoticons) {
        if (emoticon.png.length == 0) continue;
        NSString *pngPath = [path stringByAppendingPathComponent:emoticon.png];
        if (emoticon.chs) dic[emoticon.chs] = pngPath;
        if (emoticon.cht) dic[emoticon.cht] = pngPath;
    }

    NSArray *folders = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *folder in folders) {
        if (folder.length == 0) continue;
        NSDictionary *subDic = [self _emoticonDicFromPath:[path stringByAppendingPathComponent:folder]];
        if (subDic) {
            [dic addEntriesFromDictionary:subDic];
        }
    }
    return dic;
}

+ (NSArray<YOChatEmoticonGroup *> *)emoticonGroups {
    static NSMutableArray *groups;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *emoticonPlistPath = [YOChatBundle pathForResourceWith:@"emoticons.plist"];
        NSError *error = nil;        
        NSDictionary *plist = [NSDictionary dictionaryWithContentsOfFile:emoticonPlistPath];
        NSArray *packages = plist[@"packages"];
        groups = (NSMutableArray *)[NSArray yy_modelArrayWithClass:[YOChatEmoticonGroup class] json:packages];

        NSMutableDictionary *groupDic = [NSMutableDictionary new];
        for (int i = 0, max = (int)groups.count; i < max; i++) {
            YOChatEmoticonGroup *group = groups[i];
            if (group.groupID.length == 0) {
                [groups removeObjectAtIndex:i];
                i--;
                max--;
                continue;
            }
            
            NSString *fileName = [NSString stringWithFormat:@"%@/Info.plist",group.groupID];
            NSString *infoPlistPath = [YOChatBundle pathForResourceWith:fileName] ;
            NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:infoPlistPath];
            [group yy_modelSetWithDictionary:info];
            if (group.emoticons.count == 0) {
                i--;
                max--;
                continue;
            }
            groupDic[group.groupID] = group;
        }
    });
    return groups;
}

+ (NSString *)pathForResourceWith:(NSString *)fileName
{
    NSString *bundlePath = [[NSBundle bundleForClass:[YOChatBundle class]].resourcePath  stringByAppendingPathComponent:@"/ChatEmoticon.bundle"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",bundlePath,fileName];
    return filePath;
}

+ (NSString *)filePathWith:(NSString *)fileName ofType:(NSString *)ext
{
    NSBundle *bundle = [YOChatBundle emoticonBundle];
    return [bundle pathForScaledResource:fileName ofType:ext];
}

+ (UIImage *)imageNamed:(NSString *)imageName
{
    NSString *path = [YOChatBundle filePathWith:imageName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)imageWithPath:(NSString *)path {
    if (!path) return nil;
    UIImage *image = nil;
    if (path.pathScale == 1) {
        // 查找 @2x @3x 的图片
        NSArray *scales = [NSBundle preferredScales];
        for (NSNumber *scale in scales) {
            image = [UIImage imageWithContentsOfFile:[path stringByAppendingPathScale:scale.floatValue]];
            if (image) break;
        }
    } else {
        image = [UIImage imageWithContentsOfFile:path];
    }
    return image;
}

@end
