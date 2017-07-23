//
//  NSObject+RuntimeHelper.m
//  RuntimeHelper
//
//  Created by why001 on 19/07/2017.
//  Copyright © 2017 why001. All rights reserved.
//

#import "NSObject+RuntimeHelper.h"
#import <objc/runtime.h>

@implementation NSObject (RuntimeHelper)

static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    printf("attributes=%s\n", attributes);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

- (Class)mm_metaClass {
    return objc_getMetaClass([NSStringFromClass([self class]) UTF8String]);
}

- (Class)mm_isa {
    return objc_getClass([NSStringFromClass([self class]) UTF8String]);
}

- (NSString *)mm_name {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

- (int)mm_version {
    return class_getVersion([self class]);
}

- (size_t)mm_instanceSize {
    return class_getInstanceSize([self class]);
}

- (NSArray *)mm_ivars {
    unsigned int varCount;
    
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    NSMutableArray *ivarsList = [NSMutableArray new];
    for (int i = 0; i < varCount; i++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        [ivarsList addObject:[NSString stringWithUTF8String:name]];
    }
    
    free(vars);
    return [ivarsList copy];
}

- (NSDictionary *)mm_ivarsInfo {
    unsigned int varCount;
    
    Ivar *vars = class_copyIvarList([self class], &varCount);
    
    NSMutableDictionary *ivarsInfo = [NSMutableDictionary new];
    for (int i = 0; i < varCount; i++) {
        Ivar var = vars[i];
        
        const char *name = ivar_getName(var);
        const char *typeEncoding = ivar_getTypeEncoding(var);
        
        NSString *nameStr = [NSString stringWithUTF8String:name];
        ivarsInfo[nameStr] = [NSString stringWithUTF8String:typeEncoding];;
    }
    
    free(vars);
    return [ivarsInfo copy];
}

+ (NSArray *)mm_allProperties {
    NSMutableArray *allProperties = [NSMutableArray new];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            [allProperties addObject:[NSString stringWithUTF8String:propName]];
        }
    }
    free(properties);
    
    return [allProperties copy];
}

+ (NSDictionary *)mm_allPropertiesInfo {
    NSMutableDictionary *propertiesInfo = [NSMutableDictionary new];
    
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            [propertiesInfo setObject: [NSString stringWithUTF8String:propType] forKey:[NSString stringWithUTF8String:propName]];
        }
    }
    free(properties);
    
    return [propertiesInfo copy];
}

+ (NSArray *)mm_methodList {
    NSMutableArray *allMethods = [NSMutableArray new];
    
    unsigned int outCount, i;
    Method *methods = class_copyMethodList(self, &outCount);
    for (i = 0; i < outCount; i++) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        NSString *SELStr = NSStringFromSelector(sel);
        if(SELStr) {
            [allMethods addObject:SELStr];
        }
    }
    free(methods);
    
    return [allMethods copy];
}

@end
