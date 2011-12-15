@STATIC;1.0;I;21;Foundation/CPObject.jt;2105;objj_executeFile("Foundation/CPObject.j", NO);
{var the_class = objj_allocateClassPair(CPObject, "Ajax"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("ajaxObject")]);
objj_registerClassPair(the_class);
class_addMethods(the_class, [new objj_method(sel_getUid("init"), function $Ajax__init(self, _cmd)
{ with(self)
{
 ajaxObject = objj_msgSend(self, "createXMLHttp");
    return self;
}
},["id"]), new objj_method(sel_getUid("get:"), function $Ajax__get_(self, _cmd, parameters)
{ with(self)
{
 parameters.async = typeof(parameters.async) == 'undefined' ? true : parameters.async;
 parameters.type = typeof(parameters.type) == 'undefined' ? 'get' : parameters.type;
 parameters.url = typeof(parameters.url) == 'undefined' ? window.location : parameters.url;
 ajaxObject.open(parameters.type, parameters.url, parameters.async);
    if (parameters.async == true)
    {
        ajaxObject.onreadystatechange = function()
        {
            if (ajaxObject.status == 200 && ajaxObject.readyState == 4)
            {
                var sData = ajaxObject.responseText;
                if (typeof parameters.success == 'function')
                    parameters.success(sData);
            }
        };
    }
 ajaxObject.send(null);
 if (parameters.async == false)
 {
  if (ajaxObject.status == 200 && ajaxObject.readyState == 4)
  {
   var sData = ajaxObject.responseText;
   if (typeof parameters.success == 'function')
    parameters.success(sData);
  }
 }
}
},["void","JSON"]), new objj_method(sel_getUid("createXMLHttp"), function $Ajax__createXMLHttp(self, _cmd)
{ with(self)
{
 if (typeof XMLHttpRequest != "undefined")
 {
  return new XMLHttpRequest();
 }
 else if (window.ActiveXObject)
 {
  var aVersions = ["MSXML2.XMLHttp.5.0", "MSXML2.XMLHttp.4.0",
      "MSXML2.XMLHttp.3.0", "MSXML2.XMLHttp",
      "Microsoft.XMLHttp"
      ];
  for (var i = 0; i < aVersions.length; i++)
  {
   try
   {
    var oXmlHttp = new ActiveXObject(aVersions[i]);
    return oXmlHttp;
   }
   catch (oError)
   {
   }
  }
  throw new Error("Can't create XMLHttp object.");
 }
}
},["id"])]);
}

