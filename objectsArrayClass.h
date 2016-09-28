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

enum searchType
{
    loadObjects = 0,
    nearMe = 1,
    AtoZ = 2,
};

enum selection
{
    strains = 0,
    stores = 1,
};



@interface objectsArrayClass : NSObject
@property NSMutableArray *strainObjectArray;
@property NSMutableArray *storeObjectArray;
@property (assign, nonatomic) enum selection selection;
@property (assign, nonatomic) enum searchType searchType;


+ (objectsArrayClass *)sharedInstance;

@end
