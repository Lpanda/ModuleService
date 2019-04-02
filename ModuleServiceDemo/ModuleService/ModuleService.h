//
//  ModuleService.h
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/1.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModuleService : NSObject

+ (instancetype)sharedIntance;

// url为应用自身定义的urlScheme或配置好的跳转链接
// url和service解析方法名同"^"符号来链接，方便解析
- (void)handleOpenUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
