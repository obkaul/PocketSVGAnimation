# PocketSVGAnimation

A simple toolkit for animating SVGs based on their paths using PocketSVG in the background to load them.

Here are two quick videos demonstrating what kind of animations can be generated.

## A sample company logo. Imagine your own company logo animated like this in an iOS app! :)

![companyLogo](https://user-images.githubusercontent.com/77676833/221433109-c647bc7a-4960-4f5f-b9eb-752539ac6fd8.gif)

## The sample tiger from PocketSVG:

![tiger](https://user-images.githubusercontent.com/77676833/221433122-2e5e0746-52d0-4549-b4ee-aaf651d33d1f.gif)


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
