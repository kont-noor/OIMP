/*
 * PageView.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */

@import <AppKit/CALayer.j>

@import "Selection.j"
@import "SamplesPanel.j"
@import "PhotoPanel.j"
@import "ImageAttributes.j"
@import "BgView.j"
@import "Ajax.j"
@import "Design.j"
@import "LayerInspector.j"


@implementation PaneLayer : CALayer
{
    float       _rotationRadians;
    float       _scaleX;
    float       _scaleY;
    float       _offsetX;
    float       _offsetY;
    CPString	imageName;
    CGPoint     basePosition;
    CGPoint     tmpOffset;
    
    CPImage     _image;
    CALayer     _imageLayer;
    
    PageView    _pageView;
	
    ImageAttributes imageAttributes;
}

-(void)getImageAttributes
{
}

- (id)initWithPageView:(PageView)anPageView
{
    self = [super init];
    
    if (self)
    {
        _pageView = anPageView;
        
        _rotationRadians = 0.0;
        _scaleX = 1.0;
        _scaleY = 1.0;
        _positionX = 0.0;
        _positionY = 0.0;
        
        _imageLayer = [CALayer layer];
		[self setBackgroundColor:[CPColor blueColor]];
        [_imageLayer setDelegate:self];
        
        
        [self addSublayer:_imageLayer];
		basePosition = [_imageLayer position];

        [self redisplay];
		[self initImageAttributes];
    }
    
	
    return self;
}

- (void)setCommonSize: (CGSize)aSize
{
	[_imageLayer setBounds:CGRectMake(0, 0, aSize.width, aSize.height)];
}

- (PageView)pageView
{
    return _pageView;
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
	[self setImageAttributes];
    
    if (_image)
        [_imageLayer setBounds:CGRectMake(0.0, 0.0, [_image size].width, [_image size].height)];
    
    [_imageLayer setNeedsDisplay];
    [self setScaleX:_scaleX];
    [self setScaleY:_scaleY];
}

- (CPImage)image
{
	return _image;
}


- (void)redisplay
{
    [_imageLayer setAffineTransform:CGAffineTransformScale(CGAffineTransformMakeRotation(_rotationRadians), _scaleX*_settings.commonScale, _scaleY*_settings.commonScale)];
    [self setImageAttributes];
}

- (void)setRotationRadians:(float)radians
{
    if (_rotationRadians == radians)
        return;
        
    _rotationRadians = radians;

    [self redisplay];
}

- (float)getRotationRadians
{
	return _rotationRadians;
}

- (void)setScaleX:(float)aScale
{
    if (_scaleX == aScale)
        return;
    
    _scaleX = aScale;
    
    [self redisplay];
}

- (float)getScaleX
{
	return _scaleX;
}

- (void)setScaleY:(float)aScale
{
    if (_scaleY == aScale)
        return;

    _scaleY = aScale;

    [self redisplay];
}

- (float)getScaleY
{
	return _scaleY;
}

- (void)setOffsetX:(float)anOffset
{
	if (_offsetX == anOffset)
		return;
	var posX = [_imageLayer position].x;
	var posY = [_imageLayer position].y;
	posX -= _offsetX*_settings.commonScale;
	posX += anOffset;
	_offsetX = anOffset/_settings.commonScale;
	[_imageLayer setPosition:{x:posX, y:posY}];
    [self redisplay];
}

- (float)getOffsetX
{
	return _offsetX;
}

- (void)setOffsetY:(float)anOffset
{
	if (_offsetY == anOffset)
		return;
	var posX = [_imageLayer position].x;
	var posY = [_imageLayer position].y;
	posY -= _offsetY*_settings.commonScale;
	posY += anOffset;
	_offsetY = anOffset/_settings.commonScale;
	[_imageLayer setPosition:{x:posX, y:posY}];
    [self redisplay];
}

- (float)getOffsetY
{
	return _offsetY;
}

- (void)drawInContext:(CGContext)aContext
{
    //CGContextSetFillColor(aContext, [CPColor grayColor]);
    //CGContextFillRect(aContext, [self bounds]);
}

