/*
 * main.j
 * ImageEditor
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2010, EZ Intelligence All rights reserved.
 */
@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>

@import "AppController.j"
@import "Ajax.j"

mainBundle = nil;
_browser = 'default';
ajax = nil;

function main(args, namedArgs)
{
    mainBundle = [CPBundle mainBundle];
	_lang = initLanguage(_lang.name);
    _settings = initSettings();

    CPApplicationMain(args, namedArgs);
}

///init language
function initLanguage(lang)
{
	ajax = [[Ajax alloc] init];

	var parameters = {
		type: 'get',
		url: [mainBundle pathForResource:@"languages/" + lang + ".json"],
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
	
	[ajax get:parameters];
	
	return lang;
}

///init settings depend on browser
function initSettings()
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
    //document.title = document.title + ' browser:' + _browser;

	var parameters = {
		type: 'get',
		url: [mainBundle pathForResource:@"settings/" + _browser + ".json"],
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

	[ajax get:parameters];
	return _settings;
}
