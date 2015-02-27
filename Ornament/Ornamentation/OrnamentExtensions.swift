//
//  OrnamentExtensions.swift
//  Typeaux
//
//  Created by Jordan Kay on 8/21/14.
//  Copyright (c) 2014 Jordan Kay. All rights reserved.
//

import Foundation
import Ornament

extension ORNLayer {
    public func colorInView<T: UIView where T: ORNOrnamentable>(view: T, withOptions options: ORNOrnamentOptions) {
        let color = view.orn_ornamentWithOptions(options).color
        backgroundColor = color.CGColor
    }
}

extension ORNGradientLayer {
    public func colorInView<T: UIView where T: ORNOrnamentable>(view: T, withOptions options: ORNOrnamentOptions...) {
        let list = options.map { $0.rawValue }
        let colors = view.colorsForOptionsList(list)
        var colorRefs: [CGColor] = []
        for color in colors {
            colorRefs.append(color.CGColor)
        }
        self.colors = colorRefs
    }
}

private var cachedColors: [NSNumber: UIColor] = [:]

public func colorWithOptions<T: UIView where T: ORNOrnamentable>(options: ORNOrnamentOptions, forView view: T) -> UIColor? {
    if let colors = view.colorsForOptions {
        for (value, color) in colors {
            let number = value as NSNumber
            if (number.unsignedLongValue & options.rawValue) > 0 {
                return color as? UIColor
            }
        }
    }
    return nil
}

public func cachedColors(options: [ORNOrnamentOptions], colorHexValues: [UInt]) -> [NSObject: AnyObject] {
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
        colors[NSNumber(unsignedLong: option.rawValue)] = color
    }
    return colors
}
