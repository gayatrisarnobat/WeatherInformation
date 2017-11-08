//
//  GSAppUtils.swift
//  GSWeatherInfo
//
//  Created by Gayatri Sarnobat on 08/11/17.
//  Copyright © 2017 Gayatri Sarnobat. All rights reserved.
//

import UIKit
import Foundation

class GSAppUtils{
    // MARK: Activity Indicator Helpers
    class func showSpinner(){
        GSAppUtils.stopSpinner()
        if let mainWindow = UIApplication.shared.keyWindow{
            if let vwActInd = mainWindow.viewWithTag(10000) as? UIActivityIndicatorView{
                vwActInd.startAnimating()
                vwActInd.isHidden = false
                mainWindow.bringSubview(toFront: vwActInd)
            }else{
                let vwActInd = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                vwActInd.tag = 10000
                vwActInd.hidesWhenStopped = true
                vwActInd.center = mainWindow.center
                mainWindow.addSubview(vwActInd)
                mainWindow.bringSubview(toFront: vwActInd)
                vwActInd.startAnimating()
            }
        }
    }
    
    class func stopSpinner(){
        if let mainWindow = UIApplication.shared.keyWindow{
            if let vwActInd = mainWindow.viewWithTag(10000) as? UIActivityIndicatorView{
                vwActInd.stopAnimating()
            }
        }
    }
}
