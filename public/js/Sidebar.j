/*
 * Sidebar.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */
 
 @import <AppKit/CPAccordionView.j>
 @import "PhotoPanel.j"
 
@implementation Sidebar : CPPanel
{
    CPAccordionView     accordion;
}

- (id)initWithFrame:(CGPoint)aFrame
{
    var windowWidth = _settings.sidebarWidth;
    self = [self initWithContentRect:CGRectMake(CGRectGetWidth(aFrame) - windowWidth - _settings.sidebarPosX, _settings.sidebarPosY,
                                                windowWidth, CGRectGetHeight(aFrame) - _settings.sidebarPosY - _settings.sidebarMarginB)
			styleMask:((_settings.sidebarIsResizable?CPResizableWindowMask:nil) |///resizable
                       (_settings.sidebarIsClosable?CPClosableWindowMask:nil) |///closable
                        CPTitledWindowMask)];
    if (self)
    {
        [self setTitle:@"sidebar"];
        [self setFloatingPanel:YES];
        
        var contentView = [self contentView],
            bounds = [contentView bounds];

        ///accordion
        var accordion = [[CPAccordionView alloc] initWithFrame:bounds];
        var firstItem = [[CPAccordionViewItem alloc] initWithIdentifier:"photos"];
        photoPanel = [[PhotoPanel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        [firstItem setView:photoPanel];
        [firstItem setLabel:_lang.my_photos_panel];

        var secondItem = [[CPAccordionViewItem alloc] initWithIdentifier:"templates"];
        [secondItem setView:[[SamplesPanel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)]];
        [secondItem setLabel:_lang.frame_styles_panel];

        [accordion addItem:firstItem];
        [accordion addItem:secondItem];

        [accordion setAutoresizingMask: CPViewWidthSizable | CPViewHeightSizable];
        [contentView addSubview:accordion];
    }

    return self;
}

- (void)addView : (CPView)aView title : (CPString)aTitle
{
    var item = [[CPAccordionViewItem alloc] initWithIdentifier:aTitle];
    [item setView: aView];
    [item setLabel:aTitle];
    [accordion addItem:item];
}

@end
