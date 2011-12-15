@STATIC;1.0;i;6;Ajax.jt;4935; objj_executeFile("Ajax.j", YES);
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

