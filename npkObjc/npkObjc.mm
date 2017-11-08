//
//  npkObjc.m
//  npkObjc
//
//  Created by pineoc on 2017. 10. 30..
//  Copyright © 2017년 pineoc. All rights reserved.
//

#import "npkObjc.h"


@implementation npkObjc

-(npkObjc*) initWithNPKFile:(NSString*) url npkKey: (NSArray*) keys
{
    fileUrl = url;
    npkKeys = keys;
    
    NPK_TEAKEY key[4];
    NPK_CSTR npkUrl = [fileUrl UTF8String];
    // npk key value setting
    for (int i = 0; i < 4; i++)
        key[i] = [[keys objectAtIndex:i] intValue];
    // npk package open
    npkPackage = npk_package_open(npkUrl, key);
    
    //check npkPackage null
    if(npkPackage == nil)
    {
        NSLog(@"npkPackage can't open, return nil");
        return nil;
    }
    
    return self;
}

-(unsigned int) entityPackedSize:(NSString*) entityName
{
    if(npkPackage == nil)
        return 0;
    
    NPK_ENTITY entity = npk_package_get_entity(npkPackage, [entityName UTF8String]);
    NPK_SIZE size = npk_entity_get_packed_size(entity);
    
    return size;
}

-(unsigned int) entitySize:(NSString*) entityName
{
    if(npkPackage == nil)
        return 0;
    
    NPK_ENTITY entity = npk_package_get_entity(npkPackage, [entityName UTF8String]);
    NPK_SIZE size = npk_entity_get_size(entity);
    
    return size;
}

-(NSData*) entityData:(NSString*) entityName
{
    if(npkPackage == nil)
        return nil;
    
    NPK_ENTITY entity = npk_package_get_entity(npkPackage, [entityName UTF8String]);
    NPK_SIZE size = npk_entity_get_size(entity);
    
    void* buf = malloc(size);
    npk_entity_read(entity, buf);
    NSData* fileData = [[NSData alloc] initWithBytes:buf length:size];
    
    return fileData;
}

-(NSData*) exportFromNPKFile:(NSString*) url filename: (NSString*) file npkKey:(NSArray*) keys
{
    if([[url lastPathComponent] length] == 0)
    {
        return nil;
    }
    
    // NPK Values
    NPK_TEAKEY key[4];
    NPK_CSTR npkUrl = [url UTF8String];
    NPK_CSTR entityName = [file UTF8String];
    
    // npk key value setting
    int count = [keys count];
    for (int i = 0; i < count; i++)
    {
        key[i] = [[keys objectAtIndex:i] intValue];
    }
    
    // npk package -> entity -> data(video file)
    NPK_PACKAGE pack = npk_package_open(npkUrl, key);
    NPK_ENTITY entity = npk_package_get_entity(pack, entityName);
    NPK_SIZE size = npk_entity_get_size(entity);
    void* buf = malloc(size);
    npk_entity_read(entity, buf);
    
    NSString* fileUrl = [url stringByAppendingString: file];
    NSData* fileData = [[NSData alloc] initWithBytes:buf length:size];
    // write file to path
    [fileData writeToFile:fileUrl atomically:YES];
    free(buf);
    
    return fileData;
}

@end
