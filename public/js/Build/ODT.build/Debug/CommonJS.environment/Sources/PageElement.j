@STATIC;1.0;t;2498;{var the_class = objj_allocateClassPair(CPObject, "PageElement"),
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

