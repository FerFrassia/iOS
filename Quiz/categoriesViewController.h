//
//  categoriesViewController.h
//  Quiz
//
//  Created by Fer on 5/9/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <UIKit/UIKit.h>

int Category1Number;
int Category2Number;
int Category1SelectedNumber;
int Category2SelectedNumber;

@interface categoriesViewController : UIViewController
{
    IBOutlet UIButton *Category1;
    IBOutlet UIButton *Category2;
}

-(IBAction)Button1:(id)sender;
-(IBAction)Button2:(id)sender;

@end
