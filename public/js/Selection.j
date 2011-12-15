/*
 * Selection.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */

///possible actions
SELECTION       = 0,
DRAGGING        = 1,
ROTATION        = 2,
//RESIZING      = 30,
RESIZING_TOP    = 31,
RESIZING_RIGHT  = 32,
RESIZING_BOTTOM = 33,
RESIZING_LEFT   = 34;

@implementation Selection : CPObject
{
    CGPoint         startPoint, endPoint,
                    startDragPoint, endDragPoint,
                    dStartPoint, dEndPoint,
                    rotationPoint, dRotationPoint;
    BOOL            isActive;
    int             action;///DRAGGING, ROTATION, RESIZING etc
    SelectionView   layer;
    CGRect          bounds;
    float           tmpScaleX, tmpScaleY, tmpAngle, startAngle;
}

- (id)initWithRootLayer : (CALayer)rootLayer
{
    self = [super init];
    if (self)
    {
        isActive = false;
        action = SELECTION;

        ///init selection view
        layer = [[SelectionView alloc] initWithRootLayer:rootLayer];
        bounds = [rootLayer bounds];
    }
    
    return self;
}

- (void)startWithPoint : (CGPoint)aPoint Layer : (CALayer) aLayer
{
    if (isActive)///if smth was selected
    {
        [self setActionByClick:aPoint];
        if (action == DRAGGING)
        {
            [self setStartDragPoint:aPoint];
            [aLayer rememberOffset:CGPointMake([aLayer getOffsetX], [aLayer getOffsetY])];
        }
        else if (action == ROTATION)
        {
            tmpAngle = [aLayer getRotationRadians];
            [self setStartDragPoint:aPoint];

            ///count start angle
            ///center point coordinates
            centerX = (startPoint.x + endPoint.x)/2;
            centerY = (startPoint.y + endPoint.y)/2;
            startAngle = Math.atan((centerX - aPoint.x)/(centerY - aPoint.y));
        }
        else if (action >= RESIZING_TOP && action <= RESIZING_LEFT)///any resizing
        {
            tmpScaleX = [aLayer getScaleX];
            tmpScaleY = [aLayer getScaleY];
            [self setStartDragPoint:aPoint];
        }
        else if (action == SELECTION)
        {
            [self setStartPoint:aPoint];
            [self setAction:SELECTION];
        }

    }
    else///if nothing is selected so start select it
    {
        [self setStartPoint:aPoint];
    }
}

- (void)performWithPoint : (CGPoint)aPoint Layer : (CALayer) aLayer
{
    if (isActive)
    {
        var start = [self startDragPoint];
        var dx = aPoint.x - start.x;
        var dy = aPoint.y - start.y;

        if (action == DRAGGING)
        {
            var tmpOffset = [aLayer readOffset];
            [aLayer setOffsetX:(tmpOffset.x + dx)];
            [aLayer setOffsetY:(tmpOffset.y + dy)];
            [self dragSelection:CGPointMake(dx, dy)];
        }
        else if (action >= RESIZING_TOP && action <= RESIZING_LEFT)
        {
            if (action == RESIZING_TOP)
            {
                var da = dy;
                var a = Math.abs(startPoint.y - endPoint.y);
                var delta = (a - da)/a;
                [aLayer setScaleY: tmpScaleY*delta];
            }
            else if (action == RESIZING_RIGHT)
            {
                var da = -dx;
                var a = Math.abs(startPoint.x - endPoint.x);
                var delta = (a - da)/a;
                [aLayer setScaleX: tmpScaleX*delta];
            }
            else if (action == RESIZING_BOTTOM)
            {
                var da = -dy;
                var a = Math.abs(startPoint.y - endPoint.y);
                var delta = (a - da)/a;
                [aLayer setScaleY: tmpScaleY*delta];
            }
            else if (action == RESIZING_LEFT)
            {
                var da = dx;
                var a = Math.abs(startPoint.x - endPoint.x);
                var delta = (a - da)/a;
                [aLayer setScaleX: tmpScaleX*delta];
            }
        }
        else if (action == ROTATION)
        {
            ///counting angle
            ///center point coordinates
            centerX = (startPoint.x + endPoint.x)/2;
            centerY = (startPoint.y + endPoint.y)/2;
            var currentAngle = Math.atan((centerX - aPoint.x)/(centerY - aPoint.y));
            if ((centerY - aPoint.y) < 0)
            {
                var d = PI;
            }
            else
                var d = 0;


            [aLayer setRotationRadians:tmpAngle + startAngle - currentAngle + d];
        }
    }
    else
    {///selection
        [self setEndPoint:aPoint];
        [self setRotationPoint];
    }
}

