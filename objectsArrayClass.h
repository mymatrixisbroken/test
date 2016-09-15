//
//  strainClass.h
//
//
//  Created by Guy on 7/25/16.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class objectsArrayClass;
extern objectsArrayClass *objectsArray;

@interface objectsArrayClass : NSObject
@property NSMutableArray *strainObjectArray;
@property NSMutableArray *storeObjectArray;


+ (objectsArrayClass *)sharedInstance;

@end
