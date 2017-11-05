//
//  npkObjc.h
//  npkObjc
//
//  Created by pineoc on 2017. 10. 30..
//  Copyright © 2017년 pineoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface npkObjc : NSObject

-(NSData*) unpackNPKfile:(NSString*) url filename: (NSString*) file npkKey:(NSArray*) npkKey;

@end
