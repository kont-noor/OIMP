@STATIC;1.0;I;16;AppKit/CALayer.jt;3385;objj_executeFile("AppKit/CALayer.j", NO);
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

