@STATIC;1.0;p;14;SamplesPanel.jt;4964;@STATIC;1.0;i;6;Ajax.jt;4935; objj_executeFile("Ajax.j", YES);
TemplateDragType = "TemplateDragType";
{var the_class = objj_allocateClassPair(CPView, "SamplesPanel"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("templates"), new objj_ivar("thumbs"), new objj_ivar("photosView")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $SamplesPanel__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("SamplesPanel").super_class }, "initWithFrame:", aFrame);
    if (self)
    {
        var bounds = objj_msgSend(self, "bounds");
        bounds.size.height -= _settings.sidebarPaddingB;
        photosView = objj_msgSend(objj_msgSend(CPCollectionView, "alloc"), "initWithFrame:", bounds);
        objj_msgSend(photosView, "setAutoresizingMask:", CPViewWidthSizable);
        objj_msgSend(photosView, "setMinItemSize:", CGSizeMake(_settings.thumbSize, _settings.thumbSize));
        objj_msgSend(photosView, "setMaxItemSize:", CGSizeMake(_settings.thumbSize, _settings.thumbSize));
        objj_msgSend(photosView, "setDelegate:", self);
        var itemPrototype = objj_msgSend(objj_msgSend(CPCollectionViewItem, "alloc"), "init");
        objj_msgSend(itemPrototype, "setView:", objj_msgSend(objj_msgSend(PhotoView, "alloc"), "initWithFrame:", CGRectMakeZero()));
        objj_msgSend(photosView, "setItemPrototype:", itemPrototype);
        var scrollView = objj_msgSend(objj_msgSend(CPScrollView, "alloc"), "initWithFrame:", bounds);
        objj_msgSend(scrollView, "setDocumentView:", photosView);
        objj_msgSend(scrollView, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(scrollView, "setAutohidesScrollers:", YES);
        objj_msgSend(scrollView, "setHasVerticalScroller:", _settings.sidebarHasScroller);
        objj_msgSend(self, "addSubview:", scrollView);
        var styleName = _style.name || "";
        objj_msgSend(self, "getStyles:", styleName);
    }
    return self;
}
},["id","CGPoint"]), new objj_method(sel_getUid("getStyles:"), function $SamplesPanel__getStyles_(self, _cmd, styleName)
{ with(self)
{
    if (styleName)
    {
        templates = [];
        var url = '/samples/' + styleName + '/frame_thumb.png';
        var frame = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", url);
        objj_msgSend(templates, "addObject:", frame);
        objj_msgSend(photosView, "setContent:", templates);
    }
    else
    {
        var ajax = objj_msgSend(objj_msgSend(Ajax, "alloc"), "init");
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
                            var parameters = {
                                type: 'get',
                                url: '/samples/' + stylesList[i] + '/style.json',
                                async: false,
                                success: function(data)
                                {
                                    var style = eval("(" + data + ')');
                                    var url = '/samples/' + style.name + '/' + style.thumb;
                                    var thumb = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", url);
                                    objj_msgSend(templates, "addObject:", style);
                                    objj_msgSend(thumbs, "addObject:", thumb);
                                }
                            };
                            objj_msgSend(ajax, "get:", parameters);
                        }
                    }
                }
                objj_msgSend(photosView, "setContent:", thumbs);
            }
        };
        objj_msgSend(ajax, "get:", parameters);
    }
}
},["void","CPString"]), new objj_method(sel_getUid("collectionView:dataForItemsAtIndexes:forType:"), function $SamplesPanel__collectionView_dataForItemsAtIndexes_forType_(self, _cmd, aCollectionView, indices, aType)
{ with(self)
{
    return objj_msgSend(CPKeyedArchiver, "archivedDataWithRootObject:", objj_msgSend(templates, "objectAtIndex:", objj_msgSend(indices, "firstIndex")));
}
},["CPData","CPCollectionView","CPIndexSet","CPString"]), new objj_method(sel_getUid("collectionView:dragTypesForItemsAtIndexes:"), function $SamplesPanel__collectionView_dragTypesForItemsAtIndexes_(self, _cmd, aCollectionView, indices)
{ with(self)
{
    return [TemplateDragType];
}
},["CPArray","CPCollectionView","CPIndexSet"])]);
}

p;17;ServerIndicator.jt;2655;@STATIC;1.0;t;2636;{var the_class = objj_allocateClassPair(CPObject, "ServerIndicator"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("serverActivities"), new objj_ivar("views"), new objj_ivar("view"), new objj_ivar("image2")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $ServerIndicator__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ServerIndicator").super_class }, "init");
    if (self)
    {
        views = [];
        serverActivities = 0;
        image2 = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "spinner2.gif"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        image1 = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "server.png"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
    }
    return self;
}
},["id"]), new objj_method(sel_getUid("startActivity"), function $ServerIndicator__startActivity(self, _cmd)
{ with(self)
{
    if (!serverActivities)
    {
        objj_msgSend(self, "setViews:", true);
    }
    serverActivities++;
}
},["void"]), new objj_method(sel_getUid("finishActivity"), function $ServerIndicator__finishActivity(self, _cmd)
{ with(self)
{
    if (serverActivities > 0)
    {
        serverActivities--;
        if (!serverActivities)
            objj_msgSend(self, "setViews:", false);
    }
    else
        serverActivities = 0;
}
},["void"]), new objj_method(sel_getUid("isActive"), function $ServerIndicator__isActive(self, _cmd)
{ with(self)
{
    return serverActivities?true:false;
}
},["BOOL"]), new objj_method(sel_getUid("addView"), function $ServerIndicator__addView(self, _cmd)
{ with(self)
{
    var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "remove.png"), CPSizeMake(30, 25));
    view = objj_msgSend(objj_msgSend(CPView, "alloc"), "initWithFrame:", CGRectMake(0, 0, 80, 24));
    objj_msgSend(view, "setBackgroundColor:",  objj_msgSend(CPColor, "colorWithHexString:", "777"));
    objj_msgSend(views, "addObject:", view);
    return view;
}
},["id"]), new objj_method(sel_getUid("setViews:"), function $ServerIndicator__setViews_(self, _cmd, isActive)
{ with(self)
{
    objj_msgSend(objj_msgSend(toolbar, "items")[5], "setEnabled:", isActive);
    objj_msgSend(objj_msgSend(toolbar, "items")[5], "setImage:", isActive?image2:image1);
}
},["void","BOOL"])]);
}

p;8;Design.jt;2126;@STATIC;1.0;i;6;Page.jt;2097;objj_executeFile("Page.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "Design"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("pages"), new objj_ivar("currentPage"), new objj_ivar("view")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithView:"), function $Design__initWithView_(self, _cmd, aView)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Design").super_class }, "init");
    if (self)
    {
        var page = objj_msgSend(objj_msgSend(Page, "alloc"), "init");
        pages = objj_msgSend(objj_msgSend(CPArray, "alloc"), "init");
        objj_msgSend(pages, "addObject:", page);
        currentPage = 0;
        view = aView;
    }
    return self;
}
},["id","PageView"]), new objj_method(sel_getUid("load"), function $Design__load(self, _cmd)
{ with(self)
{
}
},["void"]), new objj_method(sel_getUid("save"), function $Design__save(self, _cmd)
{ with(self)
{
}
},["void"]), new objj_method(sel_getUid("setCurrentPage:"), function $Design__setCurrentPage_(self, _cmd, number)
{ with(self)
{
    currentPage = number;
}
},["void","int"]), new objj_method(sel_getUid("addPage:"), function $Design__addPage_(self, _cmd, aPage)
{ with(self)
{
    objj_msgSend(self, "addPage:toPlace:", aPage, objj_msgSend(pages, "count"));
}
},["void","Page"]), new objj_method(sel_getUid("addPage:toPlace:"), function $Design__addPage_toPlace_(self, _cmd, aPage, number)
{ with(self)
{
}
},["void","Page","int"]), new objj_method(sel_getUid("loadCurrentPage:"), function $Design__loadCurrentPage_(self, _cmd, template)
{ with(self)
{
    objj_msgSend(pages[currentPage], "load:", template);
    objj_msgSend(self, "redrawCurrentPage");
}
},["void","JSON"]), new objj_method(sel_getUid("redrawCurrentPage"), function $Design__redrawCurrentPage(self, _cmd)
{ with(self)
{
    objj_msgSend(pages[currentPage], "redrawOnView:", view);
}
},["void"]), new objj_method(sel_getUid("removeCurrentPage"), function $Design__removeCurrentPage(self, _cmd)
{ with(self)
{
}
},["void"])]);
}

p;11;Selection.jt;13200;@STATIC;1.0;t;13180;SELECTION = 0,
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

