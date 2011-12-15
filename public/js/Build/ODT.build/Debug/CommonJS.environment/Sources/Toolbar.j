@STATIC;1.0;I;21;Foundation/CPObject.ji;12;FileUpload.jt;5093;objj_executeFile("Foundation/CPObject.j", NO);
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

