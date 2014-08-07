//
//  HighScore.h
//  pushupking
//
//  Created by Jonathan Alcontin on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//


@interface HighScore : NSObject

@property (nonatomic) NSInteger highscores;


//Static (class) method:
+(HighScore*) sharedData;

//create a singleton that will be accessible from gameplay scene

@end
