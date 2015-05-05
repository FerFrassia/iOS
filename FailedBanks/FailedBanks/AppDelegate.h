//
//  AppDelegate.h
//  FailedBanks
//
//  Created by Fer on 5/3/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *_navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;


@end

