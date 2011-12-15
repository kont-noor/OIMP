/*
 * Page.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */
 
@import "PageElement.j"

@implementation Page : CPObject
{
    CPArray         elements;
    int             currentElement;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
    }
    return self;
}

- (void)load : (JSON)template
{
    elements = [];
    for (i = 0; i < template.elements.length; i++)
    {
        (template.elements[i]).folder = template.name;
        var element = [[PageElement alloc] initWithTemplate:template.elements[i]];
        [elements addObject:element];
    }
}

- (void)save
{
}

- (void)redrawOnView : (PageView)view
{
    [view redraw:self];
}

- (void)setCurrentElement : (int)number
{

}

- (void)addElement : (PageElement)anElement
{
}

- (void)removeCurrentElement
{
}

- (CPArray)elements
{
    return elements;
}

@end