p;13;PageElement.jt;2517;@STATIC;1.0;t;2498;{var the_class = objj_allocateClassPair(CPObject, "PageElement"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("type"), new objj_ivar("attributes")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithTemplate:"), function $PageElement__initWithTemplate_(self, _cmd, template)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageElement").super_class }, "init");
    if (self)
    {
        type = template.type;
        attributes = template;
    }
    return self;
}
},["id","JSON"]), new objj_method(sel_getUid("type"), function $PageElement__type(self, _cmd)
{ with(self)
{
    return type;
}
},["CPString"]), new objj_method(sel_getUid("setImage:"), function $PageElement__setImage_(self, _cmd, anImage)
{ with(self)
{
    if (type != 'image')
        return false;
    attributes.image = anImage;
    return true;
}
},["BOOL","CPImage"]), new objj_method(sel_getUid("image"), function $PageElement__image(self, _cmd)
{ with(self)
{
    if (type != 'image')
        return false;
    return attributes.image;
}
},["CPImage"]), new objj_method(sel_getUid("setRotation:"), function $PageElement__setRotation_(self, _cmd, angle)
{ with(self)
{
    attributes['rotation'] = angle;
}
},["void","float"]), new objj_method(sel_getUid("setGradRotation:"), function $PageElement__setGradRotation_(self, _cmd, angle)
{ with(self)
{
    attributes['rotation'] = (angle*180)/PI;
}
},["void","float"]), new objj_method(sel_getUid("rotation:"), function $PageElement__rotation_(self, _cmd, angle)
{ with(self)
{
    return attributes['rotation'];
}
},["void","float"]), new objj_method(sel_getUid("setScaleX:"), function $PageElement__setScaleX_(self, _cmd, scale)
{ with(self)
{
    attributes['scaleX'] = scale;
}
},["void","float"]), new objj_method(sel_getUid("setScaleY:"), function $PageElement__setScaleY_(self, _cmd, scale)
{ with(self)
{
    attributes['scaleY'] = scale;
}
},["void","float"]), new objj_method(sel_getUid("setOffsetX:"), function $PageElement__setOffsetX_(self, _cmd, offset)
{ with(self)
{
    attributes['offsetX'] = offset;
}
},["void","float"]), new objj_method(sel_getUid("setOffsetY:"), function $PageElement__setOffsetY_(self, _cmd, offset)
{ with(self)
{
    attributes['offsetY'] = offset;
}
},["void","float"]), new objj_method(sel_getUid("attributes"), function $PageElement__attributes(self, _cmd)
{ with(self)
{
    return attributes;
}
},["JSON"])]);
}

p;14;FileUploader.jt;2723;@STATIC;1.0;I;16;AppKit/CPPanel.ji;12;FileUpload.jt;2666;objj_executeFile("AppKit/CPPanel.j", NO);
objj_executeFile("FileUpload.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "FileUploader"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("browseButton"), new objj_ivar("photoPanel")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $FileUploader__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("FileUploader").super_class }, "init");
    if (self)
    {
  browseButton = objj_msgSend(objj_msgSend(UploadButton, "alloc"), "initWithFrame:",  CGRectMake(
                0, 0,
                _settings.toolbarItemSize, _settings.toolbarItemSize
            ));
  objj_msgSend(browseButton, "setTitle:", _lang.upload_images_button1);
  objj_msgSend(browseButton, "setURL:", "/translator/index");
  objj_msgSend(browseButton, "setName:", "file");
        if (__browser.iphone)
        {
            objj_msgSend(browseButton, "setTarget:", self);
            objj_msgSend(browseButton, "setAction:", sel_getUid("upload:"));
        }
  objj_msgSend(browseButton, "setAutoresizingMask:", CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin);
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "upload.png"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
  objj_msgSend(browseButton, "setImage:", image);
  objj_msgSend(objj_msgSend(objj_msgSend(toolbar, "items")[1], "view"), "addSubview:", browseButton);
    }
    return self;
}
},["id"]), new objj_method(sel_getUid("upload:"), function $FileUploader__upload_(self, _cmd, aSender)
{ with(self)
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
},["void","id"]), new objj_method(sel_getUid("addObject:"), function $FileUploader__addObject_(self, _cmd, anObject)
{ with(self)
{
 photoPanel = anObject;
 objj_msgSend(browseButton, "addObject:", anObject);
}
},["void","id"])]);
}

p;15;AppController.jt;3359;@STATIC;1.0;I;21;Foundation/CPObject.ji;17;ServerIndicator.ji;9;Toolbar.ji;14;SamplesPanel.ji;9;Sidebar.ji;10;PageView.ji;14;FileUploader.jt;3213;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("ServerIndicator.j", YES);
objj_executeFile("Toolbar.j", YES);
objj_executeFile("SamplesPanel.j", YES);
objj_executeFile("Sidebar.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("FileUploader.j", YES);
serverIndicator = nil;
photoPanel = nil;
windowWidth = 0;
sidebar = nil;
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("photoPanelHandler"), new objj_ivar("samplesPanelHandler")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
    var theWindow = objj_msgSend(objj_msgSend(CPWindow, "alloc"), "initWithContentRect:styleMask:", CGRectMakeZero(), CPBorderlessBridgeWindowMask),
        contentView = objj_msgSend(theWindow, "contentView"),
        bounds = objj_msgSend(contentView, "bounds");
    objj_msgSend(contentView, "setBackgroundColor:", objj_msgSend(CPColor, "colorWithHexString:", "cecece"));
    var w2 = objj_msgSend(objj_msgSend(CPPanel, "alloc"), "initWithContentRect:styleMask:", CGRectMake(0, CGRectGetHeight(bounds) - _settings.toolbarSize,
                                                              CGRectGetWidth(bounds), _settings.toolbarSize),  CPBorderlessWindowMask),
        c2 = objj_msgSend(w2, "contentView");
    objj_msgSend(w2, "setAutoresizingMask:", CPViewMinYMargin | CPViewWidthSizable);
    objj_msgSend(w2, "setLevel:", 5);
    windowWidth = CGRectGetWidth(bounds);
    serverIndicator = objj_msgSend(objj_msgSend(ServerIndicator, "alloc"), "init");
    var toolbar = objj_msgSend(objj_msgSend(Toolbar, "alloc"), "initWithWindow:", w2);
    sidebar = objj_msgSend(objj_msgSend(Sidebar, "alloc"), "initWithFrame:", bounds);
    objj_msgSend(sidebar, "setAutoresizingMask:", CPViewMinXMargin | CPViewHeightSizable);
    objj_msgSend(sidebar, "orderFront:", self);
    var pageView = objj_msgSend(objj_msgSend(PageView, "alloc"), "initWithFrame:", CGRectMake(
        (CGRectGetWidth(bounds)-_style.width*_settings.commonScale) / 2.0,
        (CGRectGetHeight(bounds)-_style.height*_settings.commonScale -_settings.toolbarSize) / 2.0,
        _style.width*_settings.commonScale,
        _style.height*_settings.commonScale));
    objj_msgSend(pageView, "setAutoresizingMask:", CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin);
    objj_msgSend(contentView, "addSubview:", pageView);
    var fileUploader = objj_msgSend(objj_msgSend(FileUploader, "alloc"), "init");
 objj_msgSend(fileUploader, "addObject:", photoPanel);
    objj_msgSend(theWindow, "orderFront:", self);
    objj_msgSend(w2, "orderFront:", self);
}
},["void","CPNotification"]), new objj_method(sel_getUid("adjustImageSize:"), function $AppController__adjustImageSize_(self, _cmd, sender)
{ with(self)
{
    var newSizeAsString = objj_msgSend(CPString, "stringWithFormat:", "%d", objj_msgSend(objj_msgSend(CPNumber, "numberWithDouble:", objj_msgSend(sender, "value")), "intValue"));
    alert(newSizeAsString);
}
},["void","id"])]);
}

p;9;Toolbar.jt;5155;@STATIC;1.0;I;21;Foundation/CPObject.ji;12;FileUpload.jt;5093;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("FileUpload.j", YES);
var UploadToolbarItemIdentifier = "UploadToolbarItemIdentifier",
    ServerToolbarItemIdentifier = "ServerToolbarItemIdentifier",
    SaveToolbarItemIdentifier = "SaveToolbarItemIdentifier";
ind = nil;
toolbar = nil;
{var the_class = objj_allocateClassPair(CPObject, "Toolbar"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithWindow:"), function $Toolbar__initWithWindow_(self, _cmd, aWindow)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Toolbar").super_class }, "init");
    if (self)
    {
        toolbar = objj_msgSend(objj_msgSend(BigToolbar, "alloc"), "initWithIdentifier:", "");
        objj_msgSend(toolbar, "setDelegate:", self);
        objj_msgSend(toolbar, "setVisible:", YES);
        objj_msgSend(aWindow, "setToolbar:", toolbar);
    }
    return self;
}
},["Toolbar","CPWindow"]), new objj_method(sel_getUid("add:"), function $Toolbar__add_(self, _cmd, sender)
{ with(self)
{
    alert(objj_msgSend(ind, "backgroundColor"));
}
},["void","id"]), new objj_method(sel_getUid("remove:"), function $Toolbar__remove_(self, _cmd, sender)
{ with(self)
{
    alert("Remove clicked");
}
},["void","id"]), new objj_method(sel_getUid("toolbarAllowedItemIdentifiers:"), function $Toolbar__toolbarAllowedItemIdentifiers_(self, _cmd, aToolbar)
{ with(self)
{
   return [CPToolbarFlexibleSpaceItemIdentifier, UploadToolbarItemIdentifier, SaveToolbarItemIdentifier, ServerToolbarItemIdentifier];
}
},["CPArray","CPToolbar"]), new objj_method(sel_getUid("toolbarDefaultItemIdentifiers:"), function $Toolbar__toolbarDefaultItemIdentifiers_(self, _cmd, aToolbar)
{ with(self)
{
   return [CPToolbarFlexibleSpaceItemIdentifier, UploadToolbarItemIdentifier,
           CPToolbarFlexibleSpaceItemIdentifier, SaveToolbarItemIdentifier,
           CPToolbarFlexibleSpaceItemIdentifier, ServerToolbarItemIdentifier,
           CPToolbarFlexibleSpaceItemIdentifier];
}
},["CPArray","CPToolbar"]), new objj_method(sel_getUid("toolbar:itemForItemIdentifier:willBeInsertedIntoToolbar:"), function $Toolbar__toolbar_itemForItemIdentifier_willBeInsertedIntoToolbar_(self, _cmd, aToolbar, anItemIdentifier, aFlag)
{ with(self)
{
    var toolbarItem = objj_msgSend(objj_msgSend(CPToolbarItem, "alloc"), "initWithItemIdentifier:", anItemIdentifier);
    if (anItemIdentifier == UploadToolbarItemIdentifier)
    {
  var browseView = objj_msgSend(objj_msgSend(CPView, "alloc"), "initWithFrame:",  CGRectMake(
                0, 0,
                _settings.toolbarItemSize, _settings.toolbarItemSize
            ));
        objj_msgSend(toolbarItem, "setView:", browseView);
        objj_msgSend(toolbarItem, "setLabel:", _lang.upload_images_button1);
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
    }
    else if (anItemIdentifier == SaveToolbarItemIdentifier)
    {
        objj_msgSend(toolbarItem, "setLabel:", _lang.attr_save);
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
    }
    else if (anItemIdentifier == ServerToolbarItemIdentifier)
    {
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "server.png"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setImage:", image);
        objj_msgSend(toolbarItem, "setEnabled:", false);
        objj_msgSend(toolbarItem, "setLabel:", _lang.server_indicator);
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        ind = toolbarItem;
    }
    return toolbarItem;
}
},["CPToolbarItem","CPToolbar","CPString","BOOL"])]);
}
{var the_class = objj_allocateClassPair(CPToolbar, "BigToolbar"),
meta_class = the_class.isa;objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("_toolbarView"), function $BigToolbar___toolbarView(self, _cmd)
{ with(self)
{
 if (!_toolbarView) {
  _toolbarView = objj_msgSend(objj_msgSend(_CPToolbarView, "alloc"), "initWithFrame:", CPRectMake(0.0, 0.0, 120.0, _settings.toolbarSize));
        objj_msgSend(_toolbarView, "setBackgroundColor:", objj_msgSend(CPColor, "colorWithHexString:", "676767"));
        objj_msgSend(_toolbarView, "setAlphaValue:", 0.5);
  objj_msgSend(_toolbarView, "setToolbar:", self);
  objj_msgSend(_toolbarView, "setAutoresizingMask:", CPViewWidthSizable);
  objj_msgSend(_toolbarView, "reloadToolbarItems");
 }
 return _toolbarView;
}
},["CPView"])]);
}

