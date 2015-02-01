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
        // create and initialize a label
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"Hello World"
                                               fontName:@"Verdana-Bold"//@"Marker Felt"
                                               fontSize:64];
        
        // get the window (screen) size from CCDirector
        CGSize size = [[CCDirector sharedDirector] viewSize];
        // position the label at the center of the screen
        label.position = CGPointMake(size.width / 2, size.height / 2);
        //add the label as a child to this Layer
        [self addChild:label];
    }
    return self;
}
@end
