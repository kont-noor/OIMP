@STATIC;1.0;I;23;Foundation/Foundation.jI;15;AppKit/AppKit.ji;15;AppController.ji;6;Ajax.jt;1667;






objj_executeFile("Foundation/Foundation.j", NO);
objj_executeFile("AppKit/AppKit.j", NO);

objj_executeFile("AppController.j", YES);
objj_executeFile("Ajax.j", YES);

mainBundle = nil;
_browser = 'default';
ajax = nil;

main= function(args, namedArgs)
{
    mainBundle = objj_msgSend(CPBundle, "mainBundle");
 _lang = initLanguage(_lang.name);
    _settings = initSettings();

    CPApplicationMain(args, namedArgs);
}


initLanguage= function(lang)
{
 ajax = objj_msgSend(objj_msgSend(Ajax, "alloc"), "init");

 var parameters = {
  type: 'get',
  url: objj_msgSend(mainBundle, "pathForResource:", "languages/" + lang + ".json"),
  async: false,
  success: function(data)
  {
   if (data != '')
   {
    lang = eval("(" + data + ")");
   }
   else
    lang = false;
  }
 };
 lang = false;

 objj_msgSend(ajax, "get:", parameters);

 return lang;
}


initSettings= function()
{
    var _ua = navigator.userAgent.toLowerCase();
    __browser = {
        opera: /opera/i.test(_ua),
        msie: (!this.opera && /msie/i.test(_ua)),
        mozilla: /firefox/i.test(_ua),
        chrome: /chrome/i.test(_ua),
        iphone: /iphone/i.test(_ua)
    };


    var limWindowWidth = 640;
    var windowWidth = document.body.offsetWidth;
    if (windowWidth <= limWindowWidth)
        _browser = 'mobile';


 var parameters = {
  type: 'get',
  url: objj_msgSend(mainBundle, "pathForResource:", "settings/" + _browser + ".json"),
  async: false,
  success: function(data)
  {
   if (data != '')
   {
    _settings = eval("(" + data + ')');
   }
   else
    _settings = false;
  }
 };
 _settings = false;

 objj_msgSend(ajax, "get:", parameters);
 return _settings;
}

