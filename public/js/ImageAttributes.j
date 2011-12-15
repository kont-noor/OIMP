/*
 * ImageAttributes.j
 * ImageEditor
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2010, EZ Intelligence All rights reserved.
 */

@import <AppKit/CPWindowController.j>

@implementation ImageAttributes : CPObject
{
	///canvas style
	JSONArray		attributes;
}

-(id)init
{
	self = [super init];
	
	if (self)
	{
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"download.png"] size:CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];

        var toolbarItem = [toolbar items][3];
		[toolbarItem setImage:image];
        [toolbarItem setTarget:self];
        [toolbarItem setMinSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        [toolbarItem setMaxSize:CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize)];
        [toolbarItem setAction:@selector(save:)];
		attributes = {
			scale:			1,
			rotation:		0,
			offsetX:		0,
			offsetY:		0,
			imageName:		'',
			styleName:		_style.name?'/samples/'+_style.name+'/frame_pane.png':'',
			styleWidth:		_style.width?_style.width:400,
			styleHeight:	_style.height?_style.height:400
		};
	}
	return self;
}

-(void)save:(id)aSender
{
//    if (![serverIndicator isActive])
//    {
        [serverIndicator startActivity];
        setTimeout(function(){ [serverIndicator finishActivity]}, 4000);
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '/save/index';
        form.style.display = 'none';

        for (n in attributes)
        {
            var text = document.createElement('input');
            text.type = 'hidden';
            text.name = "attributes["+n+"]";
            text.value = attributes[n];
            form.appendChild(text);
        }

        iframe = document.createElement('iframe');
        iframe.style.display = 'none';

        document.body.appendChild(iframe);
        iframe.appendChild(form);
        form.submit();
//    }
}

-(void)setAttributes: (float) _scale : (float) _rotation : (float) _offsetX : (float) _offsetY : (CPString) _imageName
{
	attributes['scale'] = _scale;
	attributes['rotation'] = (_rotation*180)/PI;
	attributes['offsetX'] = _offsetX;
	attributes['offsetY'] = _offsetY;
	attributes['imageName'] = _imageName;
}

-(void)setCanvas: (CPString) _styleName : (CGSize) aSize
{
	attributes['styleName'] = _styleName;
	attributes['styleWidth'] = aSize.width;
	attributes['styleHeight'] = aSize.height;
}

@end
