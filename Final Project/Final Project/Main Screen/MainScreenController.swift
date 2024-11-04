//
//  MainScreenController.swift
//  Final Project
//
//  Created by Che-Yi Wu on 2024/11/3.
//

import UIKit

class MainScreenController: UIViewController {
    //MARK: Main Screen View
    let mainScreenView = MainScreenView()

    override func loadView() {
        view = mainScreenView

    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft // or .landscapeRight
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}
