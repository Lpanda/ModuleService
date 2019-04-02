//
//  NSString+Params.m
//  ModuleServiceDemo
//
//  Created by 杨帅 on 2019/4/2.
//  Copyright © 2019年 杨帅. All rights reserved.
//

#import "NSString+Params.h"

@implementation NSString (Params)

- (NSDictionary *)params {
    if (self.length == 0) {
        return nil;
    }
    
    NSURL *url = [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSArray *components = [url.query componentsSeparatedByString:@"&"];
    if (components.count == 0) {
        return nil;
    }
    
    NSMutableDictionary *params = @{}.mutableCopy;
    for (NSString *str in components) {
        NSArray *subComponents = [str componentsSeparatedByString:@"="];
        if (subComponents.count != 2) {
            continue;
        }
        NSString *key = subComponents[0];
        NSString *value = subComponents[1];
        if (!key || !value) {
            continue;
        }
        params[key] = [value stringByRemovingPercentEncoding];
    }
    return params;
}

@end
