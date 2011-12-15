/*
 * FileUploader.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */
 
@import <AppKit/CPPanel.j>
@import "FileUpload.j"

@implementation FileUploader : CPObject
{
	UploadButton    browseButton;
	PhotoPanel      photoPanel;
}

- (id)init
{
    self = [super init];

    if (self)
    {
		///select image for upload button
		browseButton = [[UploadButton alloc] initWithFrame: CGRectMake(
                0, 0,
                _settings.toolbarItemSize, _settings.toolbarItemSize
            )];

		[browseButton setTitle:_lang.upload_images_button1];
		[browseButton setURL:@"/translator/index"];
		[browseButton setName:@"file"];
        if (__browser.iphone)
        {
            [browseButton setTarget:self];
            [browseButton setAction:@selector(upload:)];
        }
		
		[browseButton setAutoresizingMask:CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin];
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"upload.png"] size:CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
		[browseButton setImage:image];
		
		[[[toolbar items][1]  view] addSubview:browseButton];
		
    }

    return self;
}

-(void)upload:(id)aSender
{
    var start = new Date();
    setTimeout(function()
    {
        if (new Date() - start > 2000)
        {
            return;
        }
        window.location = 'http://www.cliqcliq.com/quickpic/install/';
    }, 1000);

    var getParams = ['action=http://192.168.0.85:3000//uploader/index',
                 'continue=http://192.168.0.85:3000',
                 'contact=0,1:email',
                 'images=1+',
                 'video=1+',
                 'context=ABCDEF0123456789',
                 'passcontext=1',
                 'maxsize=422',
                 'edit=1',
                 'v=1.2'];
    window.location = 'vquickpic://?' + getParams.join('&');
}

-(void)addObject:(id)anObject
{
	photoPanel = anObject;
	[browseButton addObject:anObject];
}

@end
