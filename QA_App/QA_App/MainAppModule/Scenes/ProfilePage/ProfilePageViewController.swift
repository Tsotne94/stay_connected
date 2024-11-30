//
//  ProfilePageViewController.swift
//  QA_App
//
//  Created by Cotne Chubinidze on 29.11.24.
//

import UIKit

class ProfilePageViewController: UIViewController, IdentifiableProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        title = "Profile"
    }
}
