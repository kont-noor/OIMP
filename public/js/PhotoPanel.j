/*
 * PhotoPanel.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */

 @import "Ajax.j"


PhotoDragType = "PhotoDragType";

@implementation PhotoPanel : CPView
{
    CPArray                 images;
    CPCollectionView        photosView;
}

- (id)initWithFrame: (CGRect)aFrame
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

        //[[scrollView contentView] setBackgroundColor:[CPColor whiteColor]];

        [self addSubview:scrollView];
        
                    
		///loading images
		images = [];
		[self loadImages];
		[photosView setContent:images];
		
    }

    return self;
}

- (void)loadImages
{
	var imagesObject = null;
	var parameters = {
		type: 'get',
		url: '/data_rendering/images',
        async: false,
		success: function(data){
			if (data != '')
			{
				imagesObject = eval("(" + data + ')');
				if (imagesObject)
				{
                    /**
                     * this strange structure is for loading images to the end of images list
                     */
					if (images.length)///if images list is not empty
					{
						for (i = images.length; i < imagesObject.files.length; i++)
						{
							var url = imagesObject.path + 'thumb_' + imagesObject.files[i];
							var image = [[CPImage alloc] initWithContentsOfFile:url];
							[images addObject:image];
						}
					}
					else
					{
						for (i = 0; i < imagesObject.files.length; i++)
						{
							var url = imagesObject.path + 'thumb_' + imagesObject.files[i];
							var image = [[CPImage alloc] initWithContentsOfFile:url];
							[images addObject:image];
						}
					}
					[photosView reloadContent];
				}
			}
		}
	};
	[ajax get:parameters];
}

- (CPData)collectionView:(CPCollectionView)aCollectionView dataForItemsAtIndexes:(CPIndexSet)indices forType:(CPString)aType
{
    return [CPKeyedArchiver archivedDataWithRootObject:[images objectAtIndex:[indices firstIndex]]];
}

- (CPArray)collectionView:(CPCollectionView)aCollectionView dragTypesForItemsAtIndexes:(CPIndexSet)indices
{
    return [PhotoDragType];
}

@end

@implementation PhotoView : CPImageView
{
    CPImageView _imageView;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
}

- (void)setRepresentedObject:(id)anObject
{
    if (!_imageView)
    {
        _imageView = [[CPImageView alloc] initWithFrame:CGRectInset([self bounds], 5.0, 5.0)];
        
        [_imageView setImageScaling:CPScaleProportionally];
        [_imageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        
        [self addSubview:_imageView];
    }
    
    [_imageView setImage:anObject];
}

@end

