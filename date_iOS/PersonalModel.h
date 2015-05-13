//
//  PersonalModel.h
//  date_iOS
//
//  Created by BooleanMac on 15/5/8.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface PersonalModel : NSObject
-(void)fetchUserInfoFromUid:(NSNumber *)uid toUid:(NSNumber *)getId withSuccess:(void (^)(id data))successCallback andFailure:(void (^)(id error))failureCallback;

-(void)editUserInfo:(NSDictionary *)info withSuccess:(void (^)(id data))successCallback andFailure:(void (^)(id error))failureCallback;

@end