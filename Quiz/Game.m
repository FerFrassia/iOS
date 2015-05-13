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

-(void)RightAnswer {
    ScoreNumber = ScoreNumber + 1;
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    NextCategory.hidden = NO;
    Answer1.hidden = YES;
    Answer2.hidden = YES;
    Answer3.hidden = YES;
    Answer4.hidden = YES;
    QuestionText.hidden = YES;
    CategorySelected.hidden = YES;
    Result.hidden = NO;
    Result.image = [UIImage imageNamed:@"rightanswer.jpeg"];
    
}

-(void)WrongAnswer {
    LivesNumber = LivesNumber - 1;
    Lives.text = [NSString stringWithFormat:@"%i", LivesNumber];
    NextCategory.hidden = NO;
    Answer1.hidden = YES;
    Answer2.hidden = YES;
    Answer3.hidden = YES;
    Answer4.hidden = YES;
    QuestionText.hidden = YES;
    CategorySelected.hidden = YES;
    Result.hidden = NO;
    Result.image = [UIImage imageNamed:@"wronganswer.jpeg"];
    
    if (LivesNumber == 0) {
        Result.image = [UIImage imageNamed:[NSString stringWithFormat:@"gameover%i.png", GameOverNumber]];
        NextCategory.hidden = YES;
        Exit.hidden = NO;
        GameInProgress = NO;
        
        
    }
}


-(IBAction)Answer1:(id)sender{
    if (Answer1Correct == YES) {
        [self RightAnswer];
    } else {
        [self WrongAnswer];
    }
}
-(IBAction)Answer2:(id)sender{
    if (Answer2Correct == YES) {
        [self RightAnswer];
    } else {
        [self WrongAnswer];
    }
}
-(IBAction)Answer3:(id)sender{
    if (Answer3Correct == YES) {
        [self RightAnswer];
    } else {
        [self WrongAnswer];
    }
}
-(IBAction)Answer4:(id)sender{
    if (Answer4Correct == YES) {
        [self RightAnswer];
    } else {
        [self WrongAnswer];
    }
}

