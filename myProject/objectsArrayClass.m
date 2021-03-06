//
//  strainClass.m
//
//
//  Created by Guy on 7/25/16.
//
//

#import "objectsArrayClass.h"

objectsArrayClass *objectsArray;

@implementation objectsArrayClass

@synthesize strainObjectArray;
@synthesize storeObjectArray;

+ (objectsArrayClass *)sharedInstance {
    static dispatch_once_t onceToken;
    static objectsArrayClass *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[objectsArrayClass alloc] init];
    });
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        self.strainObjectArray = [[NSMutableArray alloc] init];
        self.storeObjectArray = [[NSMutableArray alloc] init];
    }
    return self;
}


@end
