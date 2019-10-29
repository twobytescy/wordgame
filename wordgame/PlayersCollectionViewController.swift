//
//  PlayersCollectionViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 30/12/2017.
//  Copyright © 2017 Stelios Ioannou. All rights reserved.
//

import UIKit
import CoreData
import GameplayKit


private let reuseIdentifier = "PCVCidentifier"

class PlayersCollectionViewController: UICollectionViewController {
    var players: [NSManagedObject] = []
    let vc = PlayerViewController()
    var isChanged : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        getSavedPlayers()
        self.title = "Παίχτες";
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addPlayerButtonTapped(_ sender: Any) {
        showPopover()
    }
    
    fileprivate func showPopover() {
        
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        //let name = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        
        //vc.view.addSubview(name)
        let editRadiusAlert = UIAlertController(title: "Παιχτη", message: "", preferredStyle: UIAlertControllerStyle.alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: addPlayer))
        self.present(editRadiusAlert, animated: true)
    }
    
    func addPlayer(alert: UIAlertAction!) {
        isChanged = true
        save(name: vc.nameTextField.text!)
        self.collectionView?.reloadData()
        
    }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Player",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        person.setValue(0, forKeyPath: "points")
        
        // 4
        do {
            try managedContext.save()
            players.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getSavedPlayers(){
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        if let game = appDelegate.activeGame
        {
            players = game.value(forKeyPath: "players") as! [NSManagedObject]
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        
        
        if let playerCell = cell as? PlayerCollectionViewCell {
            let player = players[indexPath.row]
            playerCell.doIt(player)
            return playerCell
        }
        
        
        cell.backgroundColor = .red
        return cell
    }
    
    
    
    func createGame()
    {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Game",
                                       in: managedContext)!
        
        let game = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        // 3
        game.setValue(players, forKeyPath: "players")
        game.setValue(0, forKeyPath: "id")
        game.setValue(createCards(),forKeyPath: "cards")
        
        // 4
        do {
            try managedContext.save()
            appDelegate.games.append(game)
            appDelegate.activeGame = game
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func createCards() -> [NSManagedObject]
    {
        let sample = ["αρβα",
                      "λουσ",
                      "ροεκ",
                      "υνεπ",
                      "αντα",
                      "αραμ",
                      "ελι",
                      "εντρ",
                      "ποθη",
                      "ε",
                      "πηχη",
                      "αθμο",
                      "κριδ",
                      "απει",
                      "κοη",
                      "ρρώσ",
                      "νακα",
                      "υνορ",
                      "ριφο",
                      "κτασ",
                      "πριζ",
                      "ετοι",
                      "ρόοδ",
                      "αλιν",
                      "α",
                      "αβα",
                      "αβαρ",
                      "αβη",
                      "αβιδ",
                      "αβυρ",
                      "αβών",
                      "αγαν",
                      "αγαρ",
                      "αγκα",
                      "αγκα",
                      "αγκα",
                      "αγκε",
                      "αγνε",
                      "αγνό",
                      "αγνο",
                      "αγοκ",
                      "αγοκ",
                      "αγόν",
                      "αγόπ",
                      "αγός",
                      "αγου",
                      "αγων",
                      "αγωό",
                      "αδερ",
                      "αδης",
                      "αδι",
                      "αδι",
                      "αδι ",
                      "αδιν",
                      "αδο-",
                      "αδωμ",
                      "αδών",
                      "αθεμ",
                      "αθος",
                      "αθος",
                      "αθος",
                      "αθρα",
                      "αθρα",
                      "αθρε",
                      "αθρε",
                      "αθρε",
                      "αθρο",
                      "αθρο",
                      "αθρο",
                      "αιδη",
                      "αικη",
                      "αικη",
                      "αικη",
                      "αικη",
                      "αικη",
                      "αικι",
                      "αικι",
                      "αικό",
                      "αιλα",
                      "αιμα",
                      "αιμα",
                      "αιμα",
                      "αιμη",
                      "αιμη",
                      "αιμό",
                      "αιμο",
                      "αιμο",
                      "αιμό",
                      "αιμο",
                      "αιστ",
                      "ακ",
                      "ακα",
                      "ακεδ",
                      "ακε",
                      "ακκα",
                      "ακκο",
                      "ακκο",
                      "ακκο",
                      "ακων",
                      "ακων",
                      "ακων",
                      "αλια",
                      "αλισ",
                      "αλώ",
                      "αμα",
                      "αμαρ",
                      "αμβα",
                      "αμβα",
                      "αμβα",
                      "αμβα",
                      "αμβδ",
                      "αμδα",
                      "αμδα",
                      "αμε",
                      "αμνα",
                      "αμπα",
                      "αμπα",
                      "αμπα",
                      "αμπα",
                      "αμπα",
                      "αμπε",
                      "αμπι",
                      "αμπο",
                      "αμπρ",
                      "αμπρ",
                      "αμπρ",
                      "αμπτ",
                      "αμπυ",
                      "αμπω",
                      "αμψη",
                      "ανδα",
                      "ανθα",
                      "ανθα",
                      "ανθα",
                      "ανθα",
                      "ανθα",
                      "ανκα",
                      "ανολ",
                      "ανσα",
                      "αντζ",
                      "αντι",
                      "αξεμ",
                      "αξευ",
                      "αξευ",
                      "αξευ",
                      "αο",
                      "αογρ",
                      "αός",
                      "αος",
                      "αουτ",
                      "απαθ",
                      "απατ",
                      "απιν",
                      "απων",
                      "απων",
                      "αρδι",
                      "αριξ",
                      "αρισ",
                      "αρισ",
                      "αρνα",
                      "αρυγ",
                      "αρυγ",
                      "αρυγ",
                      "αρυγ",
                      "ασκα",
                      "ασκο",
                      "ασο",
                      "ασπη",
                      "ασπο",
                      "ασπό",
                      "ασπώ",
                      "ασπω",
                      "ασπώ",
                      "ασπω",
                      "αστι",
                      "αστι",
                      "αστι",
                      "αστι",
                      "αταν",
                      "ατιν",
                      "ατιν",
                      "ατιν",
                      "ατιν",
                      "ατιν",
                      "ατιν",
                      "ατιν",
                      "ατιφ",
                      "ατομ",
                      "ατρε",
                      "ατρε",
                      "ατρε",
                      "ατρη",
                      "αυρα",
                      "αυρε",
                      "αφυρ",
                      "αφυρ",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχαν",
                      "αχει",
                      "αχνό",
                      "αχτα",
                      "αχτα",
                      "αχτα",
                      "εiος",
                      "εαιν",
                      "εβαν",
                      "εβαν",
                      "εβεν",
                      "εβητ",
                      "εβιε",
                      "εβιθ",
                      "εγαμ",
                      "εγετ",
                      "εγεώ",
                      "εγομ",
                      "εγόμ",
                      "εγω",
                      "εζαν",
                      "εηζε",
                      "εηλα",
                      "εηλα",
                      "εια",
                      "ειαι",
                      "ειαν",
                      "ειβα",
                      "ειζε",
                      "ειμα",
                      "ειος",
                      "ειπε",
                      "ειπω",
                      "ειρι",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειτο",
                      "ειχη",
                      "ειχη",
                      "ειχω",
                      "ειψα",
                      "ειψα",
                      "ειψα",
                      "ειψό",
                      "εκαν",
                      "εκαν",
                      "εκαν",
                      "εκε",
                      "εκια",
                      "εκτο",
                      "εκτω",
                      "ελεκ",
                      "εμβο",
                      "εμβο",
                      "εμεσ",
                      "εμον",
                      "εμόν",
                      "εμον",
                      "εμφι",
                      "εμφο",
                      "εμφο",
                      "εμφο",
                      "ενε",
                      "εξη",
                      "εξικ",
                      "εξικ",
                      "εξικ",
                      "εξικ",
                      "εξικ",
                      "εξιλ",
                      "εξιπ",
                      "εοντ",
                      "εοντ",
                      "εοντ",
                      "εοπα",
                      "εόπα",
                      "εουβ",
                      "επι",
                      "επιδ",
                      "επιδ",
                      "επιδ",
                      "επρα",
                      "επτα",
                      "επτε",
                      "επτό",
                      "επτό",
                      "επτο",
                      "επτο",
                      "επτο",
                      "επτο",
                      "επτο",
                      "επτο",
                      "επτο",
                      "επτό",
                      "επτο",
                      "επτό",
                      "επτο",
                      "επτό",
                      "ερος",
                      "ερωμ",
                      "ερών",
                      "ερών",
                      "εκ",
                      "εσβι",
                      "εσβο",
                      "εσι",
                      "εσόθ",
                      "εστι",
                      "εστι",
                      "εσχη",
                      "εσχη",
                      "εσχη",
                      "ετε ",
                      "ετε",
                      "ετε",
                      "ετον",
                      "ετον",
                      "ετον",
                      "ετον",
                      "ετσο",
                      "ετσο",
                      "εττο",
                      "εττο",
                      "εττο",
                      "ευιτ",
                      "ευκα",
                      "ευκα",
                      "ευκα",
                      "ευκα",
                      "ευκα",
                      "ευκα",
                      "ευκη",
                      "ευκη",
                      "ευκι",
                      "ευκό",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκο",
                      "ευκό",
                      "ευκό",
                      "ευκο",
                      "ευκο",
                      "ευκό",
                      "ευκπ",
                      "ευκω",
                      "ευκω",
                      "ευκω",
                      "ευκω",
                      "ευκω",
                      "ευτε",
                      "ευχα",
                      "εφτα",
                      "εω",
                      "εων",
                      "εων",
                      "εωφο",
                      "εωφο",
                      "εωφο",
                      "εωφο",
                      "εωφό",
                      "ηγου",
                      "ηγω",
                      "ηδα",
                      "ηθαρ",
                      "ηθη",
                      
                      "ημμα",
                      "ημμα",
                      "ηξη",
                      "ηξια",
                      "ηξιπ",
                      "ηπτη",
                      "ησμο",
                      "ηστε",
                      "ηστε",
                      "ηστη",
                      "ηστρ",
                      "ηψη",
                      "ιαζο",
                      "ιακα",
                      "ιανα",
                      "ιανι",
                      "ιανι",
                      "ιβαδ",
                      "ιβαδ",
                      "ιβαν",
                      "ιβαν",
                      "ιβαν",
                      "ιβαν",
                      "ιβελ",
                      "ιβελ",
                      "ιβελ",
                      "ιβερ",
                      "ιβερ",
                      "ιβερ",
                      "ιβιδ",
                      "ιβρα",
                      "ιβρε",
                      "ιβυη",
                      "ιβυκ",
                      "ιβυο",
                      "ιγα",
                      
                      "ιγε",
                      "ιγηρ",
                      "ιγνι",
                      "ιγνι",
                      "ιγνό",
                      "ιγο",
                      "ιγο ",
                      "ιγοι",
                      "ιγόλ",
                      "ιγομ",
                      "ιγος",
                      "ιγοσ",
                      "ιγοσ",
                      "ιγότ",
                      "ιγότ",
                      "ιγου",
                      "ιγου",
                      "ιγου",
                      "ιγών",
                      "ιγών",
                      "ιθιο",
                      "ιθοβ",
                      "ιθογ",
                      "ιθογ",
                      "ιθογ",
                      "ιθοδ",
                      "ιθος",
                      "ιθοσ",
                      "ιθόσ",
                      "ιθόσ",
                      "ιθου",
                      "ιθου",
                      "ιθου",
                      "ιθου",
                      "ιθρι",
                      "ιθών",
                      "ικερ",
                      "ικνι",
                      "ικνι",
                      "ικνι",
                      "ικνο",
                      "ιλα",
                      "ιμα",
                      "ιμαν",
                      "ιμαν",
                      "ιμαρ",
                      "ιμαρ",
                      "ιμασ",
                      "ιμβο",
                      "ιμεν",
                      "ιμεν",
                      "ιμνα",
                      "ιμνα",
                      "ιμνη",
                      "ιμνη",
                      "ιμνο"]
        
        let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: sample)
        
        var cards: [NSManagedObject] = []
        
        for lettersString in shuffled {
            var lettersStringS  = ""
            if (lettersString as! String).count > 2 {
                
                let lower : UInt32 = 2
                let upper : UInt32 = 3
                let randomNumber = arc4random_uniform(upper - lower) + lower
                
                lettersStringS = (lettersString as! String).substring(to: String.Index.init(encodedOffset: Int(randomNumber)))
            }
            else
            {
                lettersStringS = lettersString as! String
            }
            
            
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return []
            }
            
            
            
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            // 2
            let entity =
                NSEntityDescription.entity(forEntityName: "Card",
                                           in: managedContext)!
            
            let card = NSManagedObject(entity: entity,
                                       insertInto: managedContext)
            
            
            card.setValue(lettersStringS.uppercased() , forKeyPath: "letters")
            card.setValue(0, forKeyPath: "id")
            
            // 4
            do {
                try managedContext.save()
                cards.append(card)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        return cards
    }
    @IBAction func startGame(_ sender: Any) {
        if (isChanged) {
            createGame()
        }
        self.dismiss(animated: true) {
        }
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
fileprivate let itemsPerRow: CGFloat = 3
fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

extension PlayersCollectionViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

