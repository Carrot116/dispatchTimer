//
//  MHDataModel.m
//  dispatchTimer
//
//  Created by carrot on 16/3/4.
//  Copyright © 2016年 carrot. All rights reserved.
//

#import "MHDataModel.h"
#import <FMDB/FMDB.h>

@interface MHDataModel ()
@property (nonatomic, strong) NSMutableArray* datas;
@end

@implementation MHDataModel

+ (instancetype)dataModel{
    return [[self alloc]init];
}
- (NSMutableArray*)datas{
    if (_datas == nil) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)addData:(NSString*)data{
    [self.datas addObject:data];
}

- (void)clearData{
    [self.datas removeAllObjects];
}

- (NSInteger)dataCount{
    return self.datas.count;
}

@end
