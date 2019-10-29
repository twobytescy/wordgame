//
//  GetReadyViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 30/12/2017.
//  Copyright © 2017 Stelios Ioannou. All rights reserved.
//

import UIKit
import CoreData

class GetReadyViewController: UIViewController {
    
     let appDelegate =
        UIApplication.shared.delegate as! AppDelegate
    
    func getActiveGame() -> NSManagedObject {
        return appDelegate.games.last!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.performSegue(withIdentifier: "playSegue", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let game = getActiveGame()
        let gameVC =  segue.destination as! ViewController
        
        let cards =  game.value(forKeyPath: "cards") as? [NSManagedObject]
        
        let card = cards?[appDelegate.currentCard]
        appDelegate.currentCard = appDelegate.currentCard + 1
        
        let cardLetters = card?.value(forKeyPath: "letters") as! String
        gameVC.letters = cardLetters
        // Pass the selected object to the new view controller.
    }
    

}
