//
//  ModuleProtocol.h
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/1.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const SUPPORT_MODULE_URLS =  @"supportModuleUrls";

@protocol ModuleProtocol <NSObject>

+ (NSArray*)supportModuleUrls;

@end

