//
//  ViewController.swift
//  sample
//
//  Created by Tu on 11/19/18.
//  Copyright © 2018 tungpt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.pushViewController(AddNewPeopleViewController(nibName: nil, bundle: nil), animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

