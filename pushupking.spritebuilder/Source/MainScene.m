//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "HighScore.h"
#import <mgwuSDK/MGWU.h>

@implementation MainScene {
    
    
    //scores
    CCLabelTTF *_highScore;

    
}
-(void) didLoadFromCCB {
    CCLOG(@"%d" , [HighScore sharedData].highscores);
    _highScore.string = [NSString stringWithFormat:@"%d",[HighScore sharedData].highscores];
    
    
    
    
}
- (void)gohard {
    CCLOG(@"play button pressed");
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


- (void) moreGames {
    CCLOG(@"more games button pressed");
    [MGWU displayCrossPromo];
}

- (void) faceBook {
    
    [MGWU isFacebookActive];
  [MGWU likeAppWithPageId:@"272422779615412"];
//    [MGWU loginToFacebook];
//    [MGWU likeMGWU];
 ;
}

//NSNumber *currentHighScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"];
//int hs = [currentHighScore intValue];
//_scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)z];
@end
