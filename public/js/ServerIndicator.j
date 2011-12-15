/*
 * ServerIndicator.j
 * ImageEditor
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2010, EZ Intelligence All rights reserved.
 */


/**
 * this class indicates if we send requests to the server
 */

@implementation ServerIndicator : CPObject
{
    int             serverActivities;
    CPArray         views;
    CPView          view;
    CPImage         image1, image2;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        views = [];
        serverActivities = 0;
        image2 = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"spinner2.gif"] size:CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        image1 = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"server.png"] size:CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
    }
    return self;
}

-(void)startActivity
{
    if (!serverActivities)
    {
        [self setViews:true];
    }
    serverActivities++;
}

-(void)finishActivity
{
    if (serverActivities > 0)
    {
        serverActivities--;
        if (!serverActivities)
            [self setViews:false];
    }
    else
        serverActivities = 0;
}

-(BOOL)isActive
{
    return  serverActivities?true:false;
}

-(id)addView
{
    var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"remove.png"] size:CPSizeMake(30, 25)];
    //var view = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
    view = [[CPView alloc] initWithFrame:CGRectMake(0, 0, 80, 24)];
    [view setBackgroundColor: [CPColor colorWithHexString:@"777"]];
    [views addObject:view];
    return view;
}

///sets
-(void)setViews:(BOOL)isActive
{
    [[toolbar items][5]  setEnabled:isActive];
    [[toolbar items][5]  setImage:isActive?image2:image1];
}

@end