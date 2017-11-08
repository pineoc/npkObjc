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
{
    NSString *bundlePath;
    NSArray* keys;
}

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    bundlePath = [[NSBundle mainBundle] resourcePath];
    keys = @[@1, @2, @3, @4];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testInitWithNPKFile
{
    NSString* npkFilePath = [bundlePath stringByAppendingPathComponent:@"foo.npk"];
    
    // success test
    npkObjc* npk = [[npkObjc alloc] initWithNPKFile:npkFilePath npkKey:keys];
    XCTAssertNotNil(npk);
    
    // fail test
    npk = [npk initWithNPKFile:@"fail.npk" npkKey:keys];
    XCTAssertNil(npk);
}

-(void)testEntityPackedSize
{
    NSString* npkFilePath = [bundlePath stringByAppendingPathComponent:@"foo.npk"];
    
    // success test
    npkObjc* npk = [[npkObjc alloc] initWithNPKFile:npkFilePath npkKey:keys];
    XCTAssertNotNil(npk);
    
    XCTAssertTrue([npk entityPackedSize:@"text1"] > 0);
    XCTAssertFalse([npk entityPackedSize:@"failtest"] > 0);
}

- (void)testExportFromNPKFile
{
    // test file foo.npk
    // foo.npk {text1, test_img.jpg, key: [1,2,3,4]}
    
    npkObjc* npk = [npkObjc alloc];
    NSString* npkFilePath = [bundlePath stringByAppendingPathComponent:@"foo.npk"];
    NSString* textFilePath = [bundlePath stringByAppendingPathComponent:@"text1"];
    NSString* imageFilePath = [bundlePath stringByAppendingPathComponent:@"test_img.jpg"];
    
    XCTAssertNotNil(npkFilePath);
    XCTAssertNotNil(textFilePath);
    
    NSData* unpackData = [npk exportFromNPKFile:npkFilePath filename:@"text1" npkKey:keys];
    NSData* textData = [NSData dataWithContentsOfFile: textFilePath];
    
    XCTAssertNotNil(unpackData);
    XCTAssertNotNil(textData);
    
    XCTAssertTrue([unpackData length] > 0);
    XCTAssertTrue([textData length] > 0);
    
    XCTAssertNotEqual(unpackData, textData);
    
    NSData* unpackDataImage = [npk exportFromNPKFile:npkFilePath filename:@"test_img.jpg" npkKey:keys];
    NSData* imageData = [NSData dataWithContentsOfFile:imageFilePath];
    
    XCTAssertNotNil(unpackDataImage);
    XCTAssertNotNil(imageData);
    
    XCTAssertTrue([unpackDataImage length] > 0);
    XCTAssertTrue([imageData length] > 0);
    
    XCTAssertNotEqual(unpackDataImage, imageData);
}


@end
