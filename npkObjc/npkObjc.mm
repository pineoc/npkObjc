//
//  npkObjc.m
//  npkObjc
//
//  Created by pineoc on 2017. 10. 30..
//  Copyright © 2017년 pineoc. All rights reserved.
//

#import "npkObjc.h"
#import "npk.h"

@implementation npkObjc

-(NSData*) exportFromNPKFile:(NSString*) url filename: (NSString*) file npkKey:(NSArray*) npkKey;
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
    int count = [npkKey count];
    for (int i = 0; i < count; i++)
    {
        key[i] = [[npkKey objectAtIndex:i] intValue];
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
