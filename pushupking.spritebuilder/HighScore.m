//
//  HighScore.m
//  pushupking
//
//  Created by Jonathan Alcontin on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "HighScore.h"
#import <mgwuSDK/MGWU.h>
@implementation HighScore

static HighScore *sharedData = nil;

+(HighScore*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        //create our singleton instance
        sharedData = [[HighScore alloc] init];
        
        NSNumber *highscores = [[NSUserDefaults standardUserDefaults]objectForKey:@"savedHighscores"];
        sharedData.highscores = [highscores integerValue];
        
        [MGWU setObject:highscores forKey:@"savedHighscores"];
        highscores = [MGWU objectForKey:@"savedHighscores"];
        [MGWU removeObjectForKey:@"savedHighscores"];
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

- (void)setHighscores:(NSInteger)highscores {
    _highscores = highscores;
    NSNumber *highscoreNumber = [NSNumber numberWithInteger:highscores];
    
    [[NSUserDefaults standardUserDefaults]setObject:highscoreNumber forKey:@"savedHighscores"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
