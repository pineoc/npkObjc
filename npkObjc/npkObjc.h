//
//  npkObjc.h
//  npkObjc
//
//  Created by pineoc on 2017. 10. 30..
//  Copyright © 2017년 pineoc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "npk.h"

@interface npkObjc : NSObject
{
    NSString* fileUrl;
    NSArray* npkKeys;
    NPK_PACKAGE npkPackage;
}
/**/
-(npkObjc*) initWithNPKFile:(NSString*) url npkKey: (NSArray*) keys;
/**/
-(unsigned int) entityPackedSize:(NSString*) entityName;
/**/
-(unsigned int) entitySize:(NSString*) entityName;
/**/
-(NSData*) entityData:(NSString*) entityName;
/**/
-(NSData*) exportFromNPKFile:(NSString*) url filename: (NSString*) file npkKey:(NSArray*) keys;

@end