p;8;BgView.jt;3425;@STATIC;1.0;I;16;AppKit/CALayer.jt;3385;objj_executeFile("AppKit/CALayer.j", NO);
{var the_class = objj_allocateClassPair(CALayer, "BgLayer"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_image"), new objj_ivar("_imageLayer")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $BgLayer__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("BgLayer").super_class }, "init");
    if (self)
    {
        _imageLayer = objj_msgSend(CALayer, "layer");
        objj_msgSend(_imageLayer, "setDelegate:", self);
        objj_msgSend(self, "addSublayer:", _imageLayer);
    }
    return self;
}
},["id"]), new objj_method(sel_getUid("setBounds:"), function $BgLayer__setBounds_(self, _cmd, aRect)
{ with(self)
{
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("BgLayer").super_class }, "setBounds:", aRect);
    objj_msgSend(_imageLayer, "setPosition:", CGPointMake(CGRectGetMidX(aRect), CGRectGetMidY(aRect)));
}
},["void","CGRect"]), new objj_method(sel_getUid("setImage:"), function $BgLayer__setImage_(self, _cmd, anImage)
{ with(self)
{
    if (_image == anImage)
        return;
    _image = anImage;
    if (_image)
        objj_msgSend(_imageLayer, "setBounds:", CGRectMake(0.0, 0.0, objj_msgSend(_image, "size").width, objj_msgSend(_image, "size").height));
    objj_msgSend(_imageLayer, "setNeedsDisplay");
}
},["void","CPImage"]), new objj_method(sel_getUid("imageDidLoad:"), function $BgLayer__imageDidLoad_(self, _cmd, anImage)
{ with(self)
{
    objj_msgSend(_imageLayer, "setNeedsDisplay");
}
},["void","CPImage"]), new objj_method(sel_getUid("drawLayer:inContext:"), function $BgLayer__drawLayer_inContext_(self, _cmd, aLayer, aContext)
{ with(self)
{
    var bounds = objj_msgSend(aLayer, "bounds");
    if (objj_msgSend(_image, "loadStatus") != CPImageLoadStatusCompleted)
        objj_msgSend(_image, "setDelegate:", self);
    else
        CGContextDrawImage(aContext, bounds, _image);
}
},["void","CALayer","CGContext"])]);
}
{var the_class = objj_allocateClassPair(CPView, "BgView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_rootLayer"), new objj_ivar("_bgLayer")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $BgView__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("BgView").super_class }, "initWithFrame:", aFrame);
    if (self)
    {
        _rootLayer = objj_msgSend(CALayer, "layer");
        objj_msgSend(self, "setWantsLayer:", YES);
        objj_msgSend(self, "setLayer:", _rootLayer);
  _bgLayer = objj_msgSend(objj_msgSend(BgLayer, "alloc"), "init");
        objj_msgSend(_bgLayer, "setBackgroundColor:", objj_msgSend(CPColor, "blackColor"));
        objj_msgSend(_bgLayer, "setBounds:", aFrame);
        objj_msgSend(_bgLayer, "setAnchorPoint:", CGPointMakeZero());
  objj_msgSend(_bgLayer, "setImage:", objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", "/images/bg.jpg", CGSizeMake(CGRectGetWidth(aFrame), CGRectGetHeight(aFrame))));
        objj_msgSend(_rootLayer, "addSublayer:", _bgLayer);
  objj_msgSend(_bgLayer, "setNeedsDisplay");
  objj_msgSend(_rootLayer, "setNeedsDisplay");
    }
    return self;
}
},["id","CGRect"])]);
}

p;16;LayerInspector.jt;4830;@STATIC;1.0;t;4811;var commonPageView = nil;
{var the_class = objj_allocateClassPair(CPView, "LayerInspector"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("layersView"), new objj_ivar("layerThumbs")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithPageView:"), function $LayerInspector__initWithPageView_(self, _cmd, aView)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("LayerInspector").super_class }, "initWithFrame:", CGRectMake(0, 0, 200, 200));
    if (self)
    {
        var bounds = objj_msgSend(self, "bounds");
        bounds.size.height -= 40;
        layersView = objj_msgSend(objj_msgSend(CPCollectionView, "alloc"), "initWithFrame:", bounds);
        objj_msgSend(layersView, "setAutoresizingMask:", CPViewWidthSizable);
        objj_msgSend(layersView, "setMinItemSize:", CGSizeMake(_settings.thumbSize, _settings.thumbSize));
        objj_msgSend(layersView, "setMaxItemSize:", CGSizeMake(_settings.thumbSize, _settings.thumbSize));
        objj_msgSend(layersView, "setDelegate:", self);
        var itemPrototype = objj_msgSend(objj_msgSend(CPCollectionViewItem, "alloc"), "init");
        objj_msgSend(itemPrototype, "setView:", objj_msgSend(objj_msgSend(LayersView, "alloc"), "initWithFrame:", CGRectMakeZero()));
        objj_msgSend(layersView, "setItemPrototype:", itemPrototype);
        var scrollView = objj_msgSend(objj_msgSend(CPScrollView, "alloc"), "initWithFrame:", bounds);
        objj_msgSend(scrollView, "setDocumentView:", layersView);
        objj_msgSend(scrollView, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(scrollView, "setAutohidesScrollers:", YES);
        objj_msgSend(self, "addSubview:", scrollView);
        commonPageView = aView;
        var segmentedControl = objj_msgSend(objj_msgSend(CPSegmentedControl, "alloc"), "initWithFrame:", CGRectMake(4, 4, 0, 40));
        objj_msgSend(self, "addSubview:", segmentedControl);
        objj_msgSend(segmentedControl, "setSegmentCount:", 2);
        objj_msgSend(segmentedControl, "setWidth:forSegment:", 70, 0);
        objj_msgSend(segmentedControl, "setWidth:forSegment:", 70, 1);
        objj_msgSend(segmentedControl, "setLabel:forSegment:", "Add", 0);
        objj_msgSend(segmentedControl, "setLabel:forSegment:", "Remove", 1);
        objj_msgSend(segmentedControl, "setTarget:", self);
        objj_msgSend(segmentedControl, "setAction:", "action:");
    }
    return self;
}
},["id","PageView"]), new objj_method(sel_getUid("action:"), function $LayerInspector__action_(self, _cmd, sender)
{ with(self)
{
    switch (objj_msgSend(sender, "selectedSegment"))
    {
        case 0: objj_msgSend(commonPageView, "addLayer:", nil);
                break;
        case 1: objj_msgSend(commonPageView, "removeCurrentLayer");
                break;
    }
}
},["void","id"]), new objj_method(sel_getUid("loadThumbs:"), function $LayerInspector__loadThumbs_(self, _cmd, layers)
{ with(self)
{
    layerThumbs = [];
    for (i = 0; i < objj_msgSend(layers, "count"); i++)
    {
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", objj_msgSend(mainBundle, "pathForResource:", "layer_bg.png"));
 objj_msgSend(layerThumbs, "addObject:", image);
    }
    objj_msgSend(layersView, "setContent:", layerThumbs);
}
},["void","CPArray"])]);
}
{var the_class = objj_allocateClassPair(CPImageView, "LayersView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_imageView")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("setSelected:"), function $LayersView__setSelected_(self, _cmd, isSelected)
{ with(self)
{
    objj_msgSend(self, "setBackgroundColor:", isSelected ? objj_msgSend(CPColor, "grayColor") : nil);
    if (isSelected)
    {
        var superView = objj_msgSend(self, "superview");
        var superChildren = objj_msgSend(superView, "content");
        var index = objj_msgSend(superChildren, "indexOfObject:", objj_msgSend(_imageView, "image"));
        objj_msgSend(commonPageView, "setCurrentLayer:", index);
    }
}
},["void","BOOL"]), new objj_method(sel_getUid("setRepresentedObject:"), function $LayersView__setRepresentedObject_(self, _cmd, anObject)
{ with(self)
{
    if (!_imageView)
    {
        _imageView = objj_msgSend(objj_msgSend(CPImageView, "alloc"), "initWithFrame:", CGRectInset(objj_msgSend(self, "bounds"), 3.0, 3.0));
        objj_msgSend(_imageView, "setImageScaling:", CPScaleProportionally);
        objj_msgSend(_imageView, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(self, "addSubview:", _imageView);
    }
    objj_msgSend(_imageView, "setImage:", anObject);
}
},["void","id"])]);
}

