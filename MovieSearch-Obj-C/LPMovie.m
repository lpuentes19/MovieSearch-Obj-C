//
//  LPMovie.m
//  MovieSearch-Obj-C
//
//  Created by Luis Puentes on 7/25/17.
//  Copyright © 2017 LuisPuentes. All rights reserved.
//

#import "LPMovie.h"

@implementation LPMovie

- (instancetype)initWithTitle:(NSString *)title rating:(NSInteger)rating summary:(NSString *)summary movieImage:(NSString *)movieImage
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _summary = [summary copy];
        _movieImage = [movieImage copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSInteger rating = [dictionary[@"vote_average"] integerValue];
    NSString *summary = dictionary[@"overview"];
    NSString *movieImage = dictionary[@"poster_path"];
    
    if (![title isKindOfClass:[NSString class]] || ![summary isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return [self initWithTitle:title rating:rating summary:summary movieImage:movieImage];
}

@end
