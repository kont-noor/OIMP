@STATIC;1.0;t;4811;var commonPageView = nil;
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

