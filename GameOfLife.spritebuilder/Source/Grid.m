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

- (void)evolveStep {
    [self cuentaVecinos];
    [self updateCreatures];
    _generation++;
}

#pragma mark - Private methods

- (void)cuentaVecinos {
    for (int i=0; i<[_gridArray count]; i++) {
        for (int j=0; j<[_gridArray[i] count]; j++) {
            Creature *criatura = _gridArray[i][j];
            criatura.livingNeighbors = 0;
            
            for (int x=(i-1); x<=(i+1); x++) {
                for (int y=(j-1); y<=(j+1); y++) {
                    
                    if (!((x==i) && (y==j)) &&  // si no somos nosotros mismos
                        [self isIndexValidForX:x andY:y]) {  // y la coordenada no se sale del array
                        
                        Creature *vecino = _gridArray[x][y];
                        if (vecino.isAlive) {
                            criatura.livingNeighbors ++;
                        }
                    }
                }
            }
        }
    }
}

- (BOOL)isIndexValidForX:(int)x andY:(int)y {
    BOOL isIndexValid = YES;
    if (x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS) {
        isIndexValid = NO;
    }
    return isIndexValid;
}

- (void)updateCreatures {
    int numAlive = 0;
    for (int i=0; i<[_gridArray count]; i++) {
        for (int j=0; j<[_gridArray[i] count]; j++) {
            Creature *criatura = _gridArray[i][j];
            if (criatura.livingNeighbors == 3) {
                criatura.isAlive = YES;
                numAlive++;
            } else if (criatura.livingNeighbors<=1 || criatura.livingNeighbors>=4) {
                criatura.isAlive = NO;
            }
            
        }
    }
    _totalAlive = numAlive;
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
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    return _gridArray[row][column];
}

@end
