/*
 * LayerInspector.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */

var commonPageView = nil;

@implementation LayerInspector : CPView
{
    CPCollectionView        layersView;
    CPArray                 layerThumbs;
}
- (id)initWithPageView:(PageView)aView
{    
    self = [super initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    if (self)
    {
        var bounds = [self bounds];

        bounds.size.height -= 40;

        layersView = [[CPCollectionView alloc] initWithFrame:bounds];
        [layersView setAutoresizingMask:CPViewWidthSizable];
        [layersView setMinItemSize:CGSizeMake(_settings.thumbSize, _settings.thumbSize)];
        [layersView setMaxItemSize:CGSizeMake(_settings.thumbSize, _settings.thumbSize)];
        [layersView setDelegate:self];
        var itemPrototype = [[CPCollectionViewItem alloc] init];
        [itemPrototype setView:[[LayersView alloc] initWithFrame:CGRectMakeZero()]];
        [layersView setItemPrototype:itemPrototype];

        var scrollView = [[CPScrollView alloc] initWithFrame:bounds];

        [scrollView setDocumentView:layersView];
        [scrollView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];
        [scrollView setAutohidesScrollers:YES];
        [self addSubview:scrollView];
        commonPageView = aView;

        ///layer buttons
        var segmentedControl = [[CPSegmentedControl alloc] initWithFrame:CGRectMake(4, 4, 0, 40)];///width of segmentedControl is not a mistake..
        [self addSubview:segmentedControl];
        [segmentedControl setSegmentCount:2];
        [segmentedControl setWidth:70 forSegment:0];
        [segmentedControl setWidth:70 forSegment:1];
        [segmentedControl setLabel:@"Add" forSegment:0];
        [segmentedControl setLabel:@"Remove" forSegment:1];
        [segmentedControl setTarget:self];
        [segmentedControl setAction:@"action:"];
    }
    return self;
}

- (void)action:(id)sender
{
    switch ([sender selectedSegment])
    {
        case 0: [commonPageView addLayer:nil];
                break;
        case 1: [commonPageView removeCurrentLayer];
                break;
    }
}

- (void)loadThumbs : (CPArray)layers
{
    layerThumbs = [];
    for (i = 0; i < [layers count]; i++)
    {
        var image = [[CPImage alloc] initWithContentsOfFile:[mainBundle pathForResource:@"layer_bg.png"]];
	[layerThumbs addObject:image];
    }
    [layersView setContent:layerThumbs];
}

@end

@implementation LayersView : CPImageView
{
    CPImageView _imageView;
}

- (void)setSelected:(BOOL)isSelected
{
    [self setBackgroundColor:isSelected ? [CPColor grayColor] : nil];
    if (isSelected)
    {
        var superView = [self superview];
        var superChildren = [superView content];
        var index = [superChildren indexOfObject:[_imageView image]];
        [commonPageView setCurrentLayer:index];
    }
}

- (void)setRepresentedObject:(id)anObject
{
    if (!_imageView)
    {
        _imageView = [[CPImageView alloc] initWithFrame:CGRectInset([self bounds], 3.0, 3.0)];

        [_imageView setImageScaling:CPScaleProportionally];
        [_imageView setAutoresizingMask:CPViewWidthSizable | CPViewHeightSizable];

        [self addSubview:_imageView];
    }

    [_imageView setImage:anObject];
}

@end