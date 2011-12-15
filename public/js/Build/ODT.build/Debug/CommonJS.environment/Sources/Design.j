@STATIC;1.0;i;6;Page.jt;2097;objj_executeFile("Page.j", YES);
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

