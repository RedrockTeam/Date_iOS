//
//  Util.h
//  date_iOS
//
//  Created by BooleanMac on 15/5/20.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (id)sharedInstance;
+(NSString *)priceNameForKey:(NSNumber *)key;
-(NSString *)URLWithPath:(NSString *)path;
@end
