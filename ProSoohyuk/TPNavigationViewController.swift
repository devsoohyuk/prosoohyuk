//
//  TPNavigationViewController.swift
//  ProSoohyuk
//
//  Created by soohyuk hong on 2020/11/22.
//

import UIKit

class TPNavigationViewController: UINavigationController {
    
    // status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = .black
        self.navigationBar.isTranslucent = false
        
        let backButtonBackgroundImage = UIImage(named: "btn_top_arrow")
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [TPNavigationViewController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        
        let barButtonAppearance =
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [TPNavigationViewController.self])
        // text position
        barButtonAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: 0), for: .default)
        barButtonAppearance.tintColor = .white
    }
    
    
}
