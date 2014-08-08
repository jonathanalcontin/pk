//
//  Gameplay.m
//  pushupking
//
//  Created by Jonathan Alcontin on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Character.h"
#import "HighScore.h"
#import <mgwuSDK/MGWU.h>
@implementation Gameplay

{
    CCNode *_background;
    Character *_character;
    float _life;
    CCLabelTTF *_scoreLabel;
    
    CCLabelTTF *_dontLose;
    CCLabelTTF *_highScore;
    
    NSMutableArray *_gridArray;
    NSInteger i;
    NSInteger scorenumber; //this is the score number
    NSInteger m; // this is how hard the earth pushes
    
}

- (void)didLoadFromCCB {

    
    self.userInteractionEnabled = TRUE;
        _life = 100;
    _background.scaleY = _life/100 ;
        i = 0;
        m = scorenumber*2.5; // m = z*5;

    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)scorenumber];
    _highScore.string = [NSString stringWithFormat:@"%ld", (long)[HighScore sharedData].highscores];
    
      [self schedule:@selector(earthPush) interval:1.0f];
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio preloadEffect:@"grunt1.caf"];
   
}
- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    i -= 20;
    _background.position = ccp(0, i);
    _character.position = ccp (-82, i-10);
    CCLOG(@"decrease by 0");
      [[_character animationManager] runAnimationsForSequenceNamed: @"pushDown"];
    // access audio object
    OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    // play sound effect
    [audio playEffect:@"grunt1.caf"];
    
    
    if ( _character.position.y <= 200) {
        [self win];
        /* 
         
         originally
         if ( _character.position.y <= -80) {
         [self win];
         
         */
        
    }
    
    if ( _character.position.y >= 200) {
        [self lose];
    }
    if ( _character.position.y <= -140) {
        [self lose];
    
        
    }

    
 }
//
//- (void) pushUpp {   i -= 20;
//    _background.position = ccp(0, i);
//    _character.position = ccp (250, i);
//    CCLOG(@"decrease by 0");
//}

// this method is cool.
- (void) update:(CCTime)delta {
    m = scorenumber*2;
    //originally it was m = z*5;
}

- (void) earthPush {
    i += 60 + m;
    _background.position = ccp(0, i);
     _character.position = ccp (-82, i-10);
    CCLOG(@"increase by 20 + m");
    
    if ( _character.position.y >= 200) {
        [self lose];
}
}



- (void) win {
    
    //no touch enable, sprite animation occurs , counter goes up
     scorenumber++;
     _scoreLabel.string = [NSString stringWithFormat:@"%d", scorenumber];
  /*  CCParticleSystem *pushedup = (CCParticleSystem *)[CCBReader load:@"boom"];
    
    pushedup.autoRemoveOnFinish = TRUE;
    pushedup.position = ccpAdd(_character.position, ccp(350, 90));
   this creates a particle effect when player gets score
   
    [self addChild:pushedup];*/
    CCLOG(@"Win: %d", scorenumber);
}

- (void) lose {
    /*
    _finishButton = (FinishButton *) [CCBReader load:@"finishButton" owner:self];
    _finishButton.position = ccp(300, 150);
    //        [self addChild: _finishButton];
    [self finishButton];
    //        [[CCDirector sharedDirector] pause];
    CCLOG(@"Lose");
     Potentially add a lose pop.
     */
    
    
    if (scorenumber > [HighScore sharedData].highscores) {
        [HighScore sharedData].highscores = scorenumber;
    }
    
    
    
    CCLOG(@"Lose: %d", [HighScore sharedData].highscores);
     OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    [audio playEffect:@"deadgrunt.caf"];
    
    
    
    
    CCScene *restartScene = [CCBReader loadAsScene:@"Gameplay"];
    CCTransition *transition = [CCTransition transitionFadeWithDuration:0.8f];
    [[CCDirector sharedDirector] presentScene:restartScene withTransition:transition];
    
    
}

- (void) loadMainScene {
    
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}


    
@end
