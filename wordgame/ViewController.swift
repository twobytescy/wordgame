//
//  ViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 30/12/2017.
//  Copyright © 2017 Stelios Ioannou. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import CoreData

class ViewController: UIViewController,AVAudioPlayerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    @IBOutlet weak var bombImageView: UIImageView!
    @IBOutlet weak var typeOfGame: UILabel!
    var typesOfGame = ["ΟΧΙ ΣΤΗΝ ΑΡΧΗ","ΟΧΙ ΣΤΟ ΤΕΛΟΣ","ΠΑΝΤΟΥ ΣΤΗΝ ΛΕΞΗ"]
    var letters : String = ""
    var pickerView : UIPickerView?
    var gameStarted : Bool = false
    @IBOutlet weak var lettersLabel: UILabel!
    var counter = 0
    var timer : Timer?
    
    @IBAction func getReadyButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "getReadySegue", sender: self);
    }
    fileprivate func rotateBomb() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: M_PI * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = FLT_MAX
        self.bombImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    fileprivate func startTheGame() {
        self.bombImageView.image = #imageLiteral(resourceName: "bomb")
        self.getReadyButton.isHidden = true
        self.lettersLabel.text = letters
        let index = Int(arc4random_uniform(UInt32(typesOfGame.count)))
        self.typeOfGame.text = "\(typesOfGame[index] )"
    }
    
    @IBOutlet weak var getReadyButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startTheGame()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        gameStarted = true;
        playSound("tick-tock", "wav",Int(arc4random_uniform(UInt32(15))))
        
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
    fileprivate func showPopover() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView?.delegate = self
        pickerView?.dataSource = self
        vc.view.addSubview(pickerView!)
        let editRadiusAlert = UIAlertController(title: "Χαμένος;", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: updateScore))
        self.present(editRadiusAlert, animated: true)
    }
    func updateScore(alert: UIAlertAction!) {
        let position = pickerView!.selectedRow(inComponent: 0)
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        
        let players =  appDelegate?.games.last!.value(forKeyPath: "players") as? [NSManagedObject]
        
        let player =  players![position];
        var currentPlayerScore = player.value(forKeyPath: "points") as! Int
        currentPlayerScore = currentPlayerScore + 1
        player.setValue(currentPlayerScore, forKey: "points")
        
        getReadyButton.isHidden = false;
        
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (gameStarted) {
            gameStarted = false
            playSound("boom", "wav", 0)
            self.bombImageView.layer.removeAllAnimations()
            self.bombImageView.isHidden = true
            
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.showPopover()
            }
            vibratePhone()
            timer?.invalidate()
            
            self.getReadyButton.isHidden = false
        }
        
        
    }
    
    func vibratePhone() {
       
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
       
    }
    
    @IBAction func vibrate(sender: UIButton) {
        counter = 0
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: "vibratePhone", userInfo: nil, repeats: true)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
       appDelegate?.games.last!
        
        let players =  appDelegate?.games.last!.value(forKeyPath: "players") as? [NSManagedObject]
        
        return players!.count
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
        
        let players =  appDelegate?.games.last!.value(forKeyPath: "players") as? [NSManagedObject]
        
        let player =  players![row];
        var currentPlayerScore = player.value(forKeyPath: "points") as! Int
        return "\(player.value(forKeyPath: "name") as! String) (\(currentPlayerScore))";
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

