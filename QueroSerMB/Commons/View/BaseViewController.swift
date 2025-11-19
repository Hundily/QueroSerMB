//
//  BaseViewController.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigation()
    }
    
    func setupNavigation() {
        let image = UIImage(named: "arrow-back-button")
        let backButton = UIButton(type: .custom)
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.setImage(image, for: .normal)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.backBarButtonItem = backButtonItem
        navigationController?.navigationBar.barTintColor = UIColor.orange
        navigationController?.navigationBar.tintColor = UIColor.black
        title = ""
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
