//
//  LPMovieController.h
//  MovieSearch-Obj-C
//
//  Created by Luis Puentes on 7/25/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LPMovie.h"



@interface LPMovieController : NSObject

+ (LPMovieController *)shared;

- (void)fetchMovieForSearchTerm:(NSString *)searchTerm completion:(void(^) (NSArray *movies))completion;

- (void)fetchMovieImage:(NSString *)imageURLString completion:(void(^) (UIImage*))completion;

- (NSString *)fetchAPIFromPlist;

@end

