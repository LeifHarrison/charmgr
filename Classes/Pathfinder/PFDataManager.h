//
//  PFDataManager.h
//  CharMgr
//
//  Created by Leif Harrison on 10/5/12.
//  Copyright (c) 2012 Leif Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFDataManager : NSObject

- (void)importAbilitiesAsXML;
- (void)importAlignmentsAsXML;
- (void)importClassTypesAsXML;
- (void)importRacesAsXML;
- (void)importSkillsAsXML;

@end