p;10;PageView.jt;16780;@STATIC;1.0;I;16;AppKit/CALayer.ji;11;Selection.ji;14;SamplesPanel.ji;12;PhotoPanel.ji;17;ImageAttributes.ji;8;BgView.ji;6;Ajax.ji;8;Design.ji;16;LayerInspector.jt;16610;objj_executeFile("AppKit/CALayer.j", NO);
objj_executeFile("Selection.j", YES);
objj_executeFile("SamplesPanel.j", YES);
objj_executeFile("PhotoPanel.j", YES);
objj_executeFile("ImageAttributes.j", YES);
objj_executeFile("BgView.j", YES);
objj_executeFile("Ajax.j", YES);
objj_executeFile("Design.j", YES);
objj_executeFile("LayerInspector.j", YES);
{var the_class = objj_allocateClassPair(CALayer, "PaneLayer"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_rotationRadians"), new objj_ivar("_scaleX"), new objj_ivar("_scaleY"), new objj_ivar("_offsetX"), new objj_ivar("_offsetY"), new objj_ivar("imageName"), new objj_ivar("basePosition"), new objj_ivar("tmpOffset"), new objj_ivar("_image"), new objj_ivar("_imageLayer"), new objj_ivar("_pageView"), new objj_ivar("imageAttributes")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("getImageAttributes"), function $PaneLayer__getImageAttributes(self, _cmd)
{ with(self)
{
}
},["void"]), new objj_method(sel_getUid("initWithPageView:"), function $PaneLayer__initWithPageView_(self, _cmd, anPageView)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PaneLayer").super_class }, "init");
    if (self)
    {
        _pageView = anPageView;
        _rotationRadians = 0.0;
        _scaleX = 1.0;
        _scaleY = 1.0;
        _positionX = 0.0;
        _positionY = 0.0;
        _imageLayer = objj_msgSend(CALayer, "layer");
  objj_msgSend(self, "setBackgroundColor:", objj_msgSend(CPColor, "blueColor"));
        objj_msgSend(_imageLayer, "setDelegate:", self);
        objj_msgSend(self, "addSublayer:", _imageLayer);
  basePosition = objj_msgSend(_imageLayer, "position");
        objj_msgSend(self, "redisplay");
  objj_msgSend(self, "initImageAttributes");
    }
    return self;
}
},["id","PageView"]), new objj_method(sel_getUid("setCommonSize:"), function $PaneLayer__setCommonSize_(self, _cmd, aSize)
{ with(self)
{
 objj_msgSend(_imageLayer, "setBounds:", CGRectMake(0, 0, aSize.width, aSize.height));
}
},["void","CGSize"]), new objj_method(sel_getUid("pageView"), function $PaneLayer__pageView(self, _cmd)
{ with(self)
{
    return _pageView;
}
},["PageView"]), new objj_method(sel_getUid("setBounds:"), function $PaneLayer__setBounds_(self, _cmd, aRect)
{ with(self)
{
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PaneLayer").super_class }, "setBounds:", aRect);
    objj_msgSend(_imageLayer, "setPosition:", CGPointMake(CGRectGetMidX(aRect), CGRectGetMidY(aRect)));
}
},["void","CGRect"]), new objj_method(sel_getUid("setImage:"), function $PaneLayer__setImage_(self, _cmd, anImage)
{ with(self)
{
    if (_image == anImage)
        return;
    _image = anImage;
 objj_msgSend(self, "setImageAttributes");
    if (_image)
        objj_msgSend(_imageLayer, "setBounds:", CGRectMake(0.0, 0.0, objj_msgSend(_image, "size").width, objj_msgSend(_image, "size").height));
    objj_msgSend(_imageLayer, "setNeedsDisplay");
    objj_msgSend(self, "setScaleX:", _scaleX);
    objj_msgSend(self, "setScaleY:", _scaleY);
}
},["void","CPImage"]), new objj_method(sel_getUid("image"), function $PaneLayer__image(self, _cmd)
{ with(self)
{
 return _image;
}
},["CPImage"]), new objj_method(sel_getUid("redisplay"), function $PaneLayer__redisplay(self, _cmd)
{ with(self)
{
    objj_msgSend(_imageLayer, "setAffineTransform:", CGAffineTransformScale(CGAffineTransformMakeRotation(_rotationRadians), _scaleX*_settings.commonScale, _scaleY*_settings.commonScale));
    objj_msgSend(self, "setImageAttributes");
}
},["void"]), new objj_method(sel_getUid("setRotationRadians:"), function $PaneLayer__setRotationRadians_(self, _cmd, radians)
{ with(self)
{
    if (_rotationRadians == radians)
        return;
    _rotationRadians = radians;
    objj_msgSend(self, "redisplay");
}
},["void","float"]), new objj_method(sel_getUid("getRotationRadians"), function $PaneLayer__getRotationRadians(self, _cmd)
{ with(self)
{
 return _rotationRadians;
}
},["float"]), new objj_method(sel_getUid("setScaleX:"), function $PaneLayer__setScaleX_(self, _cmd, aScale)
{ with(self)
{
    if (_scaleX == aScale)
        return;
    _scaleX = aScale;
    objj_msgSend(self, "redisplay");
}
},["void","float"]), new objj_method(sel_getUid("getScaleX"), function $PaneLayer__getScaleX(self, _cmd)
{ with(self)
{
 return _scaleX;
}
},["float"]), new objj_method(sel_getUid("setScaleY:"), function $PaneLayer__setScaleY_(self, _cmd, aScale)
{ with(self)
{
    if (_scaleY == aScale)
        return;
    _scaleY = aScale;
    objj_msgSend(self, "redisplay");
}
},["void","float"]), new objj_method(sel_getUid("getScaleY"), function $PaneLayer__getScaleY(self, _cmd)
{ with(self)
{
 return _scaleY;
}
},["float"]), new objj_method(sel_getUid("setOffsetX:"), function $PaneLayer__setOffsetX_(self, _cmd, anOffset)
{ with(self)
{
 if (_offsetX == anOffset)
  return;
 var posX = objj_msgSend(_imageLayer, "position").x;
 var posY = objj_msgSend(_imageLayer, "position").y;
 posX -= _offsetX*_settings.commonScale;
 posX += anOffset;
 _offsetX = anOffset/_settings.commonScale;
 objj_msgSend(_imageLayer, "setPosition:", {x:posX, y:posY});
    objj_msgSend(self, "redisplay");
}
},["void","float"]), new objj_method(sel_getUid("getOffsetX"), function $PaneLayer__getOffsetX(self, _cmd)
{ with(self)
{
 return _offsetX;
}
},["float"]), new objj_method(sel_getUid("setOffsetY:"), function $PaneLayer__setOffsetY_(self, _cmd, anOffset)
{ with(self)
{
 if (_offsetY == anOffset)
  return;
 var posX = objj_msgSend(_imageLayer, "position").x;
 var posY = objj_msgSend(_imageLayer, "position").y;
 posY -= _offsetY*_settings.commonScale;
 posY += anOffset;
 _offsetY = anOffset/_settings.commonScale;
 objj_msgSend(_imageLayer, "setPosition:", {x:posX, y:posY});
    objj_msgSend(self, "redisplay");
}
},["void","float"]), new objj_method(sel_getUid("getOffsetY"), function $PaneLayer__getOffsetY(self, _cmd)
{ with(self)
{
 return _offsetY;
}
},["float"]), new objj_method(sel_getUid("drawInContext:"), function $PaneLayer__drawInContext_(self, _cmd, aContext)
{ with(self)
{
}
},["void","CGContext"]), new objj_method(sel_getUid("getAttributes"), function $PaneLayer__getAttributes(self, _cmd)
{ with(self)
{
 return imageAttributes;
}
},["ImageAttributes"]), new objj_method(sel_getUid("imageDidLoad:"), function $PaneLayer__imageDidLoad_(self, _cmd, anImage)
{ with(self)
{
    objj_msgSend(_imageLayer, "setNeedsDisplay");
}
},["void","CPImage"]), new objj_method(sel_getUid("drawLayer:inContext:"), function $PaneLayer__drawLayer_inContext_(self, _cmd, aLayer, aContext)
{ with(self)
{
    var bounds = objj_msgSend(aLayer, "bounds");
    if (objj_msgSend(_image, "loadStatus") != CPImageLoadStatusCompleted)
        objj_msgSend(_image, "setDelegate:", self);
    else
        CGContextDrawImage(aContext, bounds, _image);
}
},["void","CALayer","CGContext"]), new objj_method(sel_getUid("initImageAttributes"), function $PaneLayer__initImageAttributes(self, _cmd)
{ with(self)
{
 imageAttributes = objj_msgSend(objj_msgSend(ImageAttributes, "alloc"), "init");
}
},["void"]), new objj_method(sel_getUid("setImageAttributes"), function $PaneLayer__setImageAttributes(self, _cmd)
{ with(self)
{
 objj_msgSend(imageAttributes, "setAttributes:::::", _scaleX , _rotationRadians , _offsetX , _offsetY , objj_msgSend(_image, "filename"));
}
},["void"]), new objj_method(sel_getUid("rememberOffset:"), function $PaneLayer__rememberOffset_(self, _cmd, anOffset)
{ with(self)
{
    tmpOffset = anOffset;
}
},["void","CGPoint"]), new objj_method(sel_getUid("readOffset"), function $PaneLayer__readOffset(self, _cmd)
{ with(self)
{
    return tmpOffset;
}
},["CGPoint"])]);
}
{var the_class = objj_allocateClassPair(CPView, "PageView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_rootLayer"), new objj_ivar("layers"), new objj_ivar("current"), new objj_ivar("_isActive"), new objj_ivar("mouseX"), new objj_ivar("mouseY"), new objj_ivar("offsetX"), new objj_ivar("offsetY"), new objj_ivar("mousedown"), new objj_ivar("frameAttributes"), new objj_ivar("commonBounds"), new objj_ivar("commonSize"), new objj_ivar("selection"), new objj_ivar("design"), new objj_ivar("layerInspector")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $PageView__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PageView").super_class }, "initWithFrame:", aFrame);
    commonBounds = CGRectMake(0.0, 0.0, CGRectGetWidth(aFrame), CGRectGetHeight(aFrame));
    commonSize = CGSizeMake(CGRectGetWidth(aFrame), CGRectGetHeight(aFrame));
    if (self)
    {
        layers = [];
        design = objj_msgSend(objj_msgSend(Design, "alloc"), "initWithView:", self);
        _rootLayer = objj_msgSend(CALayer, "layer");
        objj_msgSend(self, "setWantsLayer:", YES);
        objj_msgSend(self, "setLayer:", _rootLayer);
        _bgLayer = objj_msgSend(objj_msgSend(BgLayer, "alloc"), "init");
        objj_msgSend(_bgLayer, "setBounds:", commonBounds);
        objj_msgSend(_bgLayer, "setAnchorPoint:", CGPointMakeZero());
        objj_msgSend(_bgLayer, "setImage:", objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", "/js/Resources/layer_bg.png", commonSize));
        objj_msgSend(_rootLayer, "addSublayer:", _bgLayer);
        objj_msgSend(_bgLayer, "setNeedsDisplay");
        objj_msgSend(_rootLayer, "setDelegate:", self);
        objj_msgSend(self, "registerForDraggedTypes:", [PhotoDragType]);
        objj_msgSend(self, "registerForDraggedTypes:", [TemplateDragType]);
        selection = objj_msgSend(objj_msgSend(Selection, "alloc"), "initWithRootLayer:", _rootLayer);
        layerInspector = objj_msgSend(objj_msgSend(LayerInspector, "alloc"), "initWithPageView:", self);
        objj_msgSend(sidebar, "addView:title:", layerInspector, "layers");
        objj_msgSend(layerInspector, "loadThumbs:", layers);
    }
    return self;
}
},["id","CGRect"]), new objj_method(sel_getUid("setEditing:"), function $PageView__setEditing_(self, _cmd, isEditing)
{ with(self)
{
}
},["void","BOOL"]), new objj_method(sel_getUid("drawLayer:inContext:"), function $PageView__drawLayer_inContext_(self, _cmd, aLayer, aContext)
{ with(self)
{
}
},["void","BgLayer","CGContext"]), new objj_method(sel_getUid("getLocalCoords:"), function $PageView__getLocalCoords_(self, _cmd, anEvent)
{ with(self)
{
    var point = CGPointFromEvent(anEvent);
    var originPoint = objj_msgSend(self, "frameOrigin");
    return CGPointMake(point.x-originPoint.x, point.y-originPoint.y);
}
},["CGPoint","CPEvent"]), new objj_method(sel_getUid("setCurrentLayer:"), function $PageView__setCurrentLayer_(self, _cmd, anIndex)
{ with(self)
{
    current = anIndex;
}
},["void","int"]), new objj_method(sel_getUid("mouseDown:"), function $PageView__mouseDown_(self, _cmd, anEvent)
{ with(self)
{
    mousedown = true;
    var point = objj_msgSend(self, "getLocalCoords:", anEvent);
    objj_msgSend(selection, "startWithPoint:Layer:", point, layers[current]);
    if (objj_msgSend(anEvent, "clickCount") == 3)
    {
    }
}
},["void","CPEvent"]), new objj_method(sel_getUid("mouseUp:"), function $PageView__mouseUp_(self, _cmd, anEvent)
{ with(self)
{
    var point = objj_msgSend(self, "getLocalCoords:", anEvent);
    objj_msgSend(selection, "finishWithPoint:", point);
 mousedown = false;
}
},["void","CPEvent"]), new objj_method(sel_getUid("mouseDragged:"), function $PageView__mouseDragged_(self, _cmd, anEvent)
{ with(self)
{
    var point = objj_msgSend(self, "getLocalCoords:", anEvent);
    objj_msgSend(selection, "performWithPoint:Layer:", point, layers[current]);
}
},["void","CPEvent"]), new objj_method(sel_getUid("scrollWheel:"), function $PageView__scrollWheel_(self, _cmd, anEvent)
{ with(self)
{
    if (mousedown)
    {
        objj_msgSend(layers[current], "setRotationRadians:", objj_msgSend(layers[current], "getRotationRadians") + PI / 180 * anEvent._deltaY);
    }
    else
    {
        if (current < objj_msgSend(layers, "count") - 1)
            current++;
        else
            current = 0;
    }
}
},["void","CPEvent"]), new objj_method(sel_getUid("setActive:"), function $PageView__setActive_(self, _cmd, isActive)
{ with(self)
{
    _isActive = isActive;
}
},["void","BOOL"]), new objj_method(sel_getUid("performDragOperation:"), function $PageView__performDragOperation_(self, _cmd, aSender)
{ with(self)
{
    objj_msgSend(self, "setActive:", NO);
    var image = objj_msgSend(CPKeyedUnarchiver, "unarchiveObjectWithData:", objj_msgSend(objj_msgSend(aSender, "draggingPasteboard"), "dataForType:", PhotoDragType));
    if (image)
    {
        var zoom = 4;
        var filename = (objj_msgSend(image, "filename")).replace('thumb_', 'pane_');
        var paneImage = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", filename);
        objj_msgSend(paneImage, "setSize:", CGSizeMake((objj_msgSend(image, "size")).width*zoom, (objj_msgSend(image, "size")).height*zoom));
        objj_msgSend(layers[current], "setImage:", paneImage);
    }
    var template = objj_msgSend(CPKeyedUnarchiver, "unarchiveObjectWithData:", objj_msgSend(objj_msgSend(aSender, "draggingPasteboard"), "dataForType:", TemplateDragType));
    if (template)
    {
        objj_msgSend(design, "loadCurrentPage:", template);
        objj_msgSend(layerInspector, "loadThumbs:", layers);
    }
}
},["void","CPDraggingInfo"]), new objj_method(sel_getUid("draggingEntered:"), function $PageView__draggingEntered_(self, _cmd, aSender)
{ with(self)
{
    objj_msgSend(self, "setActive:", YES);
}
},["void","CPDraggingInfo"]), new objj_method(sel_getUid("redraw:"), function $PageView__redraw_(self, _cmd, page)
{ with(self)
{
    objj_msgSend(self, "clear");
    var elements = objj_msgSend(page, "elements");
    for (i = 0; i < objj_msgSend(elements, "count"); i++)
    {
        objj_msgSend(self, "addLayer:", elements[i]);
    }
    current = objj_msgSend(elements, "count") - 1;
}
},["void","Page"]), new objj_method(sel_getUid("addLayer:"), function $PageView__addLayer_(self, _cmd, element)
{ with(self)
{
    var layer = objj_msgSend(objj_msgSend(PaneLayer, "alloc"), "initWithPageView:", self);
    objj_msgSend(layer, "setBounds:", objj_msgSend(self, "bounds"));
    objj_msgSend(layer, "setAnchorPoint:", CGPointMakeZero());
    objj_msgSend(layer, "setPosition:", CGPointMake(0.0, 0.0));
    objj_msgSend(_rootLayer, "addSublayer:", layer);
    objj_msgSend(layers, "addObject:", layer);
    if (element === nil)
    {
        objj_msgSend(layerInspector, "loadThumbs:", layers);
        current = objj_msgSend(layers, "count") - 1;
    }
    else
    {
        var attributes = objj_msgSend(element, "attributes");
        if (objj_msgSend(element, "type") == 'image')
        {
            var filename = '/samples/'+attributes.folder+'/'+attributes.file;
            var paneImage = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", filename);
            objj_msgSend(paneImage, "setSize:", CGSizeMake(300, 300));
            objj_msgSend(layer, "setImage:", paneImage);
        }
        objj_msgSend(layer, "setRotationRadians:", (PI / 180 * attributes.rotation));
        objj_msgSend(layer, "setOffsetX:", attributes.offsetX);
        objj_msgSend(layer, "setOffsetY:", attributes.offsetY);
        objj_msgSend(layer, "setScaleX:", attributes.scaleX);
        objj_msgSend(layer, "setScaleY:", attributes.scaleY);
    }
    objj_msgSend(layer, "setNeedsDisplay");
    objj_msgSend(layer, "setDelegate:", self);
}
},["void","PageElement"]), new objj_method(sel_getUid("removeCurrentLayer"), function $PageView__removeCurrentLayer(self, _cmd)
{ with(self)
{
    objj_msgSend(self, "removeLayer:", current);
}
},["void"]), new objj_method(sel_getUid("removeLayer:"), function $PageView__removeLayer_(self, _cmd, anIndex)
{ with(self)
{
    var tmp = [];
    for (i = 0; i < objj_msgSend(layers, "count"); i++)
    {
        if (i == anIndex)
        {
            objj_msgSend(layers[i], "removeFromSuperlayer");
        }
        else
        {
            objj_msgSend(tmp, "addObject:", layers[i]);
        }
    }
    layers = tmp;
    objj_msgSend(layerInspector, "loadThumbs:", layers);
}
},["void","int"]), new objj_method(sel_getUid("clear"), function $PageView__clear(self, _cmd)
{ with(self)
{
    for (i = 0; i < objj_msgSend(layers, "count"); i++)
    {
        objj_msgSend(layers[i], "removeFromSuperlayer");
    }
    layers = [];
}
},["void"])]);
}

