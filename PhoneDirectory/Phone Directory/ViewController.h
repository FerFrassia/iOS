//
//  ViewController.h
//  Phone Directory
//
//  Created by Fer on 5/4/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ViewController : UIViewController


@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *DB;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *phone;

- (IBAction)save:(id)sender;
- (IBAction)find:(id)sender;
- (IBAction)remove:(id)sender;





@end

