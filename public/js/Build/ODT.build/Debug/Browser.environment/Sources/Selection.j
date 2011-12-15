@STATIC;1.0;t;13180;SELECTION = 0,
DRAGGING = 1,
ROTATION = 2,
RESIZING_TOP = 31,
RESIZING_RIGHT = 32,
RESIZING_BOTTOM = 33,
RESIZING_LEFT = 34;
{var the_class = objj_allocateClassPair(CPObject, "Selection"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("dRotationPoint"), new objj_ivar("isActive"), new objj_ivar("action"), new objj_ivar("layer"), new objj_ivar("bounds"), new objj_ivar("startAngle")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithRootLayer:"), function $Selection__initWithRootLayer_(self, _cmd, rootLayer)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Selection").super_class }, "init");
    if (self)
    {
        isActive = false;
        action = SELECTION;
        layer = objj_msgSend(objj_msgSend(SelectionView, "alloc"), "initWithRootLayer:", rootLayer);
        bounds = objj_msgSend(rootLayer, "bounds");
    }
    return self;
}
},["id","CALayer"]), new objj_method(sel_getUid("startWithPoint:Layer:"), function $Selection__startWithPoint_Layer_(self, _cmd, aPoint, aLayer)
{ with(self)
{
    if (isActive)
    {
        objj_msgSend(self, "setActionByClick:", aPoint);
        if (action == DRAGGING)
        {
            objj_msgSend(self, "setStartDragPoint:", aPoint);
            objj_msgSend(aLayer, "rememberOffset:", CGPointMake(objj_msgSend(aLayer, "getOffsetX"), objj_msgSend(aLayer, "getOffsetY")));
        }
        else if (action == ROTATION)
        {
            tmpAngle = objj_msgSend(aLayer, "getRotationRadians");
            objj_msgSend(self, "setStartDragPoint:", aPoint);
            centerX = (startPoint.x + endPoint.x)/2;
            centerY = (startPoint.y + endPoint.y)/2;
            startAngle = Math.atan((centerX - aPoint.x)/(centerY - aPoint.y));
        }
        else if (action >= RESIZING_TOP && action <= RESIZING_LEFT)
        {
            tmpScaleX = objj_msgSend(aLayer, "getScaleX");
            tmpScaleY = objj_msgSend(aLayer, "getScaleY");
            objj_msgSend(self, "setStartDragPoint:", aPoint);
        }
        else if (action == SELECTION)
        {
            objj_msgSend(self, "setStartPoint:", aPoint);
            objj_msgSend(self, "setAction:", SELECTION);
        }
    }
    else
    {
        objj_msgSend(self, "setStartPoint:", aPoint);
    }
}
},["void","CGPoint","CALayer"]), new objj_method(sel_getUid("performWithPoint:Layer:"), function $Selection__performWithPoint_Layer_(self, _cmd, aPoint, aLayer)
{ with(self)
{
    if (isActive)
    {
        var start = objj_msgSend(self, "startDragPoint");
        var dx = aPoint.x - start.x;
        var dy = aPoint.y - start.y;
        if (action == DRAGGING)
        {
            var tmpOffset = objj_msgSend(aLayer, "readOffset");
            objj_msgSend(aLayer, "setOffsetX:", (tmpOffset.x + dx));
            objj_msgSend(aLayer, "setOffsetY:", (tmpOffset.y + dy));
            objj_msgSend(self, "dragSelection:", CGPointMake(dx, dy));
        }
        else if (action >= RESIZING_TOP && action <= RESIZING_LEFT)
        {
            if (action == RESIZING_TOP)
            {
                var da = dy;
                var a = Math.abs(startPoint.y - endPoint.y);
                var delta = (a - da)/a;
                objj_msgSend(aLayer, "setScaleY:",  tmpScaleY*delta);
            }
            else if (action == RESIZING_RIGHT)
            {
                var da = -dx;
                var a = Math.abs(startPoint.x - endPoint.x);
                var delta = (a - da)/a;
                objj_msgSend(aLayer, "setScaleX:",  tmpScaleX*delta);
            }
            else if (action == RESIZING_BOTTOM)
            {
                var da = -dy;
                var a = Math.abs(startPoint.y - endPoint.y);
                var delta = (a - da)/a;
                objj_msgSend(aLayer, "setScaleY:",  tmpScaleY*delta);
            }
            else if (action == RESIZING_LEFT)
            {
                var da = dx;
                var a = Math.abs(startPoint.x - endPoint.x);
                var delta = (a - da)/a;
                objj_msgSend(aLayer, "setScaleX:",  tmpScaleX*delta);
            }
        }
        else if (action == ROTATION)
        {
            centerX = (startPoint.x + endPoint.x)/2;
            centerY = (startPoint.y + endPoint.y)/2;
            var currentAngle = Math.atan((centerX - aPoint.x)/(centerY - aPoint.y));
            if ((centerY - aPoint.y) < 0)
            {
                var d = PI;
            }
            else
                var d = 0;
            objj_msgSend(aLayer, "setRotationRadians:", tmpAngle + startAngle - currentAngle + d);
        }
    }
    else
    {
        objj_msgSend(self, "setEndPoint:", aPoint);
        objj_msgSend(self, "setRotationPoint");
    }
}
},["void","CGPoint","CALayer"]), new objj_method(sel_getUid("finishWithPoint:"), function $Selection__finishWithPoint_(self, _cmd, aPoint)
{ with(self)
{
    if (action == SELECTION &&
        Math.abs(aPoint.x-startPoint.x) > 3 &&
        Math.abs(aPoint.y-startPoint.y) > 3)
    {
        objj_msgSend(self, "setEndPoint:", aPoint);
        objj_msgSend(self, "setRotationPoint");
        objj_msgSend(self, "setActive:", true);
    }
    else
    {
        objj_msgSend(self, "setActive:", false);
        objj_msgSend(layer, "reset");
    }
}
},["void","CGPoint"]), new objj_method(sel_getUid("redraw"), function $Selection__redraw(self, _cmd)
{ with(self)
{
    objj_msgSend(layer, "redraw:endPoint:rotationPoint:", startPoint, endPoint, rotationPoint);
}
},["void"]), new objj_method(sel_getUid("dragSelection:"), function $Selection__dragSelection_(self, _cmd, anOffset)
{ with(self)
{
    startPoint = CGPointMake(dStartPoint.x + anOffset.x, dStartPoint.y + anOffset.y);
    endPoint = CGPointMake(dEndPoint.x + anOffset.x, dEndPoint.y + anOffset.y);
    rotationPoint = CGPointMake(dRotationPoint.x + anOffset.x, dRotationPoint.y + anOffset.y);
    objj_msgSend(self, "redraw");
}
},["void","CGPoint"]), new objj_method(sel_getUid("setStartPoint:"), function $Selection__setStartPoint_(self, _cmd, aPoint)
{ with(self)
{
    startPoint = aPoint;
    dStartPoint = aPoint;
}
},["void","CGPoint"]), new objj_method(sel_getUid("setRotationPoint"), function $Selection__setRotationPoint(self, _cmd)
{ with(self)
{
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
    objj_msgSend(self, "redraw");
}
},["void"]), new objj_method(sel_getUid("setEndPoint:"), function $Selection__setEndPoint_(self, _cmd, aPoint)
{ with(self)
{
    endPoint = aPoint;
    dEndPoint = aPoint;
}
},["void","CGPoint"]), new objj_method(sel_getUid("setStartDragPoint:"), function $Selection__setStartDragPoint_(self, _cmd, aPoint)
{ with(self)
{
    startDragPoint = aPoint;
}
},["void","CGPoint"]), new objj_method(sel_getUid("setEndDragPoint:"), function $Selection__setEndDragPoint_(self, _cmd, aPoint)
{ with(self)
{
    endDragPoint = aPoint;
}
},["void","CGPoint"]), new objj_method(sel_getUid("startPoint"), function $Selection__startPoint(self, _cmd)
{ with(self)
{
    return startPoint;
}
},["CGPoint"]), new objj_method(sel_getUid("endPoint"), function $Selection__endPoint(self, _cmd)
{ with(self)
{
    return endPoint;
}
},["CGPoint"]), new objj_method(sel_getUid("startDragPoint"), function $Selection__startDragPoint(self, _cmd)
{ with(self)
{
    return startDragPoint;
}
},["CGPoint"]), new objj_method(sel_getUid("endDragPoint"), function $Selection__endDragPoint(self, _cmd)
{ with(self)
{
    return endDragPoint;
}
},["CGPoint"]), new objj_method(sel_getUid("isActive"), function $Selection__isActive(self, _cmd)
{ with(self)
{
    return isActive;
}
},["BOOL"]), new objj_method(sel_getUid("setActive:"), function $Selection__setActive_(self, _cmd, activeState)
{ with(self)
{
    isActive = activeState;
    action = SELECTION;
}
},["void","BOOL"]), new objj_method(sel_getUid("setActionByClick:"), function $Selection__setActionByClick_(self, _cmd, coords)
{ with(self)
{
    if (isActive)
    {
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
        var finger = _settings.finger;
        if (coords.y >= y1 - finger && coords.y <= y1 + finger &&
                coords.x > x1 && coords.x < x2)
        {
            action = RESIZING_TOP;
        }
        else if (coords.x >= x2 - finger && coords.x <= x2 + finger &&
                coords.y > y1 && coords.y < y2)
        {
            action = RESIZING_RIGHT;
        }
        else if (coords.y >= y2 - finger && coords.y <= y2 + finger &&
                coords.x > x1 && coords.x < x2)
        {
            action = RESIZING_BOTTOM;
        }
        else if (coords.x >= x1 - finger && coords.x <= x1 + finger &&
            coords.y > y1 && coords.y < y2)
        {
            action = RESIZING_LEFT;
        }
        else if (coords.x > x1 && coords.x < x2 && coords.y > y1 && coords.y < y2)
        {
            action = DRAGGING;
        }
        else if (coords.x < rotationPoint.x+finger && coords.x > rotationPoint.x-finger &&
                 coords.y < rotationPoint.y+finger && coords.y > rotationPoint.y-finger)
        {
            action = ROTATION;
        }
        else
        {
            objj_msgSend(self, "setActive:", false);
            action = SELECTION;
        }
    }
    else
    {
        action = SELECTION;
    }
    return action;
}
},["int","CGPoint"]), new objj_method(sel_getUid("setAction:"), function $Selection__setAction_(self, _cmd, _action)
{ with(self)
{
    action = _action;
}
},["void","int"]), new objj_method(sel_getUid("action"), function $Selection__action(self, _cmd)
{ with(self)
{
    return action;
}
},["int"])]);
}
{var the_class = objj_allocateClassPair(CALayer, "SelectionView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("finger"), new objj_ivar("rotate")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithRootLayer:"), function $SelectionView__initWithRootLayer_(self, _cmd, rootLayer)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("SelectionView").super_class }, "init");
    if (self)
    {
        objj_msgSend(self, "setBounds:", objj_msgSend(rootLayer, "bounds"));
        objj_msgSend(self, "setAnchorPoint:", CGPointMakeZero());
        objj_msgSend(self, "setOpacity:", 0);
        objj_msgSend(rootLayer, "addSublayer:", self);
        start = CGPointMakeZero();
        end = CGPointMakeZero();
        finger = _settings.finger;
        objj_msgSend(self, "setZPosition:", 1);
    }
    return self;
}
},["id","CALayer"]), new objj_method(sel_getUid("redraw:endPoint:rotationPoint:"), function $SelectionView__redraw_endPoint_rotationPoint_(self, _cmd, startPoint, endPoint, rotatePoint)
{ with(self)
{
    start = startPoint;
    end = endPoint;
    rotate = rotatePoint;
    objj_msgSend(self, "setNeedsDisplay");
}
},["void","CGPoint","CGPoint","CGPoint"]), new objj_method(sel_getUid("reset"), function $SelectionView__reset(self, _cmd)
{ with(self)
{
    objj_msgSend(self, "setOpacity:", 0);
}
},["void"]), new objj_method(sel_getUid("drawInContext:"), function $SelectionView__drawInContext_(self, _cmd, aContext)
{ with(self)
{
    objj_msgSend(self, "setOpacity:", 1);
    CGContextSetFillColor(aContext, objj_msgSend(CPColor, "blackColor"));
    CGContextSetStrokeColor(aContext, objj_msgSend(CPColor, "blackColor"));
    CGContextBeginPath(aContext);
    CGContextFillRect(aContext, CGRectMake(start.x, start.y, end.x-start.x, 1));
    CGContextFillRect(aContext, CGRectMake(end.x, start.y, 1, end.y-start.y));
    CGContextFillRect(aContext, CGRectMake(end.x, end.y, start.x-end.x, 1));
    CGContextFillRect(aContext, CGRectMake(start.x, end.y, 1, start.y-end.y));
    CGContextFillRect(aContext, CGRectMake(start.x-finger/2, start.y-finger/2, finger, finger));
    CGContextFillRect(aContext, CGRectMake(start.x-finger/2, end.y-finger/2, finger, finger));
    CGContextFillRect(aContext, CGRectMake(end.x-finger/2, start.y-finger/2, finger, finger));
    CGContextFillRect(aContext, CGRectMake(end.x-finger/2, end.y-finger/2, finger, finger));
    CGContextFillRoundedRectangleInRect (aContext, CGRectMake(rotate.x-finger/2, rotate.y-finger/2, finger, finger), finger/2, YES, YES, YES, YES);
}
},["void","CGContext"])]);
}

