/*
 * AppController.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */
 
@import <Foundation/CPObject.j>
@import "ServerIndicator.j"
@import "Toolbar.j"
@import "SamplesPanel.j"
@import "Sidebar.j"
@import "PageView.j"
@import "FileUploader.j"

serverIndicator = nil;
photoPanel = nil;
windowWidth = 0;
sidebar = nil;

@implementation AppController : CPObject
{
    CPWindowController      photoPanelHandler;
    CPWindowController      samplesPanelHandler;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    ///init main window
    var theWindow = [[CPWindow alloc] initWithContentRect:CGRectMakeZero() styleMask:CPBorderlessBridgeWindowMask],
        contentView = [theWindow contentView],
        bounds = [contentView bounds];
    [contentView setBackgroundColor:[CPColor colorWithHexString:@"cecece"]];

    ///second window to place the toolbar at the bottom
    var w2 = [[CPPanel alloc] initWithContentRect:CGRectMake(0, CGRectGetHeight(bounds) - _settings.toolbarSize,
                                                              CGRectGetWidth(bounds), _settings.toolbarSize)
                               styleMask: CPBorderlessWindowMask],
        c2 = [w2 contentView];
    [w2 setAutoresizingMask:CPViewMinYMargin | CPViewWidthSizable];
    [w2 setLevel:5];
    windowWidth = CGRectGetWidth(bounds);

    ///here place components which are to be on the window

    ///init serverIndicator - an indicator of server activity
    serverIndicator = [[ServerIndicator alloc] init];

    ///a toolbar
    var toolbar = [[Toolbar alloc] initWithWindow:w2];

    ///sidebar - right panel
    sidebar = [[Sidebar alloc] initWithFrame:bounds];
    [sidebar setAutoresizingMask:CPViewMinXMargin | CPViewHeightSizable];
    [sidebar orderFront:self];

    ///pageView
    var pageView = [[PageView alloc] initWithFrame:CGRectMake(
        (CGRectGetWidth(bounds)-_style.width*_settings.commonScale) / 2.0,
        (CGRectGetHeight(bounds)-_style.height*_settings.commonScale -_settings.toolbarSize) / 2.0,
        _style.width*_settings.commonScale,
        _style.height*_settings.commonScale)];
    [pageView setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin];
    [contentView addSubview:pageView];

    ///file upload
    var fileUploader = [[FileUploader alloc] init];
	[fileUploader addObject:photoPanel];

    ///show window
    [theWindow orderFront:self];
    [w2 orderFront:self];
}

- (void)adjustImageSize:(id)sender
{
	// debugger;
    // var newSize = [sender value];

    var newSizeAsString = [CPString stringWithFormat:@"%d", [[CPNumber numberWithDouble:[sender value]] intValue]];
    alert(newSizeAsString);
}

@end