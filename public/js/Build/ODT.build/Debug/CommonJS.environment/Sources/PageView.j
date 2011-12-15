@STATIC;1.0;I;16;AppKit/CALayer.ji;11;Selection.ji;14;SamplesPanel.ji;12;PhotoPanel.ji;17;ImageAttributes.ji;8;BgView.ji;6;Ajax.ji;8;Design.ji;16;LayerInspector.jt;16610;objj_executeFile("AppKit/CALayer.j", NO);
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

