//
//  ViewController.m
//  DemoLoca
//
//  Created by Fer on 6/2/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self performSelector: @selector(nextView)
               withObject:nil afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextView {
    [self performSegueWithIdentifier:@"tosecond" sender:self];
}

@end
