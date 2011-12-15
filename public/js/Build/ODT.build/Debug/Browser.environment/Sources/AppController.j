@STATIC;1.0;I;21;Foundation/CPObject.ji;17;ServerIndicator.ji;9;Toolbar.ji;14;SamplesPanel.ji;9;Sidebar.ji;10;PageView.ji;14;FileUploader.jt;3213;objj_executeFile("Foundation/CPObject.j", NO);
objj_executeFile("ServerIndicator.j", YES);
objj_executeFile("Toolbar.j", YES);
objj_executeFile("SamplesPanel.j", YES);
objj_executeFile("Sidebar.j", YES);
objj_executeFile("PageView.j", YES);
objj_executeFile("FileUploader.j", YES);
serverIndicator = nil;
photoPanel = nil;
windowWidth = 0;
sidebar = nil;
{var the_class = objj_allocateClassPair(CPObject, "AppController"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("photoPanelHandler"), new objj_ivar("samplesPanelHandler")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("applicationDidFinishLaunching:"), function $AppController__applicationDidFinishLaunching_(self, _cmd, aNotification)
{ with(self)
{
    var theWindow = objj_msgSend(objj_msgSend(CPWindow, "alloc"), "initWithContentRect:styleMask:", CGRectMakeZero(), CPBorderlessBridgeWindowMask),
        contentView = objj_msgSend(theWindow, "contentView"),
        bounds = objj_msgSend(contentView, "bounds");
    objj_msgSend(contentView, "setBackgroundColor:", objj_msgSend(CPColor, "colorWithHexString:", "cecece"));
    var w2 = objj_msgSend(objj_msgSend(CPPanel, "alloc"), "initWithContentRect:styleMask:", CGRectMake(0, CGRectGetHeight(bounds) - _settings.toolbarSize,
                                                              CGRectGetWidth(bounds), _settings.toolbarSize),  CPBorderlessWindowMask),
        c2 = objj_msgSend(w2, "contentView");
    objj_msgSend(w2, "setAutoresizingMask:", CPViewMinYMargin | CPViewWidthSizable);
    objj_msgSend(w2, "setLevel:", 5);
    windowWidth = CGRectGetWidth(bounds);
    serverIndicator = objj_msgSend(objj_msgSend(ServerIndicator, "alloc"), "init");
    var toolbar = objj_msgSend(objj_msgSend(Toolbar, "alloc"), "initWithWindow:", w2);
    sidebar = objj_msgSend(objj_msgSend(Sidebar, "alloc"), "initWithFrame:", bounds);
    objj_msgSend(sidebar, "setAutoresizingMask:", CPViewMinXMargin | CPViewHeightSizable);
    objj_msgSend(sidebar, "orderFront:", self);
    var pageView = objj_msgSend(objj_msgSend(PageView, "alloc"), "initWithFrame:", CGRectMake(
        (CGRectGetWidth(bounds)-_style.width*_settings.commonScale) / 2.0,
        (CGRectGetHeight(bounds)-_style.height*_settings.commonScale -_settings.toolbarSize) / 2.0,
        _style.width*_settings.commonScale,
        _style.height*_settings.commonScale));
    objj_msgSend(pageView, "setAutoresizingMask:", CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin | CPViewMaxYMargin);
    objj_msgSend(contentView, "addSubview:", pageView);
    var fileUploader = objj_msgSend(objj_msgSend(FileUploader, "alloc"), "init");
 objj_msgSend(fileUploader, "addObject:", photoPanel);
    objj_msgSend(theWindow, "orderFront:", self);
    objj_msgSend(w2, "orderFront:", self);
}
},["void","CPNotification"]), new objj_method(sel_getUid("adjustImageSize:"), function $AppController__adjustImageSize_(self, _cmd, sender)
{ with(self)
{
    var newSizeAsString = objj_msgSend(CPString, "stringWithFormat:", "%d", objj_msgSend(objj_msgSend(CPNumber, "numberWithDouble:", objj_msgSend(sender, "value")), "intValue"));
    alert(newSizeAsString);
}
},["void","id"])]);
}

