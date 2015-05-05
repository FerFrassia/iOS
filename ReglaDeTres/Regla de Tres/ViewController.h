//
//  ViewController.h
//  Regla de Tres
//
//  Created by Fer on 4/17/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *cienTextField;
@property (weak, nonatomic) IBOutlet UITextField *calcularTextField;
@property (weak, nonatomic) IBOutlet UITextField *calculadoTextField;

- (IBAction)calcularButtonPressed:(id)sender;


@end