p;12;FileUpload.jt;12026;@STATIC;1.0;I;21;Foundation/CPObject.jI;20;Foundation/CPValue.jI;24;Foundation/CPException.jt;11926;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("Foundation/CPValue.j", NO);
objj_executeFile("Foundation/CPException.j", NO);
var UPLOAD_IFRAME_PREFIX = "UPLOAD_IFRAME_",
    UPLOAD_FORM_PREFIX = "UPLOAD_FORM_",
    UPLOAD_INPUT_PREFIX = "UPLOAD_INPUT_";
{var the_class = objj_allocateClassPair(CPButton, "UploadButton"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_DOMIFrameElement"), new objj_ivar("_fileUploadElement"), new objj_ivar("_uploadForm"), new objj_ivar("_mouseMovedCallback"), new objj_ivar("_mouseUpCallback"), new objj_ivar("_delegate"), new objj_ivar("_parameters"), new objj_ivar("photoPanel")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $UploadButton__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("UploadButton").super_class }, "initWithFrame:", aFrame);
    if (self)
    {
        var hash = objj_msgSend(self, "hash");
        _uploadForm = document.createElement("form");
        _uploadForm.method = "POST";
        _uploadForm.action = "#";
        if(document.attachEvent)
            _uploadForm.encoding = "multipart/form-data";
        else
            _uploadForm.enctype = "multipart/form-data";
        _fileUploadElement = document.createElement("input");
        _fileUploadElement.type = "file";
        _fileUploadElement.name = "file";
        _fileUploadElement.style.height = CGRectGetHeight(aFrame) + 'px';
        _fileUploadElement.onmousedown = function(aDOMEvent)
        {
            aDOMEvent = aDOMEvent || window.event;
            var x = aDOMEvent.clientX,
                y = aDOMEvent.clientY,
                theWindow = objj_msgSend(self, "window");
            objj_msgSend(CPApp, "sendEvent:", objj_msgSend(CPEvent, "mouseEventWithType:location:modifierFlags:timestamp:windowNumber:context:eventNumber:clickCount:pressure:", CPLeftMouseDown, objj_msgSend(theWindow, "convertBridgeToBase:", CGPointMake(x, y)), 0, 0, objj_msgSend(theWindow, "windowNumber"), nil, -1, 1, 0));
            if (document.addEventListener)
            {
                document.addEventListener(CPDOMEventMouseUp, _mouseUpCallback, NO);
                document.addEventListener(CPDOMEventMouseMoved, _mouseMovedCallback, NO);
            }
            else if(document.attachEvent)
            {
                document.attachEvent("on" + CPDOMEventMouseUp, _mouseUpCallback);
                document.attachEvent("on" + CPDOMEventMouseMoved, _mouseMovedCallback);
            }
        }
        _mouseUpCallback = function(aDOMEvent)
        {
            if (document.removeEventListener)
            {
                document.removeEventListener(CPDOMEventMouseUp, _mouseUpCallback, NO);
                document.removeEventListener(CPDOMEventMouseMoved, _mouseMovedCallback, NO);
            }
            else if(document.attachEvent)
            {
                document.detachEvent("on" + CPDOMEventMouseUp, _mouseUpCallback);
                document.detachEvent("on" + CPDOMEventMouseMoved, _mouseMovedCallback);
            }
            aDOMEvent = aDOMEvent || window.event;
            var x = aDOMEvent.clientX,
                y = aDOMEvent.clientY,
                theWindow = objj_msgSend(self, "window");
            objj_msgSend(CPApp, "sendEvent:", objj_msgSend(CPEvent, "mouseEventWithType:location:modifierFlags:timestamp:windowNumber:context:eventNumber:clickCount:pressure:", CPLeftMouseUp, objj_msgSend(theWindow, "convertBridgeToBase:", CGPointMake(x, y)), 0, 0, objj_msgSend(theWindow, "windowNumber"), nil, -1, 1, 0));
        }
        _mouseMovedCallback = function(aDOMEvent)
        {
            aDOMEvent = aDOMEvent || window.event;
            var x = aDOMEvent.clientX,
                y = aDOMEvent.clientY,
                theWindow = objj_msgSend(self, "window");
            objj_msgSend(CPApp, "sendEvent:", objj_msgSend(CPEvent, "mouseEventWithType:location:modifierFlags:timestamp:windowNumber:context:eventNumber:clickCount:pressure:", CPLeftMouseDragged, objj_msgSend(theWindow, "convertBridgeToBase:", CGPointMake(x, y)), 0, 0, objj_msgSend(theWindow, "windowNumber"), nil, -1, 1, 0));
        }
        _uploadForm.style.position = "absolute";
        _uploadForm.style.top = "0px";
        _uploadForm.style.left = "0px";
        _uploadForm.style.zIndex = 1000;
        _fileUploadElement.style.opacity = "0";
        _fileUploadElement.style.filter = "alpha(opacity=0)";
        _uploadForm.style.width = "100%";
        _uploadForm.style.height = "100%";
        _fileUploadElement.style.position = "absolute";
        _fileUploadElement.style.right = 0;
        _fileUploadElement.onchange = function()
        {
            objj_msgSend(self, "uploadSelectionDidChange:",  _fileUploadElement.value);
        };
        _uploadForm.appendChild(_fileUploadElement);
        _DOMElement.appendChild(_uploadForm);
        _parameters = objj_msgSend(CPDictionary, "dictionary");
        objj_msgSend(self, "setBordered:", NO);
    }
    return self;
}
},["id","CGRect"]), new objj_method(sel_getUid("setDelegate:"), function $UploadButton__setDelegate_(self, _cmd, aDelegate)
{ with(self)
{
    _delegate = aDelegate;
}
},["void","id"]), new objj_method(sel_getUid("delegate"), function $UploadButton__delegate(self, _cmd)
{ with(self)
{
    return _delegate;
}
},["id"]), new objj_method(sel_getUid("setURL:"), function $UploadButton__setURL_(self, _cmd, aURL)
{ with(self)
{
    _uploadForm.action = aURL;
}
},["void","CPString"]), new objj_method(sel_getUid("uploadSelectionDidChange:"), function $UploadButton__uploadSelectionDidChange_(self, _cmd, selection)
{ with(self)
{
 objj_msgSend(self, "submit");
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("uploadButton:didChangeSelection:")))
        objj_msgSend(_delegate, "uploadButton:didChangeSelection:",  self,  selection);
}
},["void","CPString"]), new objj_method(sel_getUid("selection"), function $UploadButton__selection(self, _cmd)
{ with(self)
{
    return _fileUploadElement.value;
}
},["CPString"]), new objj_method(sel_getUid("resetSelection"), function $UploadButton__resetSelection(self, _cmd)
{ with(self)
{
    _fileUploadElement.value = "";
}
},["void"]), new objj_method(sel_getUid("uploadDidFinishWithResponse:"), function $UploadButton__uploadDidFinishWithResponse_(self, _cmd, response)
{ with(self)
{
 objj_msgSend(photoPanel, "loadImages");
    objj_msgSend(serverIndicator, "finishActivity");
 objj_msgSend(self, "setTitle:", _lang.upload_images_button1);
 if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("uploadButton:didFinishUploadWithData:")))
        objj_msgSend(_delegate, "uploadButton:didFinishUploadWithData:",  self,  response);
}
},["void","CPString"]), new objj_method(sel_getUid("uploadDidFailWithError:"), function $UploadButton__uploadDidFailWithError_(self, _cmd, anError)
{ with(self)
{
 alert(anError);
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("uploadButton:didFailWithError:")))
        objj_msgSend(_delegate, "uploadButton:didFailWithError:",  self,  anError);
}
},["void","CPString"]), new objj_method(sel_getUid("setValue:forParameter:"), function $UploadButton__setValue_forParameter_(self, _cmd, aValue, aParam)
{ with(self)
{
    if(aParam == "file")
        return NO;
    objj_msgSend(_parameters, "setObject:forKey:", aValue, aParam);
    return YES;
}
},["BOOL","CPString","CPString"]), new objj_method(sel_getUid("parameters"), function $UploadButton__parameters(self, _cmd)
{ with(self)
{
    return _parameters;
}
},["void"]), new objj_method(sel_getUid("submit"), function $UploadButton__submit(self, _cmd)
{ with(self)
{
    objj_msgSend(serverIndicator, "startActivity");
 objj_msgSend(self, "setTitle:", _lang.upload_images_button2);
    _uploadForm.target = "FRAME_"+(new Date());
    var index = _uploadForm.childNodes.length;
    while(index--)
        _uploadForm.removeChild(_uploadForm.childNodes[index]);
    var keys = objj_msgSend(_parameters, "allKeys");
    for(var i = 0, count = keys.length; i<count; i++)
    {
        var element = document.createElement("input");
        element.type = "hidden";
        element.name = keys[i];
        element.value = objj_msgSend(_parameters, "objectForKey:", keys[i]);
        _uploadForm.appendChild(element);
    }
    _uploadForm.appendChild(_fileUploadElement);
    if(_DOMIFrameElement)
    {
        document.body.removeChild(_DOMIFrameElement);
        _DOMIFrameElement.onload = nil;
        _DOMIFrameElement = nil;
    }
    if(window.attachEvent)
    {
        _DOMIFrameElement = document.createElement("iframe");
  _DOMIFrameElement.id = _uploadForm.target;
  _DOMIFrameElement.name = _uploadForm.target;
        if(window.location.href.toLowerCase().indexOf("https") === 0)
            _DOMIFrameElement.src = "javascript:false";
    }
    else
    {
        _DOMIFrameElement = document.createElement("iframe");
        _DOMIFrameElement.name = _uploadForm.target;
    }
    _DOMIFrameElement.style.width = "1px";
    _DOMIFrameElement.style.height = "1px";
    _DOMIFrameElement.style.zIndex = -1000;
    _DOMIFrameElement.style.opacity = "0";
    _DOMIFrameElement.style.filter = "alpha(opacity=0)";
    document.body.appendChild(_DOMIFrameElement);
    _onloadHandler = function()
    {
        try
        {
            var responseText = _DOMIFrameElement.contentWindow.document.body ? _DOMIFrameElement.contentWindow.document.body.innerHTML :
                                                                               _DOMIFrameElement.contentWindow.document.documentElement.textContent;
            objj_msgSend(self, "uploadDidFinishWithResponse:",  responseText);
            window.setTimeout(function(){
                document.body.removeChild(_DOMIFrameElement);
                _DOMIFrameElement.onload = nil;
                _DOMIFrameElement = nil;
            }, 100);
        }
        catch (e)
        {
            objj_msgSend(self, "uploadDidFailWithError:", e);
        }
    }
    if (window.attachEvent)
    {
        _DOMIFrameElement.onreadystatechange = function()
        {
            if (this.readyState == "loaded" || this.readyState == "complete")
                _onloadHandler();
        }
    }
    _DOMIFrameElement.onload = _onloadHandler;
    _uploadForm.submit();
 _uploadForm.reset();
    if (objj_msgSend(_delegate, "respondsToSelector:", sel_getUid("uploadButtonDidBeginUpload:")))
        objj_msgSend(_delegate, "uploadButtonDidBeginUpload:", self);
}
},["void"]), new objj_method(sel_getUid("disposeOfEvent:"), function $UploadButton__disposeOfEvent_(self, _cmd, anEvent)
{ with(self)
{
    if (objj_msgSend(anEvent, "type") == CPLeftMouseDown)
        objj_msgSend(CPApp, "setTarget:selector:forNextEventMatchingMask:untilDate:inMode:dequeue:", self, sel_getUid("disposeOfEvent:"), CPLeftMouseUpMask, nil, nil, YES);
}
},["void","CPEvent"]), new objj_method(sel_getUid("mouseDown:"), function $UploadButton__mouseDown_(self, _cmd, anEvent)
{ with(self)
{
 objj_msgSend(CPApp, "setTarget:selector:forNextEventMatchingMask:untilDate:inMode:dequeue:", self, sel_getUid("disposeOfEvent:"), CPLeftMouseDownMask, nil, nil, YES);
 objj_msgSendSuper({ receiver:self, super_class:objj_getClass("UploadButton").super_class }, "mouseDown:", anEvent);
}
},["void","CPEvent"]), new objj_method(sel_getUid("setName:"), function $UploadButton__setName_(self, _cmd, aName)
{ with(self)
{
 _fileUploadElement.name = aName;
}
},["void","CPString"]), new objj_method(sel_getUid("addObject:"), function $UploadButton__addObject_(self, _cmd, anObject)
{ with(self)
{
 photoPanel = anObject;
}
},["void","id"])]);
}
_CPGUID= function()
{
    var g = "";
    for(var i = 0; i < 32; i++)
        g += Math.floor(Math.random() * 0xF).toString(0xF);
    return g;
}

