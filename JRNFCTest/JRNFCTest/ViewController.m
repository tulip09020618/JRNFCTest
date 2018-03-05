//
//  ViewController.m
//  JRNFCTest
//
//  Created by hqtech on 2018/3/1.
//  Copyright © 2018年 tulip. All rights reserved.
//

#import "ViewController.h"
#import <CoreNFC/CoreNFC.h>

@interface ViewController ()<NFCReaderSessionDelegate, NFCNDEFReaderSessionDelegate>

@property (nonatomic, strong) NFCNDEFReaderSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:NO];
    self.session.alertMessage = @"提示：读取NFC信息";
    
}

- (IBAction)startScan:(id)sender {
    [self.session beginSession];
}

- (IBAction)endScan:(id)sender {
    [self.session invalidateSession];
}

#pragma mark NFCNDEFReaderSessionDelegate
- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    NSLog(@"message:%@", messages);
    for (NFCNDEFMessage *message in messages) {
        for (NFCNDEFPayload *payload in message.records) {
            NSLog(@"Payload data:%@", payload.payload);
        }
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NFCReaderSessionDelegate
- (void)readerSessionDidBecomeActive:(NFCReaderSession *)session {
    NSLog(@"session:%@", session);
}

/*!
 * @method readerSession:didDetectTags:
 *
 * @param session   The session object used for tag detection.
 * @param tags      Array of @link NFCTag @link/ objects.
 *
 * @discussion      Gets called when the reader detects NFC tag(s) in the polling sequence.
 */
- (void)readerSession:(NFCReaderSession *)session didDetectTags:(NSArray<__kindof id<NFCTag>> *)tags {
    NSLog(@"session:%@, tags:%@", session, tags);
}


@end
