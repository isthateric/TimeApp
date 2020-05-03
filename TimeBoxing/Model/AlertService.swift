//
//  AlertService.swift
//  TimeBoxing
//
//  Created by Eric Fuentes on 4/5/20.
//  Copyright © 2020 eric. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    
    func alert(completion: @escaping() -> Void) -> AlertViewController {
        let storyboard = UIStoryboard(name: "Alert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(identifier: "AlertVC") as! AlertViewController
        
        alertVC.buttonAction = completion
        return alertVC
    }
}
