//
//  PocketRocketTile.h
//  PocketRocket
//
//  Created by Timothy Robb on 01/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _PocketRocketBoardTileType {
    PocketRocketBoardTileTypeStar,
    PocketRocketBoardTileTypePlanet,
    PocketRocketBoardTileTypeRocket,
    PocketRocketBoardTileTypeUFO,
    PocketRocketBoardTileTypeSingularity,
    PocketRocketBoardTileTypeShootingStar
} PocketRocketBoardTileType;

typedef struct PocketRocketTilePosition {
    NSInteger column;
    NSInteger row;
} PocketRocketTilePosition;

static inline PocketRocketTilePosition
PocketRocketTilePositionMake(NSInteger column, NSInteger row) {
    PocketRocketTilePosition p; p.column = column; p.row = row; return p;
}

@class PocketRocketBoard;

@interface PocketRocketBoardTile : UIView

@property (nonatomic, strong) PocketRocketBoard *board;
@property (nonatomic, assign) PocketRocketBoardTileType type;
@property (nonatomic, assign) PocketRocketTilePosition position;

@property (readonly) PocketRocketBoardTile *tileAbove;
@property (readonly) PocketRocketBoardTile *tileBelow;
@property (readonly) PocketRocketBoardTile *tileLeft;
@property (readonly) PocketRocketBoardTile *tileRight;

-(id)initWithType:(PocketRocketBoardTileType)type board:(PocketRocketBoard*)board;
-(NSSet*)matchingNeighbours;
-(void)checkMatch;

@end
