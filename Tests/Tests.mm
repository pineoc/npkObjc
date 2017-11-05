//
//  Tests.m
//  Tests
//
//  Created by pineoc on 2017. 10. 31..
//  Copyright © 2017년 pineoc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "npkObjc.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testNPK {
    npkObjc* npk = [npkObjc alloc];
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString* npkFilePath = [bundlePath stringByAppendingPathComponent:@"foo.npk"];
    NSString* textFilePath = [bundlePath stringByAppendingPathComponent:@"text1"];
    
    XCTAssertNotNil(npkFilePath);
    XCTAssertNotNil(textFilePath);
    
    NSArray* npkKey = @[@1, @2, @3, @4];
    
    NSData* unpackData = [npk unpackNPKfile:npkFilePath filename:@"text1" npkKey:npkKey];
    
    NSData* textData = [NSData dataWithContentsOfFile: textFilePath];
    
    XCTAssertFalse(unpackData == textData);
}

@end
