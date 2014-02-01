//
//  PocketRocketBoardColumn.h
//  Pocket Rocket
//
//  Created by Timothy Robb on 02/02/2014.
//  Copyright (c) 2014 InvaderTim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PocketRocketBoard;
@class PocketRocketBoardTile;

@interface PocketRocketBoardColumn : NSObject

@property (nonatomic, strong) PocketRocketBoard *board;
@property (readonly) NSArray *tiles;
@property (readonly) NSInteger size;
@property (readonly) NSInteger position;

-(id)initWithBoard:(PocketRocketBoard*)board size:(NSInteger)size position:(NSInteger)position;

-(void)moveTile:(PocketRocketBoardTile*)sourceTile toTile:(PocketRocketBoardTile*)destinationTile;

-(void)addTile:(PocketRocketBoardTile*)tile;
-(void)removeTile:(PocketRocketBoardTile*)tile;

@end
