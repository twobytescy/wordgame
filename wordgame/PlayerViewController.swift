//
//  PlayerViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 30/12/2017.
//  Copyright © 2017 Stelios Ioannou. All rights reserved.
//

import UIKit
import PureLayout
import SkyFloatingLabelTextField

class PlayerViewController: UIViewController {
    let nameTextField = SkyFloatingLabelTextField.newAutoLayout()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nameTextField.placeholder = "Όνομα";
        nameTextField.autocorrectionType = .no
        self.view.addSubview(nameTextField)
        
        nameTextField.autoPinEdge(toSuperviewEdge: .left)
        nameTextField.autoPinEdge(toSuperviewEdge: .right)
        nameTextField.autoPinEdge(toSuperviewEdge: .top)
        nameTextField.autoPinEdge(toSuperviewEdge: .bottom)
        
        nameTextField.autoSetDimension(.height, toSize: 50)
        nameTextField.autoSetDimension(.width, toSize: 250)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
