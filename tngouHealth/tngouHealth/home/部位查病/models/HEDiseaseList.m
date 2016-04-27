//
//  HEDiseaseList.m
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEDiseaseList.h"

@implementation HEDiseaseList
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.symptom forKey:@"symptom"];
    [aCoder encodeObject:self.symptomtext forKey:@"symptomtext"];
    [aCoder encodeObject:self.caretext forKey:@"caretext"];
    [aCoder encodeObject:self.checktext forKey:@"checktext"];
    [aCoder encodeObject:self.department forKey:@"department"];
    [aCoder encodeObject:self.drug forKey:@"drug"];
    [aCoder encodeObject:self.drugtext forKey:@"drugtext"];
    [aCoder encodeObject:self.foodtext forKey:@"foodtext"];
    [aCoder encodeObject:self.checks forKey:@"checks"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.food forKey:@"food"];
    [aCoder encodeObject:self.disease forKey:@"disease"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.symptom = [aDecoder decodeObjectForKey:@"symptom"];
        self.symptomtext = [aDecoder decodeObjectForKey:@"symptomtext"];
        self.caretext = [aDecoder decodeObjectForKey:@"caretext"];
        self.checktext = [aDecoder decodeObjectForKey:@"checktext"];
        self.department = [aDecoder decodeObjectForKey:@"department"];
        self.drug = [aDecoder decodeObjectForKey:@"drug"];
        self.drugtext = [aDecoder decodeObjectForKey:@"drugtext"];
        self.foodtext = [aDecoder decodeObjectForKey:@"foodtext"];
        self.checks = [aDecoder decodeObjectForKey:@"checks"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.food = [aDecoder decodeObjectForKey:@"food"];
        self.disease = [aDecoder decodeObjectForKey:@"disease"];
    }
    return self;
}
@end
