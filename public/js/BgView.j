/*
 * BgView.j
 * Image Editor
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2010, EZ Intelligence All rights reserved.
 */

@import <AppKit/CALayer.j>

@implementation BgLayer : CALayer
{
    CPImage     _image;
    CALayer     _imageLayer;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        _imageLayer = [CALayer layer];
        [_imageLayer setDelegate:self];
        
        
        [self addSublayer:_imageLayer];
		
    }
    
	
    return self;
}

- (void)setBounds:(CGRect)aRect
{
    [super setBounds:aRect];
    
    [_imageLayer setPosition:CGPointMake(CGRectGetMidX(aRect), CGRectGetMidY(aRect))];
}

- (void)setImage:(CPImage)anImage
{
    if (_image == anImage)
        return;
    
    _image = anImage;
    
    if (_image)
        [_imageLayer setBounds:CGRectMake(0.0, 0.0, [_image size].width, [_image size].height)];
    
    [_imageLayer setNeedsDisplay];
}

- (void)imageDidLoad:(CPImage)anImage
{
    [_imageLayer setNeedsDisplay];
}

- (void)drawLayer:(CALayer)aLayer inContext:(CGContext)aContext
{
    var bounds = [aLayer bounds];
    
    if ([_image loadStatus] != CPImageLoadStatusCompleted)
        [_image setDelegate:self];
    else
        CGContextDrawImage(aContext, bounds, _image);
}

@end

@implementation BgView : CPView
{
    CALayer     _rootLayer;
    
    BgLayer		_bgLayer;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    if (self)
    {
        _rootLayer = [CALayer layer];
        
        [self setWantsLayer:YES];
        [self setLayer:_rootLayer];
        
		///background layer
		_bgLayer = [[BgLayer alloc] init];
        [_bgLayer setBackgroundColor:[CPColor blackColor]];
        [_bgLayer setBounds:aFrame];
        [_bgLayer setAnchorPoint:CGPointMakeZero()];
		[_bgLayer setImage:[[CPImage alloc] initWithContentsOfFile:@"/images/bg.jpg" size:CGSizeMake(CGRectGetWidth(aFrame), CGRectGetHeight(aFrame))]];
        
        [_rootLayer addSublayer:_bgLayer];
		[_bgLayer setNeedsDisplay];
		
		[_rootLayer setNeedsDisplay];
    }
    
    return self;
}

@end