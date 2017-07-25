//
//  LPMovie.h
//  MovieSearch-Obj-C
//
//  Created by Luis Puentes on 7/25/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger rating;
@property (nonatomic, copy, readonly) NSString *summary;
@property (nonatomic, copy, readonly) NSString *movieImage;

- (instancetype)initWithTitle:(NSString *)title rating:(NSInteger)rating summary:(NSString *)summary movieImage: (NSString *)movieImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
