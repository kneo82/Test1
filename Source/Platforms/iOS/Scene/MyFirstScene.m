//
//  MyFirstScene.m
//  Test1
//
//  Created by Admin on 01.02.15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MyFirstScene.h"

@implementation MyFirstScene

-(id) init {
    if ((self = [super init]))
    {
        [self setUserInteractionEnabled:YES];
        
        // create and initialize a label
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"Hello World"
                                               fontName:@"Marker Felt"
                                               fontSize:64];
        
        // get the window (screen) size from CCDirector
        CGSize size = [[CCDirector sharedDirector] viewSize];
        // position the label at the center of the screen
        label.position = CGPointMake(size.width / 2, size.height / 2);
        //add the label as a child to this Layer
        [self addChild:label];
        
        self.colorRGBA = [CCColor colorWithCcColor4b:ccc4(20, 35, 20, 255)];

        CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Settings@2x.png"];
        
        sprite.position = ccp(100, 100);
        
        [self addChild:sprite];
    }
    
    return self;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    NSLog(@"Touch start");
}

- (void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    NSLog(@"Touch end");
}



@end
