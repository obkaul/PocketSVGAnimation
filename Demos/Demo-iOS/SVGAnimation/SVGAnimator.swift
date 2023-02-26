//
//  SVGAnimator.swift
//  
//
//  Created by Beren Kaul on 26.02.23.
//

import Foundation
import UIKit
import SwiftUI
import PocketSVG

class SVGAnimator {
    static func getAnimatedSVGView(resourceName: String,
                                   ext: String = "svg",
                                   strokeAnimationDuration: Double = 1.5,
                                   fillAnimationDuration: Double = 1.0,
                                   animationDelay: Double = 0.0) -> SVGAnimatorView?
    {
        if let fileUrl = Bundle.main.url(forResource: resourceName, withExtension: ext) {
            return getAnimatedSVGView(svgUrl: fileUrl,
                                      strokeAnimationDuration: strokeAnimationDuration,
                                      fillAnimationDuration: fillAnimationDuration,
                                      animationDelay: animationDelay)
        }
        return nil
    }
    
    static func getAnimatedSVGView(svgUrl: URL,
                                   strokeAnimationDuration: Double = 1.5,
                                   fillAnimationDuration: Double = 1.0,
                                   animationDelay: Double = 0.0) -> SVGAnimatorView?
    {
        // load svg using PocketSVG, we are just interested in the SVGBezierPaths
        let paths = SVGBezierPath.pathsFromSVG(at: svgUrl)
        
        let myView = SVGAnimatorView(paths: paths, strokeAnimationDuration: strokeAnimationDuration, fillAnimationDuration: fillAnimationDuration, animationDelay: animationDelay)
        return myView
    }
}