p;6;main.jt;1764;@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.ji;6;Ajax.jt;1667;






objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);

objj_executeFile("AppController.j", YES);
objj_executeFile("Ajax.j", YES);

mainBundle = nil;
_browser = 'default';
ajax = nil;

main= function(args, namedArgs)
{
    mainBundle = objj_msgSend(CPBundle, "mainBundle");
 _lang = initLanguage(_lang.name);
    _settings = initSettings();

    CPApplicationMain(args, namedArgs);
}


initLanguage= function(lang)
{
 ajax = objj_msgSend(objj_msgSend(Ajax, "alloc"), "init");

 var parameters = {
  type: 'get',
  url: objj_msgSend(mainBundle, "pathForResource:", "languages/" + lang + ".json"),
  async: false,
  success: function(data)
  {
   if (data != '')
   {
    lang = eval("(" + data + ")");
   }
   else
    lang = false;
  }
 };
 lang = false;

 objj_msgSend(ajax, "get:", parameters);

 return lang;
}


initSettings= function()
{
    var _ua = navigator.userAgent.toLowerCase();
    __browser = {
        opera: /opera/i.test(_ua),
        msie: (!this.opera && /msie/i.test(_ua)),
        mozilla: /firefox/i.test(_ua),
        chrome: /chrome/i.test(_ua),
        iphone: /iphone/i.test(_ua)
    };


    var limWindowWidth = 640;
    var windowWidth = document.body.offsetWidth;
    if (windowWidth <= limWindowWidth)
        _browser = 'mobile';


 var parameters = {
  type: 'get',
  url: objj_msgSend(mainBundle, "pathForResource:", "settings/" + _browser + ".json"),
  async: false,
  success: function(data)
  {
   if (data != '')
   {
    _settings = eval("(" + data + ')');
   }
   else
    _settings = false;
  }
 };
 _settings = false;

 objj_msgSend(ajax, "get:", parameters);
 return _settings;
}

