//
//  TheGameViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 17/11/2018.
//  Copyright © 2018 Stelios Ioannou. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import FontAwesome_swift

class TheGameViewController: UIViewController, AVAudioPlayerDelegate {

    var typesOfGame = ["ΟΧΙ ΣΤΗΝ ΑΡΧΗ","ΟΧΙ ΣΤΟ ΤΕΛΟΣ","ΠΑΝΤΟΥ ΣΤΗΝ ΛΕΞΗ"]
    var bombImageView: UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "bomb"))
    var gameStarted: Bool = true
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#414141")
        view.layer.cornerRadius = 8
        
        view.addSubview(cardLabel)
        cardLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        
        view.addSubview(typeOfGameLabel)
        typeOfGameLabel.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        })
        
        
        return view
    }()
    
    lazy var cardLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.text = "ΣΔ"
        return label
    }()
    
    lazy var typeOfGameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "ΣΔ"
        return label
    }()
    
    func button(text: String) -> UIButton {
        
        let button1 = UIButton()
        button1.setTitleColor(.black, for: .normal)
        button1.setTitle(text, for: UIControlState.normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 38, weight: .semibold)
        return button1
        
    }
    
    lazy var startButton: UIButton = {
        let btn =  button(text: "Πάμε ξανά")
        btn.setTitleColor(MainApp.shared.theme.primaryColor, for: UIControlState.normal)
        btn.isHidden = true
        return btn
    }()
    
    
    lazy var scoreButton: UIButton = {
        let btn =  button(text: "Βαθμολογία")
        btn.isHidden = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        return btn
    }()
    
    lazy var closeButton: UIButton = {
        let btn =  button(text: "✖️")
        btn.isHidden = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.semibold)
        return btn
    }()
    
    fileprivate func rotateBomb() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: M_PI * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = FLT_MAX
        self.bombImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(350)
        }
        view.addSubview(bombImageView)
        bombImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        
        scoreButton.addTarget(self, action: #selector(showScore), for: .touchDown)
        view.addSubview(scoreButton)
        scoreButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(view.safeArea.bottom).offset(-20)
        })
        
        closeButton.addTarget(self, action: #selector(startAgain), for: .touchDown)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(scoreButton.snp.top).offset(8)
        })
        
        
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints({ (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeArea.bottom)
            } else {
                make.top.equalTo(view)
            }
            make.right.equalToSuperview().offset(-8)
            make.width.height.equalTo(24)
        })
        
        
        
        
        startTheGame()
    }
    @objc func showScore() {
        let scoreTable = ScoreTableViewController()
        scoreTable.view.backgroundColor = .white
        scoreTable.mode = "display"
        let navigationController = UINavigationController.init(rootViewController: scoreTable)
        self.present(navigationController, animated: true, completion: {
            
        })
    }
    @objc func startAgain() {
        gameStarted = true
        startButton.isHidden = true
        scoreButton.isHidden = true
        closeButton.isHidden = true
        bombImageView.isHidden = false
        startTheGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    fileprivate func startTheGame() {
        self.bombImageView.image = #imageLiteral(resourceName: "bomb")
        self.cardLabel.text = MainApp.shared.activeGame.getWord().uppercased()
        let index = Int(arc4random_uniform(UInt32(typesOfGame.count)))
        typeOfGameLabel.text = "\(typesOfGame[index] )"
        playSound("tick-tock", "wav", Int(arc4random_uniform(UInt32(15))))
        rotateBomb()

    }

    var player: AVAudioPlayer?
    func playSound(_ name: String, _ ext: String, _ numberOfLoops: Int) {
        guard let url = Bundle.main.url(forResource:name , withExtension:ext)
            else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            player.delegate = self
            player.numberOfLoops = numberOfLoops;
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (gameStarted) {
            startButton.isHidden = false
            scoreButton.isHidden = false
            closeButton.isHidden = false
            gameStarted = false
            playSound("boom", "wav", 0)
            
            self.bombImageView.layer.removeAllAnimations()
            self.bombImageView.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                let scoreTable = ScoreTableViewController()
                scoreTable.view.backgroundColor = .white
                scoreTable.mode = "edit"
                let navigationController = UINavigationController.init(rootViewController: scoreTable)
                self.present(navigationController, animated: true, completion: {
                    
                })
            
            }
            vibratePhone()
//            timer?.invalidate()
            
//            self.getReadyButton.isHidden = false
        }
        
        
    }
    
    func vibratePhone() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
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
