//
//  PocketRocketBoardView.m
//  PocketRocket
//
//  Created by Timothy Robb on 01/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import "PocketRocketBoard.h"
#import "PocketRocketBoardTile.h"
#import "PocketRocketBoardColumn.h"

#import <stdlib.h>

@implementation PocketRocketBoard

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupBoard];
        [self fillBoard];
    }
    return self;
}

-(void)setupBoard {
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i < kPocketRocketBoardSize; i++) {
        PocketRocketBoardColumn *column = [[PocketRocketBoardColumn alloc] initWithBoard:self
                                                                                    size:kPocketRocketBoardSize
                                                                                position:i];
        [arr addObject:column];
    }
    
    self.board = arr;
}

-(void)fillBoard {
    self.tiles = @[];
    
    for (PocketRocketBoardColumn *column in _board) {
        self.tiles = [_tiles arrayByAddingObjectsFromArray:column.tiles];
    }
}

-(PocketRocketBoardTile*)createTile {
    PocketRocketBoardTileType type = arc4random_uniform(PocketRocketBoardTileTypeShootingStar+1);
    PocketRocketBoardTile *tile = [[PocketRocketBoardTile alloc] initWithType:type board:self];
    return tile;
}

-(PocketRocketBoardTile*)tileWithColumn:(NSInteger)columnNo row:(NSInteger)rowNo {
    if (columnNo < _board.count) {
        PocketRocketBoardColumn *column = _board[columnNo];
        if (rowNo < column.tiles.count) {
            return column.tiles[rowNo];
        }
    }
    return nil;
}

-(void)swapTile:(PocketRocketBoardTile*)sourceTile withTile:(PocketRocketBoardTile*)destinationTile {
    [UIView animateWithDuration:0.2f
                     animations:^{
                         CGRect sourceFrame = sourceTile.frame;
                         sourceTile.frame = destinationTile.frame;
                         destinationTile.frame = sourceFrame;
                     }];
    
	PocketRocketBoardColumn *sourceColumn = _board[sourceTile.position.column];
    PocketRocketBoardColumn *destinationColumn = _board[destinationTile.position.column];
    
    [sourceColumn moveTile:destinationTile toTile:sourceTile];
    [destinationColumn moveTile:sourceTile toTile:destinationTile];
    
//    [sourceColumn.tiles replaceObjectAtIndex:sourceTile.position.row
//                                  withObject:destinationTile];
//    [destinationColumn.tiles replaceObjectAtIndex:destinationTile.position.row
//                                       withObject:sourceTile];
    
    PocketRocketTilePosition sourcePosition = sourceTile.position;
    sourceTile.position = destinationTile.position;
    destinationTile.position = sourcePosition;
    
//    [sourceTile checkMatch];
//    [destinationTile checkMatch];
}

-(void)clearTiles:(NSArray*)tiles {
    [UIView animateWithDuration:0.2f
                     animations:^{
                         for (PocketRocketBoardTile *tile in tiles) {
                             int x = tile.frame.origin.x + (tile.frame.size.width/2);
                             int y = tile.frame.origin.y + (tile.frame.size.height/2);
                             tile.frame = CGRectMake(x, y, 0, 0);
                             
                             PocketRocketBoardColumn *column = _board[tile.position.column];
                             [column removeTile:tile];
                         }
                     }];
}


@end
