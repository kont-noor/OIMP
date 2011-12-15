@STATIC;1.0;i;13;PageElement.jt;1768;objj_executeFile("PageElement.j", YES);
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

