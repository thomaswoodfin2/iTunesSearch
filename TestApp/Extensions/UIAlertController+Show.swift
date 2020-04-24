//
//  UIAlertController+Show.swift
//  TestApp
//
//  Created by Thomas Woodfin  on 26/7/19.
//  Copyright © 2019 Thomas Woodfin . All rights reserved.
//

import UIKit


extension UIAlertController {
    
    func show() {
        if let visibleViewController = UIApplication.shared.keyWindow?.visibleViewController() {
            DispatchQueue.main.async(execute: {
                visibleViewController.present(self, animated: true, completion: nil)
            })
        } else {
            print("Can not show AlertController As there is no visibleViewController")
        }
    }
    
}
