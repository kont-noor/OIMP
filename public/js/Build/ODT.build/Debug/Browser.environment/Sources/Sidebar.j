@STATIC;1.0;I;24;AppKit/CPAccordionView.ji;12;PhotoPanel.jt;2708; objj_executeFile("AppKit/CPAccordionView.j", NO);
 objj_executeFile("PhotoPanel.j", YES);
{var the_class = objj_allocateClassPair(CPPanel, "Sidebar"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("accordion")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $Sidebar__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    var windowWidth = _settings.sidebarWidth;
    self = objj_msgSend(self, "initWithContentRect:styleMask:", CGRectMake(CGRectGetWidth(aFrame) - windowWidth - _settings.sidebarPosX, _settings.sidebarPosY,
                                                windowWidth, CGRectGetHeight(aFrame) - _settings.sidebarPosY - _settings.sidebarMarginB), ((_settings.sidebarIsResizable?CPResizableWindowMask:nil) |
                       (_settings.sidebarIsClosable?CPClosableWindowMask:nil) |
                        CPTitledWindowMask));
    if (self)
    {
        objj_msgSend(self, "setTitle:", "sidebar");
        objj_msgSend(self, "setFloatingPanel:", YES);
        var contentView = objj_msgSend(self, "contentView"),
            bounds = objj_msgSend(contentView, "bounds");
        var accordion = objj_msgSend(objj_msgSend(CPAccordionView, "alloc"), "initWithFrame:", bounds);
        var firstItem = objj_msgSend(objj_msgSend(CPAccordionViewItem, "alloc"), "initWithIdentifier:", "photos");
        photoPanel = objj_msgSend(objj_msgSend(PhotoPanel, "alloc"), "initWithFrame:", CGRectMake(0, 0, 200, 200));
        objj_msgSend(firstItem, "setView:", photoPanel);
        objj_msgSend(firstItem, "setLabel:", _lang.my_photos_panel);
        var secondItem = objj_msgSend(objj_msgSend(CPAccordionViewItem, "alloc"), "initWithIdentifier:", "templates");
        objj_msgSend(secondItem, "setView:", objj_msgSend(objj_msgSend(SamplesPanel, "alloc"), "initWithFrame:", CGRectMake(0, 0, 200, 200)));
        objj_msgSend(secondItem, "setLabel:", _lang.frame_styles_panel);
        objj_msgSend(accordion, "addItem:", firstItem);
        objj_msgSend(accordion, "addItem:", secondItem);
        objj_msgSend(accordion, "setAutoresizingMask:",  CPViewWidthSizable | CPViewHeightSizable);
        objj_msgSend(contentView, "addSubview:", accordion);
    }
    return self;
}
},["id","CGPoint"]), new objj_method(sel_getUid("addView:title:"), function $Sidebar__addView_title_(self, _cmd, aView, aTitle)
{ with(self)
{
    var item = objj_msgSend(objj_msgSend(CPAccordionViewItem, "alloc"), "initWithIdentifier:", aTitle);
    objj_msgSend(item, "setView:",  aView);
    objj_msgSend(item, "setLabel:", aTitle);
    objj_msgSend(accordion, "addItem:", item);
}
},["void","CPView","CPString"])]);
}

