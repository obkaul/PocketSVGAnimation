# PocketSVGAnimation

A simple toolkit for animating SVGs based on their paths using PocketSVG in the background to load them.

Here are two quick videos demonstrating what kind of animations can be generated.

## A sample company logo. Imagine your own companies logo animated like this in an iOS app! :)

https://user-images.githubusercontent.com/77676833/221431183-d3a44b0a-45e9-404c-973c-c3fa37a27dfb.mov


## The sample tiger from PocketSVG:

https://user-images.githubusercontent.com/77676833/221431185-f4040517-8496-4908-b2f9-6b40313b55bc.mov


## Adding an animated SVG logo

```swift
let url = Bundle.main.url(forResource: "tiger", withExtension: "svg")!

// animatedSvgView is a SwiftUI View
// The SwiftUI view can alternatively be added to a UIViewController using the handy extension UIViewController.addSubSwiftUIView(...)
let animatedSvgView = SVGAnimator.getAnimatedSVGView(svgUrl: url,
                                   strokeAnimationDuration: 1.5,
                                   fillAnimationDuration: 1.0,
                                   animationDelay: 0.0)   // delay after onAppear
```

All relevant code for the animation can be found in 
https://github.com/obkaul/PocketSVGAnimation/tree/master/Demos/Demo-iOS/SVGAnimation 

It's not compatible with the mac demo yet but easy to adapt.

## Enjoy and share!

Cheers, Beren

https://www.beren.ch