p;12;PhotoPanel.jt;4867;@STATIC;1.0;i;6;Ajax.jt;4838; objj_executeFile("Ajax.j", YES);
PhotoDragType = "PhotoDragType";
{var the_class = objj_allocateClassPair(CPView, "PhotoPanel"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("images"), new objj_ivar("photosView")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $PhotoPanel__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("PhotoPanel").super_class }, "initWithFrame:", aFrame);
    if (self)
    {
        var bounds = objj_msgSend(self, "bounds");
        bounds.size.height -= _settings.sidebarPaddingB;
        photosView = objj_msgSend(objj_msgSend(CPCollectionView, "alloc"), "initWithFrame:", bounds);
        objj_msgSend(photosView, "setAutoresizingMask:", CPViewWidthSizable);
        objj_msgSend(photosView, "setMinItemSize:", CGSizeMake(_settings.thumbSize, _settings.thumbSize));
        objj_msgSend(photosView, "setMaxItemSize:", CGSizeMake(_settings.thumbSize, _settings.thumbSize));
        objj_msgSend(photosView, "setDelegate:", self);
        var itemPrototype = objj_msgSend(objj_msgSend(CPCollectionViewItem, "alloc"), "init");
        objj_msgSend(itemPrototype, "setView:", objj_msgSend(objj_msgSend(PhotoView, "alloc"), "initWithFrame:", CGRectMakeZero()));
        objj_msgSend(photosView, "setItemPrototype:", itemPrototype);
        var scrollView = objj_msgSend(objj_msgSend(CPScrollView, "alloc"), "initWithFrame:", bounds);
        objj_msgSend(scrollView, "setDocumentView:", photosView);
        objj_msgSend(scrollView, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(scrollView, "setAutohidesScrollers:", YES);
        objj_msgSend(self, "addSubview:", scrollView);
  images = [];
  objj_msgSend(self, "loadImages");
  objj_msgSend(photosView, "setContent:", images);
    }
    return self;
}
},["id","CGRect"]), new objj_method(sel_getUid("loadImages"), function $PhotoPanel__loadImages(self, _cmd)
{ with(self)
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
     if (images.length)
     {
      for (i = images.length; i < imagesObject.files.length; i++)
      {
       var url = imagesObject.path + 'thumb_' + imagesObject.files[i];
       var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", url);
       objj_msgSend(images, "addObject:", image);
      }
     }
     else
     {
      for (i = 0; i < imagesObject.files.length; i++)
      {
       var url = imagesObject.path + 'thumb_' + imagesObject.files[i];
       var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:", url);
       objj_msgSend(images, "addObject:", image);
      }
     }
     objj_msgSend(photosView, "reloadContent");
    }
   }
  }
 };
 objj_msgSend(ajax, "get:", parameters);
}
},["void"]), new objj_method(sel_getUid("collectionView:dataForItemsAtIndexes:forType:"), function $PhotoPanel__collectionView_dataForItemsAtIndexes_forType_(self, _cmd, aCollectionView, indices, aType)
{ with(self)
{
    return objj_msgSend(CPKeyedArchiver, "archivedDataWithRootObject:", objj_msgSend(images, "objectAtIndex:", objj_msgSend(indices, "firstIndex")));
}
},["CPData","CPCollectionView","CPIndexSet","CPString"]), new objj_method(sel_getUid("collectionView:dragTypesForItemsAtIndexes:"), function $PhotoPanel__collectionView_dragTypesForItemsAtIndexes_(self, _cmd, aCollectionView, indices)
{ with(self)
{
    return [PhotoDragType];
}
},["CPArray","CPCollectionView","CPIndexSet"])]);
}
{var the_class = objj_allocateClassPair(CPImageView, "PhotoView"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_imageView")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("setSelected:"), function $PhotoView__setSelected_(self, _cmd, isSelected)
{ with(self)
{
    objj_msgSend(self, "setBackgroundColor:", isSelected ? objj_msgSend(CPColor, "grayColor") : nil);
}
},["void","BOOL"]), new objj_method(sel_getUid("setRepresentedObject:"), function $PhotoView__setRepresentedObject_(self, _cmd, anObject)
{ with(self)
{
    if (!_imageView)
    {
        _imageView = objj_msgSend(objj_msgSend(CPImageView, "alloc"), "initWithFrame:", CGRectInset(objj_msgSend(self, "bounds"), 5.0, 5.0));
        objj_msgSend(_imageView, "setImageScaling:", CPScaleProportionally);
        objj_msgSend(_imageView, "setAutoresizingMask:", CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(self, "addSubview:", _imageView);
    }
    objj_msgSend(_imageView, "setImage:", anObject);
}
},["void","id"])]);
}

