//
//  FailedBankInfo.m
//  FailedBanks
//
//  Created by Fer on 5/3/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import "FailedBankInfo.h"

@implementation FailedBankInfo

@synthesize uniqueId = _uniqueId;
@synthesize name = _name;
@synthesize city = _city;
@synthesize state = _state;

- (id)intWithUniqueId:(int)uniqueId name:(NSString *)name city:(NSString *)city state:(NSString *)state {
    if (self == [super init]) {
        self.uniqueId = uniqueId;
        self.name = name;
        self.city = city;
        self.state = state;
    }
    return self;
}

-(void) dealloc {
    self.name = nil;
    self.city = nil;
    self.state = nil;
}

@end
