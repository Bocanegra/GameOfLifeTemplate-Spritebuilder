//
//  Creature.m
//  GameOfLife
//
//  Created by Luis Ángel García Muñoz on 27/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Creature.h"

@implementation Creature

- (instancetype)initCreature {
    // since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    self = [super initWithImageNamed:@"GameOfLifeAssets/Assets/bubble.png"];
    if (self) {
        self.isAlive = NO;
    }
    return self;
}

- (void)setIsAlive:(BOOL)newState {
    _isAlive = newState;
    self.visible = _isAlive;
}

@end
