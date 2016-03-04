//
//  MHDataModel.h
//  dispatchTimer
//
//  Created by carrot on 16/3/4.
//  Copyright © 2016年 carrot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHDataModel : NSObject
@property (nonatomic, strong) NSMutableArray* data;

+ (instancetype)dataModel;

- (void)addData:(NSString*)data;
- (void)clearData;
- (NSInteger)dataCount;
@end
