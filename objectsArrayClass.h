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

enum strainOrStore
{
    strains = 0,
    stores = 1,
};

enum filterSelected
{
    mapView = 0,
    nearMeRecommended = 1,
    AtoZ = 2,
    visitedSmoked = 3,
    wishList = 4,
    search = 5,
    loadObjects = 10,
};


@interface objectsArrayClass : NSObject
@property NSMutableArray *strainObjectArray;
@property NSMutableArray *storeObjectArray;
@property NSMutableArray *eventObjectArray;
@property NSMutableArray *moderateStoresObjectArray;
@property NSMutableArray *addPhotosObjectArray;
@property NSMutableArray *userSearchObjectArray;
@property (assign, nonatomic) enum strainOrStore strainOrStore;
@property (assign, nonatomic) enum filterSelected filterSelected;
@property BOOL flag;


+ (objectsArrayClass *)sharedInstance;

@end
