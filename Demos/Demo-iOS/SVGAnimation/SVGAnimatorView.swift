//
//  SVGAnimatorView.swift
//  Demo-iOS
//
//  Created by Beren Kaul on 26.02.23.
//

import Foundation
import SwiftUI
import PocketSVG

struct SVGAnimatorView: View {
    @State var endAmount: CGFloat = 0
    @State var isFilled: Bool = false
    
    var myPaths = [SVGBezierPath]()
    
    var myPathsOpacities = [Double]()
    var myPathsFillColors = [CGColor]()
    var myPathsStrokeColors = [CGColor]()
    var myPathsLineCaps = [CGLineCap]()
    var myPathsLineJoins = [CGLineJoin]()
    var myPathsmiterLimits = [CGFloat]()
    var myPathsDashArrays = [[CGFloat]]()
    
    var pathBounds: CGRect
    let strokeAnimationDuration: Double
    let fillAnimationDuration: Double
    let animationDelay: Double
    
    init(paths: [SVGBezierPath],
         strokeAnimationDuration: Double = 1.5,
         fillAnimationDuration: Double = 1.0,
         animationDelay: Double = 0.0)
    {
        for path in paths {
            if path.svgAttributes["display"] as? String == "none" {
                continue
            }
            self.myPaths.append(path)
            
            if let transf = path.svgAttributes["transform"] as? CGAffineTransform {
                path.apply(transf)
            }
            if let fillColor = path.svgAttributes["fill"] {
                let fillColor = fillColor as! CGColor
                myPathsFillColors.append(fillColor)
            }
            else {
                myPathsFillColors.append(UIColor.purple.cgColor) // in case there's no fill color value (should not happen)
            }
            
            if let strokeColor = path.svgAttributes["stroke"] {
                let strokeColor = strokeColor as! CGColor
                myPathsStrokeColors.append(strokeColor)
            }
            else {
                myPathsStrokeColors.append(UIColor.green.cgColor) // in case there's no stroke color value (should not happen)
            }
            
            let pathOpacity = path.svgAttributes["opacity"] as? String
            myPathsOpacities.append(pathOpacity != nil ? Double(pathOpacity!) ?? 1.0 : 1.0)
            
            let lineCapString = path.svgAttributes["stroke-linecap"] as? String
            myPathsLineCaps.append(lineCapString == "round" ? CGLineCap.round : lineCapString == "square" ? CGLineCap.square : CGLineCap.butt)
            
            let lineJoinString = path.svgAttributes["stroke-linejoin"] as? String
            myPathsLineJoins.append(lineJoinString == "round" ? CGLineJoin.round : lineJoinString == "bevel" ? CGLineJoin.bevel : CGLineJoin.miter)
            
            let strokemiterlimit = path.svgAttributes["stroke-miterlimit"] as? String
            myPathsmiterLimits.append(CGFloat(strokemiterlimit != nil ? Double(strokemiterlimit!) ?? 0.0 : 0.0))
            
            if let dashArrayString = path.svgAttributes["stroke-dasharray"] as? String {
                let dashArray = dashArrayString.split(separator: ",")
                let dashArrayFloat = dashArray.map {
                    CGFloat(($0 as NSString).floatValue)
                }
                myPathsDashArrays.append(dashArrayFloat)
            }
            else {
                myPathsDashArrays.append([])
            }
            
        }
        
        self.pathBounds = UIBezierPath.calculateBounds(paths: myPaths)
        
        self.strokeAnimationDuration = strokeAnimationDuration
        self.fillAnimationDuration = fillAnimationDuration
        self.animationDelay = animationDelay
        if strokeAnimationDuration == 0 {
            self.endAmount = 1
        }
        if fillAnimationDuration == 0 {
            self.isFilled = true
        }
    }
    
    var body: some View {
        ZStack {
            ForEach((0..<myPaths.count), id: \.self) { i in
                ShapeView(bounds: pathBounds, bezier: myPaths[i])
                    .trim(from: 0, to: self.endAmount)
                    .stroke(Color(myPathsStrokeColors[i]), style: StrokeStyle(lineWidth: 1,
                                                                              lineCap: myPathsLineCaps[i],
                                                                              lineJoin: myPathsLineJoins[i],
                                                                              miterLimit: myPathsmiterLimits[i],
                                                                              dash: myPathsDashArrays[i],
                                                                              dashPhase: 0))
                    .aspectRatio(pathBounds.width / pathBounds.height, contentMode: .fit)
                    .opacity(myPathsOpacities[i])
                
                ShapeView(bounds: pathBounds, bezier: myPaths[i])
                    .fill(Color(myPathsFillColors[i])
                    .opacity(isFilled ? myPathsOpacities[i] : 0))
                    .aspectRatio(pathBounds.width / pathBounds.height, contentMode: .fit)
            }
        }
        .onAppear {
            if strokeAnimationDuration > 0 || fillAnimationDuration > 0 {
                withAnimation(.easeInOut(duration: strokeAnimationDuration).delay(animationDelay)) {
                    self.endAmount = 1
                }
                withAnimation(.easeInOut(duration: fillAnimationDuration).delay(animationDelay + strokeAnimationDuration)) {
                    self.isFilled = true
                }
            }
        }
    }
}

struct ShapeView: Shape {
    let bounds: CGRect
    let bezier: SVGBezierPath
    
    func path(in rect: CGRect) -> Path {
        let scale = max(bounds.width, bounds.height)
        
        let pTrans = CGAffineTransform(scaleX: 1/scale, y: 1/scale)
        let path = Path(bezier.cgPath).applying(pTrans)
        
        let multi = rect.width > rect.height ? max(rect.width, rect.height) : min(rect.width, rect.height)
        let trans = CGAffineTransform(scaleX: multi, y: multi)
        
        return path.applying(trans)
    }
}
