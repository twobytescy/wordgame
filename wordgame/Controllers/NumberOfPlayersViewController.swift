//
//  NumberOfPlayersViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 28/10/2018.
//  Copyright © 2018 Stelios Ioannou. All rights reserved.
//

import UIKit

class NumberOfPlayersViewController: UIViewController {

    
    var numberOfPlayers: Int = 2
    lazy var numberOfPlayersLabel: UILabel = {
        let label = UILabel()
        label.text = String(numberOfPlayers)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = MainApp.shared.theme.primaryColor
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("+", for: UIControlState.normal)
        button.setTitleColor(.black, for: UIControlState.normal)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.addTargetClosure { _ in
            
            self.numberOfPlayers = self.numberOfPlayers == 5 ?self.numberOfPlayers : self.numberOfPlayers + 1
            self.numberOfPlayersLabel.text = String(self.numberOfPlayers)
        }
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton.init()
        button.setTitle("-", for: UIControlState.normal)
        button.setTitleColor(.black, for: UIControlState.normal)
        button.titleLabel?.textAlignment = .right
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        button.addTargetClosure { _ in
            
            self.numberOfPlayers = self.numberOfPlayers == 1 ?self.numberOfPlayers : self.numberOfPlayers - 1
            self.numberOfPlayersLabel.text = String(self.numberOfPlayers)
        }
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = MainApp.shared.theme.primaryColor
        button.setTitle("ΣΥΝΕΧΕΙΑ", for: UIControlState.normal)
        button.setTitleColor(.white, for: UIControlState.normal)
        button.layer.cornerRadius = 6
        button.addTargetClosure(closure: { (button) in
            let playerSelectionController = PlayerSelectionTableViewController.init(style: UITableViewStyle.grouped)
            playerSelectionController.numberOfPlayers = self.numberOfPlayers
            self.navigationController?.pushViewController(playerSelectionController, animated: true)
        })
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        view.addSubview(numberOfPlayersLabel)
        numberOfPlayersLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        
        view.addSubview(minusButton)
        minusButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(numberOfPlayersLabel.snp.leading)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        view.addSubview(plusButton)
        plusButton.snp.makeConstraints { (make) in
            make.leading.equalTo(numberOfPlayersLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeArea.bottom).offset(-8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(55)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
