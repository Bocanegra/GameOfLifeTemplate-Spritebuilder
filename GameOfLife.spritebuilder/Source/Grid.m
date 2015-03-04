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
            x += _cellWidth;
        }
        y += _cellHeight;
    }
}

#pragma mark - Interaction methods

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    // Se obtienen las coordenadas del toque
    CGPoint touchLocation = [touch locationInNode:self];
    // Se calcula la creature en ese punto
    Creature *creature = [self creatureForTouchPosition:touchLocation];
    // Si está viva la mata y viceversa
    creature.isAlive = !creature.isAlive;
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition {
    return _gridArray[(int)(touchPosition.x/_cellWidth)][(int)(touchPosition.y/_cellHeight)];
}

@end
