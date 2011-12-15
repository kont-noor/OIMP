@STATIC;1.0;t;2636;{var the_class = objj_allocateClassPair(CPObject, "ServerIndicator"),
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

