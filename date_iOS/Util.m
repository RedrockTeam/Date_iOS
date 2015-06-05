//
//  Util.m
//  date_iOS
//
//  Created by BooleanMac on 15/5/20.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import "Util.h"

/**
 *  Singleton Tool Class
 */
@implementation Util

+ (id)sharedInstance {
    static Util *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+(NSString *)priceNameForKey:(NSNumber *)key{
    switch ([key intValue]) {
        case 1:
            return @"AA制";
        
        case 2:
            return @"我请客";
        
        case 3:
            return @"求请客";
            
        default:
            return @"error!";
    }
}

-(NSString *)URLWithPath:(NSString *)path{
    NSString *res = @"http://106.184.7.12:8002/index.php/";
    res = [NSString stringWithFormat:@"%@%@", res, path];
    return res;
}

@end