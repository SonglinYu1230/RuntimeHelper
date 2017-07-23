//
//  NSObject+RuntimeHelper.h
//  RuntimeHelper
//
//  Created by why001 on 19/07/2017.
//  Copyright © 2017 why001. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeHelper)

- (Class)mm_metaClass;

- (Class)mm_isa;

- (NSString *)mm_name;

- (int)mm_version;

- (size_t)mm_instanceSize;

- (NSArray *)mm_ivars;

- (NSDictionary *)mm_ivarsInfo;

+ (NSArray *)mm_allProperties;

+ (NSDictionary *)mm_allPropertiesInfo;

+ (NSArray *)mm_methodList;

@end