-(void)Category1{
    Answer1.titleLabel.numberOfLines = 3;
    Answer2.titleLabel.numberOfLines = 3;
    Answer3.titleLabel.numberOfLines = 3;
    Answer4.titleLabel.numberOfLines = 3;
    
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
    Answer1.titleLabel.numberOfLines = 3;
    Answer2.titleLabel.numberOfLines = 3;
    Answer3.titleLabel.numberOfLines = 3;
    Answer4.titleLabel.numberOfLines = 3;
    
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"What is Clark Kent middle name?"];
            [Answer1 setTitle:@"Thomas" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Joseph" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Jacob" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Walter" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"What is the name of the dimensional plane where Kryptonian criminals were exiled for their crimes?"];
            [Answer1 setTitle:@"No Man's land" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Zimbardo's prison" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Bizarro World" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Phantom Zone" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"What super-villain killed the Man of Steel in Superman #75?"];
            [Answer1 setTitle:@"Darkseid" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Brainiac" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Lex Luthor" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Doomsday" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"Which of Superman's former sweethearts became the super-heroine known as Insect Queen?"];
            [Answer1 setTitle:@"Lana Lang" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Lois Lane" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Lori Lemaris" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Lyla Lerrol" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 4:
            QuestionText.text = [NSString stringWithFormat:@"Who is the natural father of Daily Planet editor Perry White's son Jerry?"];
            [Answer1 setTitle:@"Emil Hamilton" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Lex Luthor" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Bizarro Perry White" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Bilbo Bibbowski" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 5:
            QuestionText.text = [NSString stringWithFormat:@"Who created Superman?"];
            [Answer1 setTitle:@"Jack Kirby & Bob Kane" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Bob Kane & Joe Shuster" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Joe Shuster & Jerry Siegel" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Jerry Siegel & Stan Lee" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 6:
            QuestionText.text = [NSString stringWithFormat:@"What member of the Superman family died in Crisis on Infinite Earths?"];
            [Answer1 setTitle:@"Superboy" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Lois Lane" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Krypto" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Supergirl" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 7:
            QuestionText.text = [NSString stringWithFormat:@"When did Lois and Superman first kiss?"];
            [Answer1 setTitle:@"Action Comics #2" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Action Comics #124" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Superman #3" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Superman #248" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 8:
            QuestionText.text = [NSString stringWithFormat:@"What is Superman's Kryptonian name?"];
            [Answer1 setTitle:@"Jor-El" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Kal-El" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Zor-El" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Cacarot" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 9:
            QuestionText.text = [NSString stringWithFormat:@"What was the name of Superman's birth mother?"];
            [Answer1 setTitle:@"Lana" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Lara" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Kara" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Xala" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 10:
            QuestionText.text = [NSString stringWithFormat:@"What is the name of the place where Clark Kent works?"];
            [Answer1 setTitle:@"Daily Bugle" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Daily Planet" forState:UIControlStateNormal];
            [Answer3 setTitle:@"World Wide News" forState:UIControlStateNormal];
            [Answer4 setTitle:@"National News" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 11:
            QuestionText.text = [NSString stringWithFormat:@"How many times different costumes has Superman gone through (not just changing the 'S' a little)?"];
            [Answer1 setTitle:@"Twice" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Never" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Once" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Thrice" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 12:
            QuestionText.text = [NSString stringWithFormat:@"When was Superman, the character, created?"];
            [Answer1 setTitle:@"The 40's" forState:UIControlStateNormal];
            [Answer2 setTitle:@"The 50's" forState:UIControlStateNormal];
            [Answer3 setTitle:@"The 20's" forState:UIControlStateNormal];
            [Answer4 setTitle:@"The 30's" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 13:
            QuestionText.text = [NSString stringWithFormat:@"There used to be a comic book series with Superman teaming up with another certain hero, called 'World's Finest'. Who was the other hero?"];
            [Answer1 setTitle:@"Wonder Woman" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Superboy" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Batman" forState:UIControlStateNormal];
            [Answer4 setTitle:@"This never happened" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 14:
            QuestionText.text = [NSString stringWithFormat:@"Lois's sister Lucy Lane was an airline hostess who dated Jimmy Olsen. In the first modern appearance of Bizarro, he sacrificed himself to cure Lucy of what?"];
            [Answer1 setTitle:@"Diptheria" forState:UIControlStateNormal];
            [Answer2 setTitle:@"SARS" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Blindness" forState:UIControlStateNormal];
            [Answer4 setTitle:@"White kryptonite poisoning" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 15:
            QuestionText.text = [NSString stringWithFormat:@"In the university Clark met Lori Lemaris, a mermaid from Atlantis. She went around in a wheelchair with a blanket covering her fishy parts, what did he suspect she was?"];
            [Answer1 setTitle:@"An alien" forState:UIControlStateNormal];
            [Answer2 setTitle:@"A supervillain" forState:UIControlStateNormal];
            [Answer3 setTitle:@"A man" forState:UIControlStateNormal];
            [Answer4 setTitle:@"A foreign spy" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 16:
            QuestionText.text = [NSString stringWithFormat:@"When Lana Lang moved from Smallville to Metropolis, what job did she get?"];
            [Answer1 setTitle:@"Research Scientist" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Secretary" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Cocktail Waitress" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Television Reporter" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 17:
            QuestionText.text = [NSString stringWithFormat:@"When Supergirl landed on Earth, she chose the name 'Linda Lee', but what surname was added when she finally got adopted?"];
            [Answer1 setTitle:@"Evans" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Perro" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Dayton" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Danvers" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 18:
            QuestionText.text = [NSString stringWithFormat:@"What is the name of Superman's secret headquarters?"];
            [Answer1 setTitle:@"Superman's Sugar Shack" forState:UIControlStateNormal];
            [Answer2 setTitle:@"The Fortress of Solitude" forState:UIControlStateNormal];
            [Answer3 setTitle:@"The Super Base" forState:UIControlStateNormal];
            [Answer4 setTitle:@"The Pit" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 19:
            QuestionText.text = [NSString stringWithFormat:@"Recently Superman entrusted a piece of Kryptonite to a fellow superhero in case he got out of control. Who was that superhero?"];
            [Answer1 setTitle:@"Supergirl" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Superboy" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Wonder Woman" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Batman" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 20:
            QuestionText.text = [NSString stringWithFormat:@"Who is the praetor of the elite corps of the Shi'ar Imperial Guard?"];
            [Answer1 setTitle:@"Zeus" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Apollo" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Hyperion" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Gladiator" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        default:
            break;
    }
    
}
-(void)Category3{
    
}
-(void)Category4{
    
}
-(void)Category5{
    Answer1.titleLabel.numberOfLines = 3;
    Answer2.titleLabel.numberOfLines = 3;
    Answer3.titleLabel.numberOfLines = 3;
    Answer4.titleLabel.numberOfLines = 3;
    
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"When did Spider-man first appear?"];
            [Answer1 setTitle:@"1962" forState:UIControlStateNormal];
            [Answer2 setTitle:@"1996" forState:UIControlStateNormal];
            [Answer3 setTitle:@"1982" forState:UIControlStateNormal];
            [Answer4 setTitle:@"1988" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"Where did Spider-man first wear his black suit?"];
            [Answer1 setTitle:@"In his house" forState:UIControlStateNormal];
            [Answer2 setTitle:@"A river" forState:UIControlStateNormal];
            [Answer3 setTitle:@"A spaceship" forState:UIControlStateNormal];
            [Answer4 setTitle:@"A Battleworld" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"How did Uncle Ben die?"];
            [Answer1 setTitle:@"Stabbed" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Shot" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Blew up" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Fist fight" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"In what comic did Spider-man first appear?"];
            [Answer1 setTitle:@"Spider-man #1" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Action Comics #1" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Amazing Fantasy #15" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Ultmate Comics #16" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 4:
            QuestionText.text = [NSString stringWithFormat:@"Who's the second Spidey in the clone saga?"];
            [Answer1 setTitle:@"Ben Reily" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Miguel O'Hara" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Miles Morales" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Peter Parker" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 5:
            QuestionText.text = [NSString stringWithFormat:@"Did Peter Parker marry Mary Jane?"];
            [Answer1 setTitle:@"Maybe" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Yes, in The Amazing Spider-man Annual #21" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Yes, in Ultimate Spider-man #250" forState:UIControlStateNormal];
            [Answer4 setTitle:@"No" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 6:
            QuestionText.text = [NSString stringWithFormat:@"Who killed Gwen Stacy?"];
            [Answer1 setTitle:@"Venom" forState:UIControlStateNormal];
            [Answer2 setTitle:@"This never happened" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Green Goblin" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Hobgoblin" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 7:
            QuestionText.text = [NSString stringWithFormat:@"Who killed Mary Jane?"];
            [Answer1 setTitle:@"Venom" forState:UIControlStateNormal];
            [Answer2 setTitle:@"This never happened" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Green Goblin" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Hobgoblin" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 8:
            QuestionText.text = [NSString stringWithFormat:@"How did Spider-man obtain his powers?"];
            [Answer1 setTitle:@"He drank toxic water" forState:UIControlStateNormal];
            [Answer2 setTitle:@"A radioactive spider fell on him and bit him" forState:UIControlStateNormal];
            [Answer3 setTitle:@"He was looking for a radioactive spider to bite him" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He ate a radioactive spider in his sleep" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 9:
            QuestionText.text = [NSString stringWithFormat:@"What were Peter Parker's parents' names?"];
            [Answer1 setTitle:@"Ben & May" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Richard & Lara" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Norman & Susan" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Richard & Mary" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 10:
            QuestionText.text = [NSString stringWithFormat:@"Where does Peter Parker work?"];
            [Answer1 setTitle:@"Daily Bugle" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Daily Planet" forState:UIControlStateNormal];
            [Answer3 setTitle:@"World Wide News" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Daily Pictures" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 11:
            QuestionText.text = [NSString stringWithFormat:@"In the comic, how did Max Dillon became Electro?"];
            [Answer1 setTitle:@"He fell with wires in a tub with electric eels" forState:UIControlStateNormal];
            [Answer2 setTitle:@"He touched an electric eel" forState:UIControlStateNormal];
            [Answer3 setTitle:@"He got struck by a lightning" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He got electrocuted by an electric pole" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 12:
            QuestionText.text = [NSString stringWithFormat:@"What was Peter's job?"];
            [Answer1 setTitle:@"Make newspaper" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Take pictures of assaults" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Deliver pizza" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Take pictures of Spider-man" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 13:
            QuestionText.text = [NSString stringWithFormat:@"In the comic, how did Captain Stacy die?"];
            [Answer1 setTitle:@"He turned into a lizard and died" forState:UIControlStateNormal];
            [Answer2 setTitle:@"The Lizard stabbed him" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Green Goblin stabbed him" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He got shot by Dr. Octopus" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 14:
            QuestionText.text = [NSString stringWithFormat:@"'With great power comes great...?"];
            [Answer1 setTitle:@"Decisions" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Fear" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Responsibility" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Spider-man" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 15:
            QuestionText.text = [NSString stringWithFormat:@"...neighbourhood Spider-man?"];
            [Answer1 setTitle:@"Good" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Friendly" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Watching" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Alerting" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 16:
            QuestionText.text = [NSString stringWithFormat:@"In what comic did Uncle Ben die?"];
            [Answer1 setTitle:@"Amazing Fantasy #15" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Amazing Spider-man #50" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Amazing Spider-man #60" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Giant Size Spider-man #10" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 17:
            QuestionText.text = [NSString stringWithFormat:@"Spider-man's web comes from?"];
            [Answer1 setTitle:@"His wrists" forState:UIControlStateNormal];
            [Answer2 setTitle:@"A wrist device that he invented" forState:UIControlStateNormal];
            [Answer3 setTitle:@"He actually uses ropes" forState:UIControlStateNormal];
            [Answer4 setTitle:@"His pants" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 18:
            QuestionText.text = [NSString stringWithFormat:@"Who first says the mythical phrase 'with great power, comes great responsibility'?"];
            [Answer1 setTitle:@"Uncle Ben" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Peter Parker's dad" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Norman Osborn" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Stan Lee" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 19:
            QuestionText.text = [NSString stringWithFormat:@"In what comic, Venom first appears?"];
            [Answer1 setTitle:@"Amazing Spider-man #300" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Web of Spider-man #18" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Venom #1" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Amazing Spider-man #200" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 20:
            QuestionText.text = [NSString stringWithFormat:@"How is the Carnage Symbiote born?"];
            [Answer1 setTitle:@"It appeared from the same place as Venom" forState:UIControlStateNormal];
            [Answer2 setTitle:@"It's the Venom's symbiote's son" forState:UIControlStateNormal];
            [Answer3 setTitle:@"It's the unknown brother of Venom's symbiote" forState:UIControlStateNormal];
            [Answer4 setTitle:@"A mad scientist created him" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        default:
            break;
    }
}
-(void)Category6{
    
}
-(void)Category7{
    Answer1.titleLabel.numberOfLines = 3;
    Answer2.titleLabel.numberOfLines = 3;
    Answer3.titleLabel.numberOfLines = 3;
    Answer4.titleLabel.numberOfLines = 3;
    
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"Which is Captain America's real name?"];
            [Answer1 setTitle:@"Scott Summers" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Clint Barton" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Tony Stark" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Steve Rogers" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"How did Cap gain his powers?"];
            [Answer1 setTitle:@"Military nuclear accident" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Nazi soldier experiment" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Super soldier program" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He doesn't have any powers, just conviction" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"In what year did Cap first appear in comics?"];
            [Answer1 setTitle:@"1946" forState:UIControlStateNormal];
            [Answer2 setTitle:@"1941" forState:UIControlStateNormal];
            [Answer3 setTitle:@"1939" forState:UIControlStateNormal];
            [Answer4 setTitle:@"1951" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"What is Cap doing on the cover of his first comic issue"];
            [Answer1 setTitle:@"Punching Hitler" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Riding his WWII motorcycle" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Rising a flag" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Swearing an oath to his country" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 4:
            QuestionText.text = [NSString stringWithFormat:@"Which of these characters was not a member of the original Avengers (the Cap was)?"];
            [Answer1 setTitle:@"Ironman" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Hulk" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Thor" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Ant-man" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 5:
            QuestionText.text = [NSString stringWithFormat:@"What is Cap's shield made of?"];
            [Answer1 setTitle:@"Vibranium" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Adamantium" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Titanium" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Steel" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 6:
            QuestionText.text = [NSString stringWithFormat:@"In Marvel's civil war, Cap fought for what?"];
            [Answer1 setTitle:@"The unifying heroes under one advanced military unit"
                     forState:UIControlStateNormal];
            [Answer2 setTitle:@"The US Government's registration of masked heroes' identities"
                     forState:UIControlStateNormal];
            [Answer3 setTitle:@"The freedom for heroes to keep their identities secret" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He didn't fight" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 7:
            QuestionText.text = [NSString stringWithFormat:@"Which of these villains did not involved in Cap's assasination"];
            [Answer1 setTitle:@"Batroc" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Red Skull" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Crossbones" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Winter Soldier" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 8:
            QuestionText.text = [NSString stringWithFormat:@"Before being an Avenger, which organization was the Cap a member of?"];
            [Answer1 setTitle:@"Mighty Men" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Crusaders" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Invaders" forState:UIControlStateNormal];
            [Answer4 setTitle:@"The Secret Team" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 9:
            QuestionText.text = [NSString stringWithFormat:@"Who created Captain America?"];
            [Answer1 setTitle:@"Stan Lee & Martin Goodman" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Stan Lee & Jack Kirby" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Joe Simon & Jack Kirby" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Marc Webb & Steve Ditko" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 10:
            QuestionText.text = [NSString stringWithFormat:@"What is Captain's home town?"];
            [Answer1 setTitle:@"San Diego" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Las Vegas" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Denver" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Manhattan" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 11:
            QuestionText.text = [NSString stringWithFormat:@"What is Captain's actual team name?"];
            [Answer1 setTitle:@"The flamming atoms" forState:UIControlStateNormal];
            [Answer2 setTitle:@"The west coast Avengers" forState:UIControlStateNormal];
            [Answer3 setTitle:@"The Avengers" forState:UIControlStateNormal];
            [Answer4 setTitle:@"All-Winners Squad" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 12:
            QuestionText.text = [NSString stringWithFormat:@"the Cap made his first appearance in what comic book?"];
            [Answer1 setTitle:@"Captain America Comics #1" forState:UIControlStateNormal];
            [Answer2 setTitle:@"War Comics #1" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Whiz Comics #1" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Tales of Suspense #58" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 13:
            QuestionText.text = [NSString stringWithFormat:@"What team of superheroes discovered Captain America's body frozen in a block of ice in 1964?"];
            [Answer1 setTitle:@"Fantastic Four" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Avengers" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Defenders" forState:UIControlStateNormal];
            [Answer4 setTitle:@"All-star Squadron" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 14:
            QuestionText.text = [NSString stringWithFormat:@"For a brief period during the 1970s, disillusioned by U.S. politics, Captain America changed his name to...?"];
            [Answer1 setTitle:@"Exile" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Wanderer" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Nomad" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Outsider" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 15:
            QuestionText.text = [NSString stringWithFormat:@"What was the original shape of Captain's shield?"];
            [Answer1 setTitle:@"Star-shaped" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Badge-shaped" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Circular" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Square" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 16:
            QuestionText.text = [NSString stringWithFormat:@"What villain did Cap and Bucky fight in the very first issue of Captain America Comics?"];
            [Answer1 setTitle:@"Baron Zemo" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Viper" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Red Skull" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Just nazi soldiers" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 17:
            QuestionText.text = [NSString stringWithFormat:@"When Bucky was wounded in combat, who became Captain America's new sidekick?"];
            [Answer1 setTitle:@"The human torch" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Spitfire" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Golden Girl" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Miss America" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 18:
            QuestionText.text = [NSString stringWithFormat:@"Who played the title role in the 1979 TV movie Captain America?"];
            [Answer1 setTitle:@"Matt Salinger" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Reb Brown" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Scott Paulin" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Dick Purcell" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 19:
            QuestionText.text = [NSString stringWithFormat:@"Who was Captain America's sidekick during World War II?"];
            [Answer1 setTitle:@"Miss America" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Flag Boy" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Union Jack" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Bucky" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 20:
            QuestionText.text = [NSString stringWithFormat:@"Which of these characters has been Captain America?"];
            [Answer1 setTitle:@"Bucky Barnes" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Sam Wilson" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Both" forState:UIControlStateNormal];
            [Answer4 setTitle:@"None" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        default:
            break;
    }
}
-(void)Category8{
    Answer1.titleLabel.numberOfLines = 3;
    Answer2.titleLabel.numberOfLines = 3;
    Answer3.titleLabel.numberOfLines = 3;
    Answer4.titleLabel.numberOfLines = 3;
    
    switch (QuestionSelected) {
        case 0:
            QuestionText.text = [NSString stringWithFormat:@"Which is Storm's real name?"];
            [Answer1 setTitle:@"Sarah Goldhawk" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Elizabeth Austin" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Raven Darkholme" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Ororo Monroe" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 1:
            QuestionText.text = [NSString stringWithFormat:@"Which is Victor Creed's code name?"];
            [Answer1 setTitle:@"Gambit" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Cyclops" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Toad" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Sabertooth" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 2:
            QuestionText.text = [NSString stringWithFormat:@"Who has the power to teleport from place to place?"];
            [Answer1 setTitle:@"Archangel" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Bishop" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Night Crawler" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Rogue" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 3:
            QuestionText.text = [NSString stringWithFormat:@"Which two X-men are married?"];
            [Answer1 setTitle:@"Cyclops and Jean Grey" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Cyclops and Emma Frost" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Gambit and Rogue" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Wolverine and Storm" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 4:
            QuestionText.text = [NSString stringWithFormat:@"Wolverine call's Gambit...?"];
            [Answer1 setTitle:@"Swamp Rat" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Cajun" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Bongo" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Whirlwind" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 5:
            QuestionText.text = [NSString stringWithFormat:@"What is the name of the X-men aircraft?"];
            [Answer1 setTitle:@"The Owl" forState:UIControlStateNormal];
            [Answer2 setTitle:@"The Bluetit" forState:UIControlStateNormal];
            [Answer3 setTitle:@"The Blackbird" forState:UIControlStateNormal];
            [Answer4 setTitle:@"The Thrush" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 6:
            QuestionText.text = [NSString stringWithFormat:@"Which is the name of the metal in Wolverine's bones?"];
            [Answer1 setTitle:@"Steel" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Vibranium" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Copper" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Adamantium" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 7:
            QuestionText.text = [NSString stringWithFormat:@"Where does Colossus come from?"];
            [Answer1 setTitle:@"United States" forState:UIControlStateNormal];
            [Answer2 setTitle:@"France" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Greece" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Russia" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 8:
            QuestionText.text = [NSString stringWithFormat:@"Where does Night Crawler come from?"];
            [Answer1 setTitle:@"Germany" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Russia" forState:UIControlStateNormal];
            [Answer3 setTitle:@"France" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Belgium" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 9:
            QuestionText.text = [NSString stringWithFormat:@"Where does Wolverine come from?"];
            [Answer1 setTitle:@"United Kingdom" forState:UIControlStateNormal];
            [Answer2 setTitle:@"United States" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Canada" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He doesn't have any nationality" forState:UIControlStateNormal];
            Answer3Correct = YES;
            break;
        case 10:
            QuestionText.text = [NSString stringWithFormat:@"Who is Rogue's foster mother?"];
            [Answer1 setTitle:@"Storm" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Mystique" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Emma Frost" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Jean Grey" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 11:
            QuestionText.text = [NSString stringWithFormat:@"What happened to Morph?"];
            [Answer1 setTitle:@"Magneto killed him" forState:UIControlStateNormal];
            [Answer2 setTitle:@"He got eaten by a tiger" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Wolverine killed him" forState:UIControlStateNormal];
            [Answer4 setTitle:@"He got left behind" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 12:
            QuestionText.text = [NSString stringWithFormat:@"Which's the original name of Wolverine?"];
            [Answer1 setTitle:@"Logan" forState:UIControlStateNormal];
            [Answer2 setTitle:@"John Appleton" forState:UIControlStateNormal];
            [Answer3 setTitle:@"James Dean" forState:UIControlStateNormal];
            [Answer4 setTitle:@"James Howlett" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 13:
            QuestionText.text = [NSString stringWithFormat:@"Which's Wolverine's power?"];
            [Answer1 setTitle:@"Fast healing and claws" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Adamantium bones and claws" forState:UIControlStateNormal];
            [Answer3 setTitle:@"All of the above" forState:UIControlStateNormal];
            [Answer4 setTitle:@"None of the above" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 14:
            QuestionText.text = [NSString stringWithFormat:@"Which is the main thing that Gambit throws at his enemies?"];
            [Answer1 setTitle:@"Tables" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Cards" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Toys" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Axes" forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 15:
            QuestionText.text = [NSString stringWithFormat:@"Who did Bishop think the traitor was?"];
            [Answer1 setTitle:@"Wolverine" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Cyclops" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Storm" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Gambit" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 16:
            QuestionText.text = [NSString stringWithFormat:@"Who was the traitor really, in Age of Apocalypse?"];
            [Answer1 setTitle:@"Mystique" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Magneto" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Gambit" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Cyclops" forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 17:
            QuestionText.text = [NSString stringWithFormat:@"Which colours are Rogue's X-men uniform?"];
            [Answer1 setTitle:@"Purple and green" forState:UIControlStateNormal];
            [Answer2 setTitle:@"Green and red" forState:UIControlStateNormal];
            [Answer3 setTitle:@"Yellow and red" forState:UIControlStateNormal];
            [Answer4 setTitle:@"Green and yellow" forState:UIControlStateNormal];
            Answer4Correct = YES;
            break;
        case 18:
            QuestionText.text = [NSString stringWithFormat:@"90's X-men Gold team was formed by?"];
            [Answer1 setTitle:@"Cyclops, Beast, Wolverine, Rogue, Psylocke, Gambit"
                     forState:UIControlStateNormal];
            [Answer2 setTitle:@"Storm, Iceman, Archangel, Jean Grey, Colossus, Bishop"
                     forState:UIControlStateNormal];
            [Answer3 setTitle:@"Angel, Iceman, Night Crawler, Cyclops, Jean Grey, Wolverine, Colossus"
                     forState:UIControlStateNormal];
            [Answer4 setTitle:@"Storm, Cyclops, Jean Grey, Wolverine, Night Crawler, Colossus"
                     forState:UIControlStateNormal];
            Answer2Correct = YES;
            break;
        case 19:
            QuestionText.text = [NSString stringWithFormat:@"Who were the original 7 X-men?"];
            [Answer1 setTitle:@"Professor X, Sage, Cyclops, Marvel Girl, Beast, Iceman, Angel"
                     forState:UIControlStateNormal];
            [Answer2 setTitle:@"Professor X, Storm, Cyclops, Jean Grey, Beast, Iceman, Angel"
                     forState:UIControlStateNormal];
            [Answer3 setTitle:@"Professor X, Colossus, Night Crawler, Cyclops, Beast, Angel, Wolverine"
                     forState:UIControlStateNormal];
            [Answer4 setTitle:@"Professor X, Jubilee, Rogue, Storm, Jean Grey, Wolverine, Beast"
                     forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        case 20:
            QuestionText.text = [NSString stringWithFormat:@"90's X-men Blue team was formed by?"];
            [Answer1 setTitle:@"Cyclops, Beast, Wolverine, Rogue, Psylocke, and Gambit"
                     forState:UIControlStateNormal];
            [Answer2 setTitle:@"Storm, Iceman, Archangel, Jean Grey, Colossus, and Bishop"
                     forState:UIControlStateNormal];
            [Answer3 setTitle:@"Angel, Iceman, Night Crawler, Cyclops, Jean Grey, Wolverine, Colossus"
                     forState:UIControlStateNormal];
            [Answer4 setTitle:@"Storm, Cyclops, Jean Grey, Wolverine, Night Crawler, Colossus"
                     forState:UIControlStateNormal];
            Answer1Correct = YES;
            break;
        default:
            break;
    }
}


- (void)viewDidLoad {
    
    if (GameInProgress == NO) {
        LivesNumber = 3;
        ScoreNumber = 0;
        GameInProgress = YES;
    }
    Result.hidden = YES;
    Exit.hidden = YES;
    NextCategory.hidden = YES;
    
    Lives.text = [NSString stringWithFormat:@"%i", LivesNumber];
    Score.text = [NSString stringWithFormat:@"%i", ScoreNumber];
    
    
    Answer1Correct = NO;
    Answer2Correct = NO;
    Answer3Correct = NO;
    Answer4Correct = NO;
    
    CategoryLoaded = [[NSUserDefaults standardUserDefaults] integerForKey:@"CategorySaved"];
    QuestionSelected = arc4random() %21;
    // QuestionSelected = 18;
    GameOverNumber = arc4random() %6;
    
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
