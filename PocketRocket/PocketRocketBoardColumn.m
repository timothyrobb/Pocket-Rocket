//
//  PocketRocketBoardColumn.m
//  Pocket Rocket
//
//  Created by Timothy Robb on 02/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import "PocketRocketBoardColumn.h"
#import "PocketRocketBoard.h"
#import "PocketRocketBoardTile.h"

@interface PocketRocketBoardColumn ()

@property (nonatomic, strong) NSMutableArray *tilesData;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger position;

@end

@implementation PocketRocketBoardColumn

-(id)initWithBoard:(PocketRocketBoard*)board size:(NSInteger)size position:(NSInteger)position {
    if (self = [super init]) {
        self.board = board;
        self.size = size;
        self.position = position;
        self.tilesData = [NSMutableArray array];
        
        [self fill];
    }
    return self;
}

-(void)fill {
    while (_size - _tilesData.count != 0) {
        PocketRocketBoardTile *tile = [_board createTile];
        tile.position = PocketRocketTilePositionMake(_position, _tilesData.count);
        
        int x = (_position * (kPocketRocketTileSize + 1)) + 2;
        int y = _board.frame.size.height - ((kPocketRocketTileSize + 1) * (_tilesData.count + 1));
        tile.frame = CGRectMake(x, y, tile.frame.size.width, tile.frame.size.height);
        [self addTile:tile];
    }
}

-(NSArray*)tiles {
    return [NSArray arrayWithArray:_tilesData];
}

-(void)addTile:(PocketRocketBoardTile*)tile {
    [_board addSubview:tile];
    [_tilesData addObject:tile];
}

-(void)removeTile:(PocketRocketBoardTile*)tile {
    [tile removeFromSuperview];
    [_tilesData removeObject:tile];
    
    __block PocketRocketBoardTile *newTile = tile;
    
    [UIView animateWithDuration:0.2f
                     animations:^{
                         while ((newTile = newTile.tileAbove)) {
                             [self dropTile:newTile];
                         }
                     }];
    [self fill];
}

-(void)dropTile:(PocketRocketBoardTile*)tile {
    tile.frame = CGRectMake(tile.frame.origin.x,
                            tile.frame.origin.y+tile.frame.size.height+1,
                            tile.frame.size.width,
                            tile.frame.size.height);
    tile.position = PocketRocketTilePositionMake(tile.position.column, tile.position.row-1);
}

-(void)moveTile:(PocketRocketBoardTile*)sourceTile toTile:(PocketRocketBoardTile*)destinationTile {
    [_tilesData replaceObjectAtIndex:destinationTile.position.row
                                  withObject:sourceTile];
}

@end
