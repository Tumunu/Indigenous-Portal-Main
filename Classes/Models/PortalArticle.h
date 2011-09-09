//
//  Article.h
//  iPortal
//
//  Created by Cleave Pokotea on 9/09/11.
//  Copyright (c) 2011 Tumunu. All rights reserved.
//
// Singleton

#import <Foundation/Foundation.h>

@interface PortalArticle : NSObject
{
    NSString * cellURL;
    int whatView;
}

@property (nonatomic, retain) NSString * cellURL;
@property (nonatomic) int whatView;


@end
