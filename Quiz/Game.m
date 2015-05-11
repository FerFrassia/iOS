//
//  Game.m
//  Quiz
//
//  Created by Fer on 5/11/15.
//  Copyright (c) 2015 FerFrassia. All rights reserved.
//

#import "Game.h"

@interface Game ()

@end

@implementation Game

-(IBAction)Answer1:(id)sender{
    
}
-(IBAction)Answer2:(id)sender{
    
}
-(IBAction)Answer3:(id)sender{
    
}
-(IBAction)Answer4:(id)sender{
    
}

-(void)Category1{
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"Who killed batman's parents?"];
            [Answer1 setTitle:@"Scarecrow" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Alfred" forState:UIControlStateNormal];
            [Answer3 setTitle:@"The Joker" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Joe Chill" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"When was the first Batman Movie Released?"];
            [Answer1 setTitle:@"1943" forState:UIControlStateNormal];
            [Answer2 setTitle:@"1968" forState:UIControlStateNormal];
            [Answer3 setTitle:@"1966" forState:UIControlStateNormal];
            [Answer4 setTitle:@"1959" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"Which is the penguin's real name?"];
            [Answer1 setTitle:@"Benjamin Hammer" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Albert Pennyworth" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Oswald Cobblepot" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Edward Nigma" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"Who writes the curent 'Batman' comic issues?"];
            [Answer1 setTitle:@"Brian Azzarello" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Scott Snyder" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Geoff Johns" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Jeph Loeb" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 4:
            QuestionText.text = [NSString stringWithFormat:@"Who voiced Batman in 7 different cartoon series and games?"];
            [Answer1 setTitle:@"Kevin Conroy" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Timothy Daly" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Leonard Nimoy" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Mark Hamill" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 5:
            QuestionText.text = [NSString stringWithFormat:@"Who got shot during 'The Killing Joke' storyline?"];
            [Answer1 setTitle:@"Barbara Gordon" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Alfred" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Batman" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Robin" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 6:
            QuestionText.text = [NSString stringWithFormat:@"Which of the following exclamations was NOT used on the 1966-1968 TV show?"];
            [Answer1 setTitle:@"Holy Hutzpah" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Holy Olio!" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Holy Holy Popsicle!" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Holy Bikini" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 7:
            QuestionText.text = [NSString stringWithFormat:@"Where did Harley Quinn meet the Joker?"];
            [Answer1 setTitle:@"Arkham Asylum" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Gotham police station" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Gotham General" forState:UIControlStateNormal];
            [Answer4 setTitle:@"a common robbery" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 8:
            QuestionText.text = [NSString stringWithFormat:@"What was the Huntress's original last name?"];
            [Answer1 setTitle:@"Helena Lazarous" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Helena Bertinelli" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Helena Wayne" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Helena Hunt" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 9:
            QuestionText.text = [NSString stringWithFormat:@"What was Barbara Gordon's nickname after she got shot by the Joker?"];
            [Answer1 setTitle:@"The Watcher" forState:UIControlStateNormal];
            [Answer2 setTitle:@"B" forState:UIControlStateNormal];
            [Answer3 setTitle:@"This never happened" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Oracle" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 10:
            QuestionText.text = [NSString stringWithFormat:@"After leaving his place by Batman's side, Dick Grayson took the name of?"];
            [Answer1 setTitle:@"DeadlyNight" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Nightwing" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Nightmoon" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Deathstroke" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 11:
            QuestionText.text = [NSString stringWithFormat:@"Who broke Batman's back?"];
            [Answer1 setTitle:@"Superman" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Killer Croc" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Bane" forState:UIControlStateNormal];
            [Answer4 setTitle:@"This never happened" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 12:
            QuestionText.text = [NSString stringWithFormat:@"Which is the date of Bruce's birthday?"];
            [Answer1 setTitle:@"It was never revealed" forState:UIControlStateNormal];
            [Answer2 setTitle:@"May 20th" forState:UIControlStateNormal];
            [Answer3 setTitle:@"February 19th" forState:UIControlStateNormal];
            [Answer4 setTitle:@"March 1st" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 13:
            QuestionText.text = [NSString stringWithFormat:@"Who is the husband of Rachel Dawes?"];
            [Answer1 setTitle:@"Harvey Dent" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Dick Grayson" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Gordon" forState:UIControlStateNormal];
            [Answer4 setTitle:@"She doesn't exist in the comic books" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 14:
            QuestionText.text = [NSString stringWithFormat:@"Who was working with Batman since his debut?"];
            [Answer1 setTitle:@"Robin" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Alfred" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Commissioner Gordon" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Superman" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 15:
            QuestionText.text = [NSString stringWithFormat:@"To this day, how many Robins existed?"];
            [Answer1 setTitle:@"5" forState:UIControlStateNormal];
            [Answer2 setTitle:@"4" forState:UIControlStateNormal];
            [Answer3 setTitle:@"6" forState:UIControlStateNormal];
            [Answer4 setTitle:@"3" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 16:
            QuestionText.text = [NSString stringWithFormat:@"Which Robin was killed by the Joker?"];
            [Answer1 setTitle:@"Dick Grayson" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Jason Todd" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Damian Wayne" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Tim Drake" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 17:
            QuestionText.text = [NSString stringWithFormat:@"What was Dick Grayson's profession before he became Robin?"];
            [Answer1 setTitle:@"Circus Acrobat" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Baseball Player" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Street thug" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Martial Arts Instructor" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 18:
            QuestionText.text = [NSString stringWithFormat:@"Which villain developed a powerful formula capable of turning men into hulking bat-like beasts?"];
            [Answer1 setTitle:@"Hugo Strange" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Bane" forState:UIControlStateNormal];
            [Answer3 setTitle:@"The Joker" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Poison Ivy" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 19:
            QuestionText.text = [NSString stringWithFormat:@"Which is the name of Mr. Freeze's wife?"];
            [Answer1 setTitle:@"Emily" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Lora" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Nora" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Susan" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 20:
            QuestionText.text = [NSString stringWithFormat:@"Which of these characters know Batman's secret identity?"];
            [Answer1 setTitle:@"Clark Kent, Ra's Al Gul, Harley Quinn, Dana Tan" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Tim Drake, Virgil Hawkins, Alfred, Dana Tan" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Hugo Strange, Barbara Gordon, James Gordon, The Joker" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Amanda Waller, John Stewart, Wally West, Hugo Strange" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
            
        default:
            break;
    }

}
-(void)Category2{
    
}
-(void)Category3{
    
}
-(void)Category4{
    
}
-(void)Category5{
    
}
-(void)Category6{
    
}
-(void)Category7{
    
}
-(void)Category8{
    
}


- (void)viewDidLoad {
    
    Answer1Correct = NO;
    Answer2Correct = NO;
    Answer3Correct = NO;
    Answer4Correct = NO;
    
    CategoryLoaded = [[NSUserDefaults standardUserDefaults] integerForKey:@"CategorySaved"];
    QuestionSelected = arc4random() %21;
    
    switch (CategoryLoaded) {
        case 1:
            CategorySelected.text = [NSString stringWithFormat:@"Batman"];
            [self Category1];
            break;
        case 2:
            CategorySelected.text = [NSString stringWithFormat:@"Superman"];
            [self Category2];
            break;
        case 3:
            CategorySelected.text = [NSString stringWithFormat:@"Flash"];
            [self Category3];
            break;
        case 4:
            CategorySelected.text = [NSString stringWithFormat:@"Green Lantern"];
            [self Category4];
            break;
        case 5:
            CategorySelected.text = [NSString stringWithFormat:@"Spiderman"];
            [self Category5];
            break;
        case 6:
            CategorySelected.text = [NSString stringWithFormat:@"Hulk"];
            [self Category6];
            break;
        case 7:
            CategorySelected.text = [NSString stringWithFormat:@"Captain America"];
            [self Category7];
            break;
        case 8:
            CategorySelected.text = [NSString stringWithFormat:@"X-Men"];
            [self Category8];
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
