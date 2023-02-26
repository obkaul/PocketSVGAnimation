//
//  SVGAnimatorExtensions.swift
//  Demo-iOS
//
//  Created by Beren Kaul on 26.02.23.
//

import Foundation
import SwiftUI
import UIKit

extension UIBezierPath {
    static func calculateBounds(paths: [UIBezierPath]) -> CGRect {
        let myPaths = UIBezierPath()
        for path in paths {
            myPaths.append(path)
        }
        return (myPaths.bounds)
    }
}


extension UIViewController {
    func addSubSwiftUIView<Content>(_ swiftUIView: Content, to view: UIView, hideNavigationBar: Bool = true) where Content : View {
        let hostingController = UIHostingController(rootView: swiftUIView)

        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.backgroundColor = .clear
        
        if hideNavigationBar {
            hostingController.navigationController?.setNavigationBarHidden(true, animated: false)
        }

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hostingController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        hostingController.didMove(toParent: self)
    }
}
