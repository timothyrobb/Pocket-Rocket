//
//  PocketRocketTile.m
//  PocketRocket
//
//  Created by Timothy Robb on 01/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import "PocketRocketBoardTile.h"
#import "PocketRocketBoard.h"

@implementation PocketRocketBoardTile

-(id)initWithType:(PocketRocketBoardTileType)type board:(PocketRocketBoard *)board {
    if (self = [super initWithFrame:CGRectMake(0, 0, 32, 32)]) {
        self.type = type;
        self.board = board;
        
        UISwipeGestureRecognizer *upGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tileSwiped:)];
        upGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
        [self addGestureRecognizer:upGestureRecognizer];
        
        UISwipeGestureRecognizer *downGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tileSwiped:)];
        downGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:downGestureRecognizer];
        
        UISwipeGestureRecognizer *leftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tileSwiped:)];
        leftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:leftGestureRecognizer];
        
        UISwipeGestureRecognizer *rightGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tileSwiped:)];
        rightGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:rightGestureRecognizer];
    }
    return self;
}

-(void)setType:(PocketRocketBoardTileType)type {
    _type = type;
    
    self.backgroundColor = [self backgroundColorForType:type];
}

-(UIColor*)backgroundColorForType:(PocketRocketBoardTileType)type {
    switch (type) {
        case PocketRocketBoardTileTypeStar:
            return [UIColor yellowColor];
            break;
            
        case PocketRocketBoardTileTypeUFO:
            return [UIColor greenColor];
            break;
            
        case PocketRocketBoardTileTypeSingularity:
            return [UIColor purpleColor];
            break;
            
        case PocketRocketBoardTileTypeRocket:
            return [UIColor redColor];
            break;
            
        case PocketRocketBoardTileTypePlanet:
            return [UIColor blueColor];
            break;
            
        case PocketRocketBoardTileTypeShootingStar:
            return [UIColor orangeColor];
            break;
            
        default:
            break;
    }
}

#pragma mark - Actions

-(PocketRocketBoardTile*)tileAbove {
    return [_board tileWithColumn:_position.column row:_position.row+1];
}

-(PocketRocketBoardTile*)tileBelow {
    return [_board tileWithColumn:_position.column row:_position.row-1];
}

-(PocketRocketBoardTile*)tileLeft {
    return [_board tileWithColumn:_position.column-1 row:_position.row];
}

-(PocketRocketBoardTile*)tileRight {
    return [_board tileWithColumn:_position.column+1 row:_position.row];
}

-(void)tileSwiped:(UISwipeGestureRecognizer*)gestureRecogniser {
    PocketRocketBoardTile *sourceTile = (PocketRocketBoardTile *) gestureRecogniser.view;
    PocketRocketBoardTile *destinationTile = nil;
    
    switch (gestureRecogniser.direction) {
        case UISwipeGestureRecognizerDirectionUp:
            destinationTile = self.tileAbove;
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            destinationTile = self.tileBelow;
            break;
            
        case UISwipeGestureRecognizerDirectionLeft:
            destinationTile = self.tileLeft;
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            destinationTile = self.tileRight;
            break;
            
        default:
            break;
    }
    
    if (destinationTile) {
        [_board swapTile:sourceTile withTile:destinationTile];
    }
}

-(NSSet*)matchingNeighbours {
    return [self matchingNeighboursWithFoundNeighbours:[NSMutableSet setWithObject:self]];
}

-(NSSet*)matchingNeighboursWithFoundNeighbours:(NSMutableSet*)matches {
    NSMutableSet *neighbours = [NSMutableSet set];
    if (self.tileAbove) {
        [neighbours addObject:self.tileAbove];
    }
    if (self.tileBelow) {
        [neighbours addObject:self.tileBelow];
    }
    if (self.tileLeft) {
        [neighbours addObject:self.tileLeft];
    }
    if (self.tileRight) {
        [neighbours addObject:self.tileRight];
    }
    
    for (PocketRocketBoardTile *neighbour in neighbours) {
        if (neighbour.type == _type && ![matches containsObject:neighbour]) {
            [matches addObject:neighbour];
            [matches addObjectsFromArray:[neighbour matchingNeighboursWithFoundNeighbours:matches].allObjects];
        }
    }
    
    return matches;
}

-(void)checkMatch {
    NSArray *matches = [self matchingNeighbours].allObjects;
    
    if (matches.count > 3) { // TODO: Should replace with some sort of GameRules object later
        [_board clearTiles:matches];
    }
}


@end
