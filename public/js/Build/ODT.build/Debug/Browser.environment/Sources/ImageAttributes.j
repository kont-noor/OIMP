@STATIC;1.0;I;27;AppKit/CPWindowController.jt;3066;objj_executeFile("AppKit/CPWindowController.j", NO);
{var the_class = objj_allocateClassPair(CPObject, "ImageAttributes"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("attributes")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $ImageAttributes__init(self, _cmd)
{ with(self)
{
 self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("ImageAttributes").super_class }, "init");
 if (self)
 {
        var image = objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(mainBundle, "pathForResource:", "download.png"), CPSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        var toolbarItem = objj_msgSend(toolbar, "items")[3];
  objj_msgSend(toolbarItem, "setImage:", image);
        objj_msgSend(toolbarItem, "setTarget:", self);
        objj_msgSend(toolbarItem, "setMinSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setMaxSize:", CGSizeMake(_settings.toolbarItemSize, _settings.toolbarItemSize));
        objj_msgSend(toolbarItem, "setAction:", sel_getUid("save:"));
  attributes = {
   scale: 1,
   rotation: 0,
   offsetX: 0,
   offsetY: 0,
   imageName: '',
   styleName: _style.name?'/samples/'+_style.name+'/frame_pane.png':'',
   styleWidth: _style.width?_style.width:400,
   styleHeight: _style.height?_style.height:400
  };
 }
 return self;
}
},["id"]), new objj_method(sel_getUid("save:"), function $ImageAttributes__save_(self, _cmd, aSender)
{ with(self)
{
        objj_msgSend(serverIndicator, "startActivity");
        setTimeout(function(){ objj_msgSend(serverIndicator, "finishActivity")}, 4000);
        var form = document.createElement('form');
        form.method = 'POST';
        form.action = '/save/index';
        form.style.display = 'none';
        for (n in attributes)
        {
            var text = document.createElement('input');
            text.type = 'hidden';
            text.name = "attributes["+n+"]";
            text.value = attributes[n];
            form.appendChild(text);
        }
        iframe = document.createElement('iframe');
        iframe.style.display = 'none';
        document.body.appendChild(iframe);
        iframe.appendChild(form);
        form.submit();
}
},["void","id"]), new objj_method(sel_getUid("setAttributes:::::"), function $ImageAttributes__setAttributes_____(self, _cmd, _scale, _rotation, _offsetX, _offsetY, _imageName)
{ with(self)
{
 attributes['scale'] = _scale;
 attributes['rotation'] = (_rotation*180)/PI;
 attributes['offsetX'] = _offsetX;
 attributes['offsetY'] = _offsetY;
 attributes['imageName'] = _imageName;
}
},["void","float","float","float","float","CPString"]), new objj_method(sel_getUid("setCanvas::"), function $ImageAttributes__setCanvas__(self, _cmd, _styleName, aSize)
{ with(self)
{
 attributes['styleName'] = _styleName;
 attributes['styleWidth'] = aSize.width;
 attributes['styleHeight'] = aSize.height;
}
},["void","CPString","CGSize"])]);
}