- (ImageAttributes)getAttributes
{
	return imageAttributes;
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

-(void)initImageAttributes
{
	imageAttributes = [[ImageAttributes alloc] init];
}

-(void)setImageAttributes
{
	[imageAttributes setAttributes:_scaleX :_rotationRadians :_offsetX :_offsetY :[_image filename]];
}

- (void)rememberOffset : (CGPoint)anOffset
{
    tmpOffset = anOffset;
}

- (CGPoint)readOffset
{
    return tmpOffset;
}

@end
/// ------------------------------------------------------------Page View--------------------------------------------------------------------------------------------
@implementation PageView : CPView
{
    CALayer         _rootLayer;

    CPArray         layers;
    int             current;
    BOOL            _isActive;
    int             mouseX;
    int             mouseY;
    int             offsetX;
    int             offsetY;
    BOOL            mousedown;
    ImageAttributes frameAttributes;
    CGRect          commonBounds;
    CGSize          commonSize;
    Selection       selection;
    Design          design;
    LayerInspector  layerInspector;
}

- (id)initWithFrame:(CGRect)aFrame
{
    self = [super initWithFrame:aFrame];
    
    commonBounds = CGRectMake(0.0, 0.0, CGRectGetWidth(aFrame), CGRectGetHeight(aFrame));
    commonSize = CGSizeMake(CGRectGetWidth(aFrame), CGRectGetHeight(aFrame));
    
    if (self)
    {
        layers = [];
        design = [[Design alloc] initWithView:self];
        _rootLayer = [CALayer layer];
        
        [self setWantsLayer:YES];
        [self setLayer:_rootLayer];
        
        ///background layer
        _bgLayer = [[BgLayer alloc] init];
        [_bgLayer setBounds:commonBounds];
        [_bgLayer setAnchorPoint:CGPointMakeZero()];
        [_bgLayer setImage:[[CPImage alloc] initWithContentsOfFile:@"/js/Resources/layer_bg.png" size:commonSize]];
        
        [_rootLayer addSublayer:_bgLayer];
        [_bgLayer setNeedsDisplay];

        [_rootLayer setDelegate:self];
        
        [self registerForDraggedTypes:[PhotoDragType]];
        [self registerForDraggedTypes:[TemplateDragType]];

        ///init selection tool
        selection = [[Selection alloc] initWithRootLayer:_rootLayer];
        layerInspector = [[LayerInspector alloc] initWithPageView:self];
        [sidebar addView:layerInspector title:@"layers"];
        [layerInspector loadThumbs:layers];
    }
    
    return self;
}

- (void)setEditing:(BOOL)isEditing
{
//    [_borderLayer setOpacity:isEditing ? 0.5 : 1.0];
}

- (void)drawLayer:(BgLayer)aLayer inContext:(CGContext)aContext
{
//    [_borderLayer setOpacity:_isActive ? 0.5 : 1.0];
//
//    var bounds = [aLayer bounds],
//    width = CGRectGetWidth(bounds),
//    height = CGRectGetHeight(bounds);
}

///this function is to recount coordinates so top left corner will be 0, 0
- (CGPoint)getLocalCoords : (CPEvent)anEvent
{
    var point = CGPointFromEvent(anEvent);
    var originPoint = [self frameOrigin];
    return CGPointMake(point.x-originPoint.x, point.y-originPoint.y);

}

- (void)setCurrentLayer:(int)anIndex
{
    current = anIndex;
}

///mouse events
- (void)mouseDown:(CPEvent)anEvent
{
    mousedown = true;
    var point = [self getLocalCoords:anEvent];
    [selection startWithPoint:point Layer:layers[current]];
    ///click handler
    if ([anEvent clickCount] == 3)
    {
        //[_paneLayer setImage:null];
    }
}

- (void)mouseUp:(CPEvent)anEvent
{
    var point = [self getLocalCoords:anEvent];
    [selection finishWithPoint:point];
	mousedown = false;
}

- (void)mouseDragged:(CPEvent)anEvent
{
    var point = [self getLocalCoords:anEvent];
    [selection performWithPoint:point Layer:layers[current]];
}

- (void)scrollWheel:(CPEvent)anEvent
{
    if (mousedown)
    {
        [layers[current] setRotationRadians:[layers[current] getRotationRadians] + PI / 180 * anEvent._deltaY];
    }
    else
    {
        if (current < [layers count] - 1)
            current++;
        else
            current = 0;
    }
}

- (void)setActive:(BOOL)isActive
{
    _isActive = isActive;
    
    //[_borderLayer setNeedsDisplay];
}

- (void)performDragOperation:(CPDraggingInfo)aSender
{
    [self setActive:NO];

    ///setting an image by dragging
    var image = [CPKeyedUnarchiver unarchiveObjectWithData:[[aSender draggingPasteboard] dataForType:PhotoDragType]];
    if (image)
    {
        var zoom = 4;
        var filename = ([image filename]).replace('thumb_', 'pane_');
        var paneImage = [[CPImage alloc] initWithContentsOfFile:filename];
        [paneImage setSize:CGSizeMake(([image size]).width*zoom, ([image size]).height*zoom)];
        [layers[current] setImage:paneImage];
    }

    ///setting a template by dragging
    var template = [CPKeyedUnarchiver unarchiveObjectWithData:[[aSender draggingPasteboard] dataForType:TemplateDragType]];
    if (template)
    {
        [design loadCurrentPage:template];
        [layerInspector loadThumbs:layers];
        
//        var frame = [[CPImage alloc] initWithContentsOfFile:([frame filename]).replace('_thumb', '_pane')];
//        [frame setSize:commonSize];
//        [_borderLayer setImage:frame];
//
//
//        ///set frame attributes
//        var realSize = CGSizeMake(commonSize.width/_settings.commonScale, commonSize.height/_settings.commonScale);
//        [frameAttributes setCanvas:[frame filename] : realSize];
//        ///-------------------
    }
}

- (void)draggingEntered:(CPDraggingInfo)aSender
{
    [self setActive:YES];
}

- (void)redraw : (Page)page
{
    [self clear];
    var elements = [page elements];
    for (i = 0; i < [elements count]; i++)
    {
        [self addLayer:elements[i]];
    }
    current = [elements count] - 1;
}

- (void)addLayer : (PageElement)element
{
    var layer = [[PaneLayer alloc] initWithPageView:self];

    [layer setBounds:[self bounds]];
    [layer setAnchorPoint:CGPointMakeZero()];
    [layer setPosition:CGPointMake(0.0, 0.0)];

    [_rootLayer addSublayer:layer];
    [layers addObject:layer];
    if (element === nil)
    {
        [layerInspector loadThumbs:layers];
        current = [layers count] - 1;
    }
    else
    {
        var attributes = [element attributes];
        if ([element type] == 'image')
        {
            var filename = '/samples/'+attributes.folder+'/'+attributes.file;
            var paneImage = [[CPImage alloc] initWithContentsOfFile:filename];
            [paneImage setSize:CGSizeMake(300, 300)];
            [layer setImage:paneImage];
        }

        ///common layer attributes
        [layer setRotationRadians:(PI / 180 * attributes.rotation)];
        [layer setOffsetX:attributes.offsetX];
        [layer setOffsetY:attributes.offsetY];
        [layer setScaleX:attributes.scaleX];
        [layer setScaleY:attributes.scaleY];
    }

    [layer setNeedsDisplay];
    [layer setDelegate:self];
    
}

- (void)removeCurrentLayer
{
    [self removeLayer:current];
}

- (void)removeLayer:(int)anIndex
{
    var tmp = [];
    for (i = 0; i < [layers count]; i++)
    {
        if (i == anIndex)
        {
            [layers[i] removeFromSuperlayer];
        }
        else
        {
            [tmp addObject:layers[i]];
        }
    }

    layers = tmp;
    [layerInspector loadThumbs:layers];
}

- (void)clear
{
    for (i = 0; i < [layers count]; i++)
    {
        [layers[i] removeFromSuperlayer];

    }
    layers = [];
}

@end