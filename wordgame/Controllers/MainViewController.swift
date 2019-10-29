//
//  MainViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 19/10/2018.
//  Copyright © 2018 Stelios Ioannou. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bomb")
        imageView.contentMode = .scaleAspectFit
        return imageView
        
    }()
    
    
    func button(text: String) -> UIButton {
        
        let button1 = UIButton()
        button1.setTitleColor(.black, for: .normal)
        button1.setTitle(text, for: UIControlState.normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 38, weight: .semibold)
        return button1
        
    }
    
    lazy var menuContentView: UIView = {
        let view = UIView()
        
        let startButton = button(text: "Έναρξη")
        startButton.addTarget(self, action: #selector(startGame), for: .touchDown)
        view.addSubview(startButton)
        startButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
            
        })
        
        let rulesButton = button(text: "Κανόνες")
        view.addSubview(rulesButton)
        rulesButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(startButton.snp.top)
            
        })
        
        return view
    }()
    
    
    @objc func startGame() {
        let playersController = NumberOfPlayersViewController()
        playersController.view.backgroundColor = .white
        self.navigationController?.pushViewController(playersController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

        // Do any additional setup after loading the view.
    }

    func configureUI() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) -> Void in

            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                // Fallback on earlier versions
            }
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
        view.addSubview(menuContentView)
        menuContentView.snp.makeConstraints { (make) -> Void in
            
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            } else {
                // Fallback on earlier versions
            }
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(300)

        }
        
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
