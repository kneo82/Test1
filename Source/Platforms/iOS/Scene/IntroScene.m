//
//  IntroScene.m
//  Test1
//
//  Created by Voronok Vitaliy on 2/3/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "IntroScene.h"
#import "MyFirstScene.h"
@implementation IntroScene

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (self) {
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    // Spinning scene button
    CCButton *spinningButton = [CCButton buttonWithTitle:@"[ Simple Sprite ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    spinningButton.positionType = CCPositionTypeNormalized;
    spinningButton.position = ccp(0.5f, 0.35f);
    [spinningButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:spinningButton];
    
    // Next scene button
    CCButton *newtonButton = [CCButton buttonWithTitle:@"[ Newton Physics ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    newtonButton.positionType = CCPositionTypeNormalized;
    newtonButton.position = ccp(0.5f, 0.20f);
    [newtonButton setTarget:self selector:@selector(onNewtonClicked:)];
    [self addChild:newtonButton];
    
    // done
    }
    
    return self;
}

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[MyFirstScene node]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

- (void)onNewtonClicked:(id)sender
{
    // start newton scene with transition
    // the current scene is pushed, and thus needs popping to be brought back. This is done in the newton scene, when pressing back (upper left corner)
//    [[CCDirector sharedDirector] pushScene:[NewtonScene scene]
//                            withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}


@end
