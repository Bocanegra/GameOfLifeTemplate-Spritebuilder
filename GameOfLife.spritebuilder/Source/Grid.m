//
//  Grid.m
//  GameOfLife
//
//  Created by Luis Ángel García Muñoz on 27/2/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"

static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;

@implementation Grid {
    NSMutableArray *_gridArray;
    float _cellWidth;
    float _cellHeight;
}

- (void)onEnter {
    [super onEnter];
    [self setupGrid];
    self.userInteractionEnabled = YES;
}

- (void)setupGrid {
    // Calculamos el ancho y alto de cada celda
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0.0, y = 0.0;
    _gridArray = [NSMutableArray array];
    
    for (int i=0; i<GRID_ROWS; i++) {
        _gridArray[i] = [NSMutableArray array];
        x = 0;
        
        for (int j=0; j<GRID_COLUMNS; j++) {
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            [self addChild:creature];
            _gridArray[i][j] = creature;
            creature.isAlive = YES;
            x += _cellWidth;
        }
        y += _cellHeight;
    }
}

@end
