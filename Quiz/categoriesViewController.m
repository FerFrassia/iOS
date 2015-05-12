//
//  categoriesViewController.m
//  Quiz
//
//  Created by Fer on 5/9/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import "categoriesViewController.h"

@interface categoriesViewController ()

@end

@implementation categoriesViewController


-(IBAction)Button1:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:Category1SelectedNumber forKey:@"CategorySaved"];
    
    
}
-(IBAction)Button2:(id)sender{
    [[NSUserDefaults standardUserDefaults] setInteger:Category2SelectedNumber forKey:@"CategorySaved"];
    
    
}


- (void)viewDidLoad {
    
    Category1Number = arc4random() %4;
    // Category2Number = arc4random() %4;
    Category2Number = 2;
    switch (Category1Number) {
        case 0:
            [Category1 setTitle:@"Batman" forState:UIControlStateNormal];
            Category1SelectedNumber = 1;
             break;
        case 1:
            [Category1 setTitle:@"Superman" forState:UIControlStateNormal];
            Category1SelectedNumber = 2;
            break;
        case 2:
            [Category1 setTitle:@"Flash" forState:UIControlStateNormal];
            Category1SelectedNumber = 3;
            break;
        case 3:
            [Category1 setTitle:@"Green Lantern" forState:UIControlStateNormal];
            Category1SelectedNumber = 4;
            break;
        default:
            break;
    }
    
    switch (Category2Number) {
        case 0:
            [Category2 setTitle:@"Spiderman" forState:UIControlStateNormal];
            Category2SelectedNumber = 5;
            break;
        case 1:
            [Category2 setTitle:@"Hulk" forState:UIControlStateNormal];
            Category2SelectedNumber = 6;
            break;
        case 2:
            [Category2 setTitle:@"Captain America" forState:UIControlStateNormal];
            Category2SelectedNumber = 7;
            break;
        case 3:
            [Category2 setTitle:@"X-Men" forState:UIControlStateNormal];
            Category2SelectedNumber = 8;
            break;
        default:
            break;
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