p;17;ImageAttributes.jt;3117;@STATIC;1.0;I;27;AppKit/CPWindowController.jt;3066;objj_executeFile("AppKit/CPWindowController.j", NO);
{var the_class = objj_allocateClassPair(CPObject, "ImageAttributes"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("attributes")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $ImageAttributes__init(self, _cmd)
{ with(self)
{
 self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ImageAttributes").super_class }, "init");
 if (self)
 {
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "download.png"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        var toolbarItem = objj_msgSend(toolbar, "items")[3];
  objj_msgSend(toolbarItem, "setImage:", image);
        objj_msgSend(toolbarItem, "setTarget:", self);
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setAction:", sel_getUid("save:"));
  attributes = {
   scale: 1,
   rotation: 0,
   offsetX: 0,
   offsetY: 0,
   imageName: '',
   styleName: _style.name?'/samples/'+_style.name+'/frame_pane.png':'',
   styleWidth: _style.width?_style.width:400,
   styleHeight: _style.height?_style.height:400
  };
 }
 return self;
}
},["id"]), new objj_method(sel_getUid("save:"), function $ImageAttributes__save_(self, _cmd, aSender)
{ with(self)
{
        objj_msgSend(serverIndicator, "startActivity");
        setTimeout(function(){ objj_msgSend(serverIndicator, "finishActivity")}, 4000);
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
}
},["void","id"]), new objj_method(sel_getUid("setAttributes:::::"), function $ImageAttributes__setAttributes_____(self, _cmd, _scale, _rotation, _offsetX, _offsetY, _imageName)
{ with(self)
{
 attributes['scale'] = _scale;
 attributes['rotation'] = (_rotation*180)/PI;
 attributes['offsetX'] = _offsetX;
 attributes['offsetY'] = _offsetY;
 attributes['imageName'] = _imageName;
}
},["void","float","float","float","float","CPString"]), new objj_method(sel_getUid("setCanvas::"), function $ImageAttributes__setCanvas__(self, _cmd, _styleName, aSize)
{ with(self)
{
 attributes['styleName'] = _styleName;
 attributes['styleWidth'] = aSize.width;
 attributes['styleHeight'] = aSize.height;
}
},["void","CPString","CGSize"])]);
}

p;9;Sidebar.jt;2773;@STATIC;1.0;I;24;AppKit/CPAccordionView.ji;12;PhotoPanel.jt;2708; objj_executeFile("AppKit/CPAccordionView.j", NO);
 objj_executeFile("PhotoPanel.j", YES);
{var the_class = objj_allocateClassPair(CPPanel, "Sidebar"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("accordion")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $Sidebar__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    var windowWidth = _settings.sidebarWidth;
    self = objj_msgSend(self, "initWithContentRect:styleMask:", CGRectMake(CGRectGetWidth(aFrame) - windowWidth - _settings.sidebarPosX, _settings.sidebarPosY,
                                                windowWidth, CGRectGetHeight(aFrame) - _settings.sidebarPosY - _settings.sidebarMarginB), ((_settings.sidebarIsResizable?CPResizableWindowMask:nil) |
                       (_settings.sidebarIsClosable?CPClosableWindowMask:nil) |
                        CPTitledWindowMask));
    if (self)
    {
        objj_msgSend(self, "setTitle:", "sidebar");
        objj_msgSend(self, "setFloatingPanel:", YES);
        var contentView = objj_msgSend(self, "contentView"),
            bounds = objj_msgSend(contentView, "bounds");
        var accordion = objj_msgSend(objj_msgSend(CPAccordionView, "alloc"), "initWithFrame:", bounds);
        var firstItem = objj_msgSend(objj_msgSend(CPAccordionViewItem, "alloc"), "initWithIdentifier:", "photos");
        photoPanel = objj_msgSend(objj_msgSend(PhotoPanel, "alloc"), "initWithFrame:", CGRectMake(0, 0, 200, 200));
        objj_msgSend(firstItem, "setView:", photoPanel);
        objj_msgSend(firstItem, "setLabel:", _lang.my_photos_panel);
        var secondItem = objj_msgSend(objj_msgSend(CPAccordionViewItem, "alloc"), "initWithIdentifier:", "templates");
        objj_msgSend(secondItem, "setView:", objj_msgSend(objj_msgSend(SamplesPanel, "alloc"), "initWithFrame:", CGRectMake(0, 0, 200, 200)));
        objj_msgSend(secondItem, "setLabel:", _lang.frame_styles_panel);
        objj_msgSend(accordion, "addItem:", firstItem);
        objj_msgSend(accordion, "addItem:", secondItem);
        objj_msgSend(accordion, "setAutoresizingMask:",  CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(contentView, "addSubview:", accordion);
    }
    return self;
}
},["id","CGPoint"]), new objj_method(sel_getUid("addView:title:"), function $Sidebar__addView_title_(self, _cmd, aView, aTitle)
{ with(self)
{
    var item = objj_msgSend(objj_msgSend(CPAccordionViewItem, "alloc"), "initWithIdentifier:", aTitle);
    objj_msgSend(item, "setView:",  aView);
    objj_msgSend(item, "setLabel:", aTitle);
    objj_msgSend(accordion, "addItem:", item);
}
},["void","CPView","CPString"])]);
}

p;6;Page.jt;1805;@STATIC;1.0;i;13;PageElement.jt;1768;objj_executeFile("PageElement.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "Page"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("elements"), new objj_ivar("currentElement")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $Page__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("Page").super_class }, "init");
    if (self)
    {
    }
    return self;
}
},["id"]), new objj_method(sel_getUid("load:"), function $Page__load_(self, _cmd, template)
{ with(self)
{
    elements = [];
    for (i = 0; i < template.elements.length; i++)
    {
        (template.elements[i]).folder = template.name;
        var element = objj_msgSend(objj_msgSend(PageElement, "alloc"), "initWithTemplate:", template.elements[i]);
        objj_msgSend(elements, "addObject:", element);
    }
}
},["void","JSON"]), new objj_method(sel_getUid("save"), function $Page__save(self, _cmd)
{ with(self)
{
}
},["void"]), new objj_method(sel_getUid("redrawOnView:"), function $Page__redrawOnView_(self, _cmd, view)
{ with(self)
{
    objj_msgSend(view, "redraw:", self);
}
},["void","PageView"]), new objj_method(sel_getUid("setCurrentElement:"), function $Page__setCurrentElement_(self, _cmd, number)
{ with(self)
{
}
},["void","int"]), new objj_method(sel_getUid("addElement:"), function $Page__addElement_(self, _cmd, anElement)
{ with(self)
{
}
},["void","PageElement"]), new objj_method(sel_getUid("removeCurrentElement"), function $Page__removeCurrentElement(self, _cmd)
{ with(self)
{
}
},["void"]), new objj_method(sel_getUid("elements"), function $Page__elements(self, _cmd)
{ with(self)
{
    return elements;
}
},["CPArray"])]);
}

p;6;Ajax.jt;2150;@STATIC;1.0;I;21;Foundation/CPObject.jt;2105;objj_executeFile("Foundation/CPObject.j", NO);
{var the_class = objj_allocateClassPair(CPObject, "Ajax"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("ajaxObject")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $Ajax__init(self, _cmd)
{ with(self)
{
 ajaxObject = objj_msgSend(self, "createXMLHttp");
    return self;
}
},["id"]), new objj_method(sel_getUid("get:"), function $Ajax__get_(self, _cmd, parameters)
{ with(self)
{
 parameters.async = typeof(parameters.async) == 'undefined' ? true : parameters.async;
 parameters.type = typeof(parameters.type) == 'undefined' ? 'get' : parameters.type;
 parameters.url = typeof(parameters.url) == 'undefined' ? window.location : parameters.url;
 ajaxObject.open(parameters.type, parameters.url, parameters.async);
    if (parameters.async == true)
    {
        ajaxObject.onreadystatechange = function()
        {
            if (ajaxObject.status == 200 && ajaxObject.readyState == 4)
            {
                var sData = ajaxObject.responseText;
                if (typeof parameters.success == 'function')
                    parameters.success(sData);
            }
        };
    }
 ajaxObject.send(null);
 if (parameters.async == false)
 {
  if (ajaxObject.status == 200 && ajaxObject.readyState == 4)
  {
   var sData = ajaxObject.responseText;
   if (typeof parameters.success == 'function')
    parameters.success(sData);
  }
 }
}
},["void","JSON"]), new objj_method(sel_getUid("createXMLHttp"), function $Ajax__createXMLHttp(self, _cmd)
{ with(self)
{
 if (typeof XMLHttpRequest != "undefined")
 {
  return new XMLHttpRequest();
 }
 else if (window.ActiveXObject)
 {
  var aVersions = ["MSXML2.XMLHttp.5.0", "MSXML2.XMLHttp.4.0",
      "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp",
      "Microsoft.XMLHttp"
      ];
  for (var i = 0; i < aVersions.length; i++)
  {
   try
   {
    var oXmlHttp = new ActiveXObject(aVersions[i]);
    return oXmlHttp;
   }
   catch (oError)
   {
   }
  }
  throw new Error("Can't create XMLHttp object.");
 }
}
},["id"])]);
}

e;