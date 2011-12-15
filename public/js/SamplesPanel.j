/*
 * SamplesPanel.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */
 
 @import "Ajax.j"

TemplateDragType = "TemplateDragType";
 
@implementation SamplesPanel : CPView
{
	CPArray                 templates;
	CPArray                 thumbs;
	CPCollectionView	photosView;
}

- (id)initWithFrame:(CGPoint)aFrame
{
    self = [super initWithFrame:aFrame];
    if (self)
    {   
        var bounds = [self bounds];
        bounds.size.height -= _settings.sidebarPaddingB;
			
        photosView = [[CPCollectionView alloc] initWithFrame:bounds];
        
        [photosView setAutoresizingMask:CPViewWidthSizable];
        [photosView setMinItemSize:CGSizeMake(_settings.thumbSize, _settings.thumbSize)];
        [photosView setMaxItemSize:CGSizeMake(_settings.thumbSize, _settings.thumbSize)];
        [photosView setDelegate:self];
		
        var itemPrototype = [[CPCollectionViewItem alloc] init];
        
        [itemPrototype setView:[[PhotoView alloc] initWithFrame:CGRectMakeZero()]];
        
        [photosView setItemPrototype:itemPrototype];
        
        var scrollView = [[CPScrollView alloc] initWithFrame:bounds];
        
        [scrollView setDocumentView:photosView];
        [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [scrollView setAutohidesScrollers:YES];
        [scrollView setHasVerticalScroller:_settings.sidebarHasScroller];
		
        [self addSubview:scrollView];

        var styleName = _style.name || "";
        [self getStyles:styleName];
    }

    return self;
}

- (void)getStyles:(CPString)styleName
{
    if (styleName)
    {
        templates = [];
        var url = '/samples/' + styleName + '/frame_thumb.png';
        var frame = [[CPImage alloc] initWithContentsOfFile:url];
        [templates addObject:frame];
        [photosView setContent:templates];
    }
    else
    {
        var ajax = [[Ajax alloc] init];
        var parameters = {
            type: 'get',
            url: '/data_rendering/styles',
            async: false,
            success: function(data)
            {
                templates = [];
                thumbs = [];
                if (data != '')
                {
                    stylesList = eval("(" + data + ')');
                    if (stylesList)
                    {
                        for (i = 0; i < stylesList.length; i++)
                        {
                            ///try to load style.json file
                            var parameters = {
                                type: 'get',
                                url: '/samples/' + stylesList[i] + '/style.json',
                                async: false,
                                success: function(data)
                                {
                                    var style = eval("(" + data + ')');
                                    var url = '/samples/' + style.name + '/' + style.thumb;
                                    var thumb = [[CPImage alloc] initWithContentsOfFile:url];
                                    [templates addObject:style];
                                    [thumbs addObject:thumb];
                                }
                            };
                            [ajax get:parameters];
                        }

                    }
                }

                [photosView setContent:thumbs];
            }
        };
        [ajax get:parameters];
    }
}

- (CPData)collectionView:(CPCollectionView)aCollectionView dataForItemsAtIndexes:(CPIndexSet)indices forType:(CPString)aType
{
    return [CPKeyedArchiver archivedDataWithRootObject:[templates objectAtIndex:[indices firstIndex]]];
}

- (CPArray)collectionView:(CPCollectionView)aCollectionView dragTypesForItemsAtIndexes:(CPIndexSet)indices
{
    return [TemplateDragType];
}

@end
