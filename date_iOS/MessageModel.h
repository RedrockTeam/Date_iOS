//
//  MessageModel.h
//  date_iOS
//
//  Created by BooleanMac on 15/5/8.
//  Copyright (c) 2015年 Boolean93. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MessageModel : NSObject

-(void)messageWithData:(NSDictionary *)data success:(void (^)(void))successCallback failure:(void (^)(void))failureCallback;

-(void)dateActionWithData:(NSDictionary *)data success:(void (^)(void))successCallback failure:(void (^)(void))failureCallback;

-(void)messageStatusWithData:(NSDictionary *)data success:(void (^)(void))successCallback failure:(void (^)(void))failureCallback;

@end
