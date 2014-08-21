//
//  OrnamentExtensions.swift
//  Capsule
//
//  Created by Jordan Kay on 8/21/14.
//  Copyright (c) 2014 Jordan Kay. All rights reserved.
//

import Foundation

extension ORNLayer {
    func colorInView<T: UIView where T: ORNOrnamentable>(view: T, withOptions options: ORNOrnamentOptions) {
        let color = view.orn_ornamentWithOptions(options).color
        backgroundColor = color.CGColor
    }
}

extension ORNGradientLayer {
    func colorInView<T: UIView where T: ORNOrnamentable>(view: T, withOptions options: [ORNOrnamentOptions]) {
        let list = options.map {$0.toRaw()}
        let colors = view.colorsForOptionsList(list)
        let colorRefs = NSMutableArray(capacity: colors.count)
        for color in colors {
            colorRefs.addObject(color.CGColor)
        }
        self.colors = colorRefs
    }
}

private var cachedColors: [NSNumber: UIColor] = [:]

internal func colorWithOptions<T: UIView where T: ORNOrnamentable>(options: ORNOrnamentOptions, forView view: T) -> UIColor? {
    return view.colorsForOptions?[options.toRaw() as NSNumber]! as? UIColor
}

internal func cachedColors(options: [ORNOrnamentOptions], colorHexValues:[UInt]) -> [NSObject: AnyObject] {
    var colors: [NSObject: AnyObject] = [:]
    for (index, option) in enumerate(options) {
        var color: UIColor
        let hexValue = colorHexValues[index]
        if let cachedColor = cachedColors[hexValue] {
            color = cachedColor
        } else {
            color = UIColor.orn_colorWithHex(colorHexValues[index])
            cachedColors[hexValue] = color
        }
        colors[NSNumber(unsignedLong: option.toRaw())] = color
    }
    return colors
}
