//
//  DetailViewController.swift
//  Demo-iOS
//
//  Created by Ariel Elkin on 04/04/2018.
//  Copyright © 2018 PocketSVG. All rights reserved.
//

import UIKit
import PocketSVG

class SimpleDetailViewController: UIViewController {

    let svgURL: URL
    var svgContainerView: UIView!
    
    init(svgURL: URL) {
        self.svgURL = svgURL
        
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .white
        initContainerView()
        addAnimatedSVGView()

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addAnimatedSVGView)))
        view.isUserInteractionEnabled = true
    }
    
    func initContainerView() {
        svgContainerView?.removeFromSuperview() // remove potential old container view first
        svgContainerView = UIView()
        svgContainerView.contentMode = .scaleAspectFit

        view.addSubview(svgContainerView)
        svgContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            svgContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            svgContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            svgContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            svgContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            ]
        )
    }

    @objc func addAnimatedSVGView() {
        initContainerView()
        
        let svgAnimatedView = SVGAnimator.getAnimatedSVGView(svgUrl: svgURL, strokeAnimationDuration: 2.0)
        addSubSwiftUIView(svgAnimatedView!, to: svgContainerView)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
