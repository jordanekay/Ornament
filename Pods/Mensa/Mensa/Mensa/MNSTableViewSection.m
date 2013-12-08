//
//  MNSTableViewSection.m
//  Pods
//
//  Created by Jordan Kay on 12/6/13.
//  Copyright (c) 2013 toxicsoftware. All rights reserved.
//

#import "MNSTableViewSection.h"

@interface MNSTableViewSection ()

@property (nonatomic, copy) NSArray *objects;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *summary;

@end

@implementation MNSTableViewSection

+ (instancetype)sectionWithObjects:(NSArray *)objects
{
    return [self sectionWithTitle:nil objects:objects];
}

+ (instancetype)sectionWithTitle:(NSString *)title objects:(NSArray *)objects
{
    return [self sectionWithTitle:title objects:objects summary:nil];
}

+ (instancetype)sectionWithTitle:(NSString *)title objects:(NSArray *)objects summary:(NSString *)summary
{
    MNSTableViewSection *section = [MNSTableViewSection new];
    section.title = title;
    section.objects = objects;
    section.summary = summary;
    return section;
}

- (NSUInteger)count
{
    return [self.objects count];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
    return self.objects[idx];
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [self.objects countByEnumeratingWithState:state objects:buffer count:len];
}

@end
