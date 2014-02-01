//
//  PocketRocketBoardView.h
//  PocketRocket
//
//  Created by Timothy Robb on 01/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPocketRocketBoardSize 9
#define kPocketRocketTileSize 32

@class PocketRocketBoardTile;

@interface PocketRocketBoard : UIView

@property (strong, nonatomic) NSArray *board;
@property (strong, nonatomic) NSArray *tiles;

-(PocketRocketBoardTile*)tileWithColumn:(NSInteger)column row:(NSInteger)row;
-(PocketRocketBoardTile*)createTile;
-(void)swapTile:(PocketRocketBoardTile*)sourceTile withTile:(PocketRocketBoardTile*)destinationTile;
-(void)clearTiles:(NSArray*)tiles;

@end
