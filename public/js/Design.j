/*
 * Design.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */

@import "Page.j"

@implementation Design : CPObject
{
    CPArray         pages;
    int             currentPage;
    PageView        view;
}

- (id)initWithView : (PageView)aView
{
    self = [super init];
    
    if (self)
    {
        var page = [[Page alloc] init];
        pages = [[CPArray alloc] init];
        [pages addObject:page];
        currentPage = 0;
        view = aView;
    }
    return self;
}

- (void)load
{
}

- (void)save
{
}

- (void)setCurrentPage : (int)number
{
    currentPage = number;
}

- (void)addPage : (Page)aPage
{
    ///add to the end
    [self addPage:aPage toPlace:[pages count]];
}

- (void)addPage : (Page)aPage toPlace : (int)number
{   
}

- (void)loadCurrentPage : (JSON)template
{
    [pages[currentPage] load:template];
    [self redrawCurrentPage];
}

- (void)redrawCurrentPage
{
    [pages[currentPage] redrawOnView:view];
}

- (void)removeCurrentPage
{
}

@end