- (void)finishWithPoint : (CGPoint)aPoint
{
    if (action == SELECTION &&
        Math.abs(aPoint.x-startPoint.x) > 3 &&
        Math.abs(aPoint.y-startPoint.y) > 3)
    {
        [self setEndPoint:aPoint];
        [self setRotationPoint];
        [self setActive:true];
    }
    else
    {
        [self setActive:false];
        [layer reset];
    }
}

- (void)redraw
{
    [layer redraw:startPoint endPoint:endPoint rotationPoint:rotationPoint];
//    [layer setPosition:startPoint];
//    [layer setBounds:CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y)];
}

- (void)dragSelection : (CGPoint)anOffset
{
    startPoint = CGPointMake(dStartPoint.x + anOffset.x, dStartPoint.y + anOffset.y);
    endPoint = CGPointMake(dEndPoint.x + anOffset.x, dEndPoint.y + anOffset.y);
    rotationPoint = CGPointMake(dRotationPoint.x + anOffset.x, dRotationPoint.y + anOffset.y);
    [self redraw];
}

- (void)setStartPoint : (CGPoint)aPoint
{
    startPoint = aPoint;
    dStartPoint = aPoint;
}

- (void)setRotationPoint
{
    ///count action by coords and selection rectangle
    if (startPoint.x < endPoint.x)
    {
        var x1 = startPoint.x,
            x2 = endPoint.x;
    }
    else
    {
        var x1 = endPoint.x,
            x2 = startPoint.x;
    }
    if (startPoint.y < endPoint.y)
    {
        var y1 = startPoint.y,
            y2 = endPoint.y;
    }
    else
    {
        var y1 = endPoint.y,
            y2 = startPoint.y;
    }
    dXY = _settings.rotationRadius/Math.sqrt(2);
    rotationPoint = CGPointMake(x1-dXY, y1-dXY);
    dRotationPoint = rotationPoint;
    [self redraw];
}

- (void)setEndPoint : (CGPoint)aPoint
{
    endPoint = aPoint;
    dEndPoint = aPoint;
}

- (void)setStartDragPoint : (CGPoint)aPoint
{
    startDragPoint = aPoint;
}

- (void)setEndDragPoint : (CGPoint)aPoint
{
    endDragPoint = aPoint;
}

- (CGPoint) startPoint
{
    return startPoint;
}

- (CGPoint) endPoint
{
    return endPoint;
}

- (CGPoint) startDragPoint
{
    return startDragPoint;
}

- (CGPoint) endDragPoint
{
    return endDragPoint;
}

-(BOOL) isActive
{
    return isActive;
}

-(void) setActive : (BOOL)activeState
{
    isActive = activeState;
    action = SELECTION;
}

