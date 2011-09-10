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
    NSString *articleURL;
    int whatView;
}

@property (nonatomic, retain) NSString *articleURL;
@property (nonatomic) int whatView;


@end
