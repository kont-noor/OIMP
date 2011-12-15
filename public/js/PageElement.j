/*
 * PageElement.j
 * ODT
 *
 * Created by Nickolay Kondratenko <devmarkup@gmail.com>
 * Copyright 2011, EZ Intelligence All rights reserved.
 */


@implementation PageElement : CPObject
{
    CPString            type;
    JSONArray		attributes;
}

- (id)initWithTemplate : (JSON)template
{
    self = [super init];
    
    if (self)
    {
        type = template.type;
        attributes = template;
    }
    return self;
}

- (CPString)type
{
    return type;
}

- (BOOL)setImage : (CPImage)anImage
{
    if (type != 'image')
        return false;

    attributes.image = anImage;
    return true;
}

- (CPImage)image
{
    if (type != 'image')
        return false;

    return attributes.image;
}

- (void)setRotation : (float)angle
{
    attributes['rotation'] = angle;
}

- (void)setGradRotation : (float)angle
{
    attributes['rotation'] = (angle*180)/PI;
}

- (void)rotation : (float)angle
{
    return attributes['rotation'];
}

- (void)setScaleX : (float)scale
{
    attributes['scaleX'] = scale;
}
}

- (void)setScaleY : (float)scale
{
    attributes['scaleY'] = scale;
}

- (void)setOffsetX : (float)offset
{
    attributes['offsetX'] = offset;
}

- (void)setOffsetY : (float)offset
{
    attributes['offsetY'] = offset;
}

- (JSON)attributes
{
    return attributes;
}

@end