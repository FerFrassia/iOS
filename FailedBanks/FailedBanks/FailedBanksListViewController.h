//
//  FailedBanksListViewController.h
//  FailedBanks
//
//  Created by Fer on 5/3/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailedBanksListViewController : UITableViewController {
    NSArray *_failedBankInfos;
}
@property (nonatomic, retain) NSArray *failedBankInfos;

@end
