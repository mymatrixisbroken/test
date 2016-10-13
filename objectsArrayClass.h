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

enum selection
{
    strains = 0,
    stores = 1,
};

enum searchType
{
    loadObjects = 0,
    nearMeRecommended = 1,
    AtoZ = 2,
    visitedSmoked = 3,
    wishList = 4,
    search = 5,
};


@interface objectsArrayClass : NSObject
@property NSMutableArray *strainObjectArray;
@property NSMutableArray *storeObjectArray;
@property NSMutableArray *eventObjectArray;
@property NSMutableArray *userSearchObjectArray;
@property (assign, nonatomic) enum selection selection;
@property (assign, nonatomic) enum searchType searchType;


+ (objectsArrayClass *)sharedInstance;

@end
