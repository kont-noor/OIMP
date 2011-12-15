@STATIC;1.0;I;16;AppKit/CPPanel.ji;12;FileUpload.jt;2666;objj_executeFile("AppKit/CPPanel.j", NO);
objj_executeFile("FileUpload.j", YES);
{var the_class = objj_allocateClassPair(CPObject, "FileUploader"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("browseButton"), new objj_ivar("photoPanel")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $FileUploader__init(self, _cmd)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("FileUploader").super_class }, "init");
    if (self)
    {
  browseButton = objj_msgSend(objj_msgSend(UploadButton, "alloc"), "initWithFrame:",  CGRectMake(
                0, 0,
                _settings.toolbarItemSize, _settings.toolbarItemSize
            ));
  objj_msgSend(browseButton, "setTitle:", _lang.upload_images_button1);
  objj_msgSend(browseButton, "setURL:", "/translator/index");
  objj_msgSend(browseButton, "setName:", "file");
        if (__browser.iphone)
        {
            objj_msgSend(browseButton, "setTarget:", self);
            objj_msgSend(browseButton, "setAction:", sel_getUid("upload:"));
        }
  objj_msgSend(browseButton, "setAutoresizingMask:", CPViewMinXMargin | CPViewMaxXMargin | CPViewMinYMargin);
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "upload.png"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
  objj_msgSend(browseButton, "setImage:", image);
  objj_msgSend(objj_msgSend(objj_msgSend(toolbar, "items")[1], "view"), "addSubview:", browseButton);
    }
    return self;
}
},["id"]), new objj_method(sel_getUid("upload:"), function $FileUploader__upload_(self, _cmd, aSender)
{ with(self)
{
    var start = new Date();
    setTimeout(function()
    {
        if (new Date() - start > 2000)
        {
            return;
        }
        window.location = 'http://www.cliqcliq.com/quickpic/install/';
    }, 1000);
    var getParams = ['action=http://192.168.0.85:3000//uploader/index',
                 'continue=http://192.168.0.85:3000',
                 'contact=0,1:email',
                 'images=1+',
                 'video=1+',
                 'context=ABCDEF0123456789',
                 'passcontext=1',
                 'maxsize=422',
                 'edit=1',
                 'v=1.2'];
    window.location = 'vquickpic://?' + getParams.join('&');
}
},["void","id"]), new objj_method(sel_getUid("addObject:"), function $FileUploader__addObject_(self, _cmd, anObject)
{ with(self)
{
 photoPanel = anObject;
 objj_msgSend(browseButton, "addObject:", anObject);
}
},["void","id"])]);
}

