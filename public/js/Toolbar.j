/*
 * Toolbar.j
 * ImageEditor
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2010, EZ Intelligence All rights reserved.
 */

@import <Foundation/CPObject.j>
@import "FileUpload.j"

var UploadToolbarItemIdentifier = "UploadToolbarItemIdentifier",
    ServerToolbarItemIdentifier = "ServerToolbarItemIdentifier",
    SaveToolbarItemIdentifier = "SaveToolbarItemIdentifier";

ind = nil;
toolbar = nil;

@implementation Toolbar : CPObject
{
}

- (Toolbar)initWithWindow:(CPWindow)aWindow
{
    self = [super init];
    if (self)
    {
        ///a toolbar
        toolbar = [[BigToolbar alloc] initWithIdentifier:""];
        ///it's enough to comment next string to disable toolbar
        [toolbar setDelegate:self];
        [toolbar setVisible:YES];
        [aWindow setToolbar:toolbar];
    }
    return self;
}

- (void)add:(id)sender
{
    alert([ind backgroundColor]);
}

- (void)remove:(id)sender
{
    alert("Remove clicked");
}

// **************************** Toolbar delegate code ****************************

// Return an array of toolbar item identifier (all the toolbar items that may be present in the toolbar)
- (CPArray)toolbarAllowedItemIdentifiers:(CPToolbar)aToolbar
{
   return [CPToolbarFlexibleSpaceItemIdentifier, UploadToolbarItemIdentifier, SaveToolbarItemIdentifier, ServerToolbarItemIdentifier];
}

// Return an array of toolbar item identifier (the default toolbar items that are present in the toolbar)
- (CPArray)toolbarDefaultItemIdentifiers:(CPToolbar)aToolbar
{
   return [CPToolbarFlexibleSpaceItemIdentifier, UploadToolbarItemIdentifier,
           CPToolbarFlexibleSpaceItemIdentifier, SaveToolbarItemIdentifier,
           CPToolbarFlexibleSpaceItemIdentifier, ServerToolbarItemIdentifier,
           CPToolbarFlexibleSpaceItemIdentifier];
}

// Create the toolbar item that is requested by the toolbar.
- (CPToolbarItem)toolbar:(CPToolbar)aToolbar itemForItemIdentifier:(CPString)anItemIdentifier willBeInsertedIntoToolbar:(BOOL)aFlag
{
	// Create the toolbar item and associate it with its identifier
    var toolbarItem = [[CPToolbarItem alloc] initWithItemIdentifier:anItemIdentifier];

    if (anItemIdentifier == UploadToolbarItemIdentifier)
    {
		var browseView = [[CPView alloc] initWithFrame: CGRectMake(
                0, 0,
                _settings.toolbarItemSize, _settings.toolbarItemSize
            )];

        [toolbarItem setView:browseView];
        [toolbarItem setLabel:_lang.upload_images_button1];

        [toolbarItem setMinSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        [toolbarItem setMaxSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
    }
    ///save button
    else if (anItemIdentifier == SaveToolbarItemIdentifier)
    {
        [toolbarItem setLabel:_lang.attr_save];

        [toolbarItem setMinSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        [toolbarItem setMaxSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
    }
    else if (anItemIdentifier == ServerToolbarItemIdentifier)
    {
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"server.png"] size:CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        [toolbarItem setImage:image];
        [toolbarItem setEnabled:false];
        [toolbarItem setLabel:_lang.server_indicator];

        [toolbarItem setMinSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        [toolbarItem setMaxSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        ind = toolbarItem;
    }

    return toolbarItem;
}

@end

@implementation BigToolbar : CPToolbar
{
}

- (CPView)_toolbarView {
	if (!_toolbarView) {
		_toolbarView = [[_CPToolbarView alloc] initWithFrame:CPRectMake(0.0, 0.0, 120.0, _settings.toolbarSize)];
        [_toolbarView setBackgroundColor:[CPColor colorWithHexString:@"676767"]];
        [_toolbarView setAlphaValue:0.5];
		[_toolbarView setToolbar:self];
		[_toolbarView setAutoresizingMask:CPViewWidthSizable];
		[_toolbarView reloadToolbarItems];
	}
	return _toolbarView;
}
@end