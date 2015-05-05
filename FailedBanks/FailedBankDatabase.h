//
//  FailedBankDatabase.h
//  FailedBanks
//
//  Created by Fer on 5/3/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface FailedBankDatabase : NSObject {
    sqlite3 *_database;
}
+ (FailedBankDatabase*)database;
- (NSArray *)failedBankInfos;

@end
