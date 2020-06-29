//
//  ThankYouViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 29/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class ThankYouView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: { // Wait 5 seconds
            self.backToStart()
        })
    }
    
    func backToStart() {
        let vcToPresent = storyboard!.instantiateViewController(identifier: "StartView") as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        vcToPresent.modalTransitionStyle = .crossDissolve
        present(vcToPresent, animated: true, completion: nil)
    }
}
