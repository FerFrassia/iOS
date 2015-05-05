//
//  ViewController.m
//  Regla de Tres
//
//  Created by Fer on 4/17/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calcularButtonPressed:(id)sender {
    
    NSLog(@"Calcular pressed");
    
    float cien = [[self.cienTextField text] floatValue];
    float calcular = [[self.calcularTextField text] floatValue];
    
    NSLog(@"cien: %f, calcular: %f", cien, calcular);
    
    float calculado = calcular * cien / 100;
    
    NSLog(@"calculado: %f", calculado);
    NSString *calculadoText = [NSString stringWithFormat:@"%f", calculado];
    
    self.calculadoTextField.text = calculadoText;
    
    
}
@end
