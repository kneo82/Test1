//
//  MyFirstScene.m
//  Test1
//
//  Created by Admin on 01.02.15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "MyFirstScene.h"
#import "IntroScene.h"

@interface MyFirstScene () <CCPhysicsCollisionDelegate>
@property (nonatomic, strong)   CCSprite    *player;
@property (nonatomic, strong)   CCPhysicsNode   *physicsWorld;

@end

@implementation MyFirstScene

- (id)init {
    self = [super init];
    if (!self) return(nil);

    self.userInteractionEnabled = YES;
    
    [[OALSimpleAudio sharedInstance] playBg:@"background-music-aac.caf" loop:YES];
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3f green:0.3 blue:0.3f alpha:1.0f]];
    [self addChild:background];
    
    CCPhysicsNode   *physicsWorld = [CCPhysicsNode node];
    physicsWorld.gravity = ccp(0,0);
//    physicsWorld.debugDraw = YES;
    physicsWorld.collisionDelegate = self;
    [self addChild:physicsWorld];
    
    self.physicsWorld = physicsWorld;
    
    CCSprite *player = [CCSprite spriteWithImageNamed:@"player.png"];

    player.position  = ccp(self.contentSize.width/8,self.contentSize.height/2);
    player.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, player.contentSize} cornerRadius:0]; // 1
    player.physicsBody.collisionGroup = @"playerGroup"; // 2
    player.physicsBody.collisionType  = @"playerCollision";
    [physicsWorld addChild:player];
    
    self.player = player;

    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    return self;
}

- (void)onBackClicked:(id)sender {
    [[CCDirector sharedDirector] replaceScene:[IntroScene node]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

- (void)addMonster:(CCTime)dt {
    CCSprite *monster = [CCSprite spriteWithImageNamed:@"monster.png"];
    
    int minY = monster.contentSize.height / 2;
    int maxY = self.contentSize.height - monster.contentSize.height / 2;
    int rangeY = maxY - minY;
    int randomY = (arc4random_uniform(rangeY) + minY);

    monster.position = CGPointMake(self.contentSize.width + monster.contentSize.width/2, randomY);
//    [self addChild:monster];
    monster.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, monster.contentSize} cornerRadius:0];
    monster.physicsBody.collisionGroup = @"monsterGroup";
    monster.physicsBody.collisionType  = @"monsterCollision";
    [self.physicsWorld addChild:monster];

    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int randomDuration = arc4random_uniform(rangeDuration) + minDuration;

    CCAction *actionMove = [CCActionMoveTo actionWithDuration:randomDuration position:CGPointMake(-monster.contentSize.width/2, randomY)];
    CCAction *actionRemove = [CCActionRemove action];
    [monster runAction:[CCActionSequence actionWithArray:@[actionMove,actionRemove]]];
}

- (void)onEnter {
    [super onEnter];
    
    [self schedule:@selector(addMonster:) interval:1.5];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInNode:self];

    CGPoint offset    = ccpSub(touchLocation, self.player.position);
    float   ratio     = offset.y / offset.x;
    int     targetX   = self.player.contentSize.width / 2 + self.contentSize.width;
    int     targetY   = (targetX * ratio) + self.player.position.y;
    CGPoint targetPosition = ccp(targetX, targetY);
    CCSprite *projectile = [CCSprite spriteWithImageNamed:@"projectile.png"];
    projectile.position = self.player.position;
//    [self addChild:projectile ];
    projectile.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:projectile.contentSize.width/2.0f andCenter:projectile.anchorPointInPoints];
    projectile.physicsBody.collisionGroup = @"playerGroup";
    projectile.physicsBody.collisionType  = @"projectileCollision";
    [self.physicsWorld addChild:projectile];

    CCActionMoveTo *actionMove   = [CCActionMoveTo actionWithDuration:1.5f position:targetPosition];
    CCActionRemove *actionRemove = [CCActionRemove action];
    [projectile runAction:[CCActionSequence actionWithArray:@[actionMove, actionRemove]]];
    [[OALSimpleAudio sharedInstance] playEffect:@"pew-pew-lei.caf"];
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair
               monsterCollision:(CCNode *)monster
            projectileCollision:(CCNode *)projectile
{
    [monster removeFromParent];
    [projectile removeFromParent];
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair
               playerCollision:(CCNode *)monster
            monsterCollision:(CCNode *)projectile
{
    [monster removeFromParent];
    [projectile removeFromParent];
    return YES;
}

@end
