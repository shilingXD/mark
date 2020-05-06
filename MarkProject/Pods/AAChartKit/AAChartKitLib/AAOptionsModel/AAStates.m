//
//  AAStates.m
//  AAChartKitDemo
//
//  Created by AnAn on 2020/1/6.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import "AAStates.h"

@implementation AAStates

AAPropSetFuncImplementation(AAStates, AAHover *, hover)
AAPropSetFuncImplementation(AAStates, AASelect *, select)

@end


@implementation AAHover

AAPropSetFuncImplementation(AAHover, BOOL , enabled)
AAPropSetFuncImplementation(AAHover, NSString *, borderColor)
AAPropSetFuncImplementation(AAHover, NSNumber *, brightness)
AAPropSetFuncImplementation(AAHover, NSString *, color)
AAPropSetFuncImplementation(AAHover, AAHalo *, halo)


@end


@implementation AASelect

AAPropSetFuncImplementation(AASelect, NSString *, borderColor)
AAPropSetFuncImplementation(AASelect, NSString *, color)
AAPropSetFuncImplementation(AASelect, AAHalo *, halo)

@end


@implementation AAHalo

AAPropSetFuncImplementation(AAHalo, NSDictionary *, attributes)
AAPropSetFuncImplementation(AAHalo, NSNumber *, opacity)
AAPropSetFuncImplementation(AAHalo, NSNumber *, size)

@end
