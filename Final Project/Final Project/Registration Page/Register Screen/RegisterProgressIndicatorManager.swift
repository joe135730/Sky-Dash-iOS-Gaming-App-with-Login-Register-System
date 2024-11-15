//
//  RegisterProgressIndicatorManager.swift
//  Final Project
//
//  Created by YHY on 11/15/24.
//

import Foundation
extension RegisterViewController:ProgressSpinnerDelegate{
    //add indicator as a child view
    func showActivityIndicator(){
        addChild(childProgressView)
        view.addSubview(childProgressView.view)
        childProgressView.didMove(toParent: self)
        
    }
    
    //detach the indicator
    func hideActivityIndicator(){
        childProgressView.willMove(toParent: nil)
        childProgressView.view.removeFromSuperview()
        childProgressView.removeFromParent()
    }
}
