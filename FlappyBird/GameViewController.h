//
//  GameViewController.h
//  Flappy Bird
//
//  Created by Fer on 5/2/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import <UIKit/UIKit.h>

int BirdFlight;

@interface GameViewController : UIViewController
{
    IBOutlet UIImageView *Bird;
    IBOutlet UIButton *StartGame;
    
    NSTimer *BirdMovement;
    
}

-(IBAction)StartGame:(id)sender;
-(void)BirdMoving;


@end
