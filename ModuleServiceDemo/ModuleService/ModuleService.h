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

- (void)handleOpenUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