///defines what to do: select, drag, rotate or resize
-(int) setActionByClick : (CGPoint)coords
{
    if (isActive)
    {
        ///count action by coords and selection rectangle
        if (startPoint.x < endPoint.x)
        {
            var x1 = startPoint.x,
                x2 = endPoint.x;
        }
        else
        {
            var x1 = endPoint.x,
                x2 = startPoint.x;
        }
        if (startPoint.y < endPoint.y)
        {
            var y1 = startPoint.y,
                y2 = endPoint.y;
        }
        else
        {
            var y1 = endPoint.y,
                y2 = startPoint.y;
        }

        ///action depends on cursor coordinates
        var finger = _settings.finger; ///finger radius in pixels
        if (coords.y >= y1 - finger && coords.y <= y1 + finger &&
                coords.x > x1 && coords.x < x2)
        {///case of resizing right
            action = RESIZING_TOP;
        }
        else if (coords.x >= x2 - finger && coords.x <= x2 + finger &&
                coords.y > y1 && coords.y < y2)
        {///case of resizing right
            action = RESIZING_RIGHT;
        }
        else if (coords.y >= y2 - finger && coords.y <= y2 + finger &&
                coords.x > x1 && coords.x < x2)
        {///case of resizing right
            action = RESIZING_BOTTOM;
        }
        else if (coords.x >= x1 - finger && coords.x <= x1 + finger &&
            coords.y > y1 && coords.y < y2)
        {///case of resizing left
            action = RESIZING_LEFT;
        }
        else if (coords.x > x1 && coords.x < x2 && coords.y > y1 && coords.y < y2)
        {///case of dragging
            action = DRAGGING;
        }
        else if (coords.x < rotationPoint.x+finger && coords.x > rotationPoint.x-finger &&
                 coords.y < rotationPoint.y+finger && coords.y > rotationPoint.y-finger)///case of rotation
        {
            action = ROTATION;
        }
        else///reset selection
        {
            [self setActive:false];
            action = SELECTION;
        }
    }
    else
    {
        action = SELECTION;
    }
    return action;
}

- (void)setAction : (int)_action
{
    action = _action;
}

- (int)action
{
    return action;
}

@end

@implementation SelectionView : CALayer
{
    int         finger;
    CGPoint     start, end, rotate;
}

- (id)initWithRootLayer : (CALayer)rootLayer
{
    self = [super init];
    if (self)
    {
        //[self setBounds:CGRectMakeZero()];
        [self setBounds:[rootLayer bounds]];
        [self setAnchorPoint:CGPointMakeZero()];
        //[self setBackgroundColor:[CPColor colorWithHexString:@"ff0"]];
        [self setOpacity:0];
        [rootLayer addSublayer:self];
        start = CGPointMakeZero();
        end = CGPointMakeZero();
		//[self setNeedsDisplay];
        finger = _settings.finger;
        [self setZPosition:1];
    }
    return self;
}

- (void)redraw : (CGPoint)startPoint endPoint : (CGPoint)endPoint rotationPoint : (CGPoint)rotatePoint
{
    start = startPoint;
    end = endPoint;
    rotate = rotatePoint;
    [self setNeedsDisplay];
}

- (void)reset
{
    [self setOpacity:0];
//    var super = [self superlayer];
//    [self removeFromSuperlayer];
//    [super addSublayer:self];
}

//draw a selection shape
- (void)drawInContext: (CGContext)aContext
{
    [self setOpacity:1];
    CGContextSetFillColor(aContext, [CPColor blackColor]);
    CGContextSetStrokeColor(aContext, [CPColor blackColor]);

    CGContextBeginPath(aContext);
    ///4 lines
//    CGContextMoveToPoint(aContext, start.x, start.y);
//    CGContextAddLineToPoint(aContext, start.x, end.y);
//    CGContextAddLineToPoint(aContext, end.x, end.y);
//    CGContextAddLineToPoint(aContext, end.x, start.y);
//    CGContextAddLineToPoint(aContext, start.x, start.y);
    ///hardcode lines
    CGContextFillRect(aContext, CGRectMake(start.x, start.y, end.x-start.x, 1));
    CGContextFillRect(aContext, CGRectMake(end.x, start.y, 1, end.y-start.y));
    CGContextFillRect(aContext, CGRectMake(end.x, end.y, start.x-end.x, 1));
    CGContextFillRect(aContext, CGRectMake(start.x, end.y, 1, start.y-end.y));
    ///4 points
    CGContextFillRect(aContext, CGRectMake(start.x-finger/2, start.y-finger/2, finger, finger));
    CGContextFillRect(aContext, CGRectMake(start.x-finger/2, end.y-finger/2, finger, finger));
    CGContextFillRect(aContext, CGRectMake(end.x-finger/2, start.y-finger/2, finger, finger));
    CGContextFillRect(aContext, CGRectMake(end.x-finger/2, end.y-finger/2, finger, finger));

    CGContextFillRoundedRectangleInRect (aContext, CGRectMake(rotate.x-finger/2, rotate.y-finger/2, finger, finger), finger/2, YES, YES, YES, YES);
}

@end