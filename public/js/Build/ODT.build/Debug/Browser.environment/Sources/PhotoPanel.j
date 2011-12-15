@STATIC;1.0;i;6;Ajax.jt;4838; objj_executeFile("Ajax.j", YES);
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

