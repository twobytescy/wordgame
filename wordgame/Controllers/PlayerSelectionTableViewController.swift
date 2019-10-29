//
//  PlayersTableViewController.swift
//  wordgame
//
//  Created by Stelios Ioannou on 14/11/2018.
//  Copyright © 2018 Stelios Ioannou. All rights reserved.
//

import UIKit

class PlayerSelectionTableViewController: UITableViewController, UITextFieldDelegate {

    var numberOfPlayers: Int = 0
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = MainApp.shared.theme.primaryColor
        button.setTitle("ΣΥΝΕΧΕΙΑ", for: UIControlState.normal)
        button.setTitleColor(.white, for: UIControlState.normal)
        button.layer.cornerRadius = 6
        button.addTargetClosure(closure: { (button) in
            self.setDefaultNamesForUnassignedPlayers()
            let playerSelectionController = TheGameViewController()
            playerSelectionController.view.backgroundColor = .white
            self.show(playerSelectionController, sender: self)
        })
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeArea.bottom).offset(-8)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(55)
            make.width.equalToSuperview().offset(-32)
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setDefaultNamesForUnassignedPlayers() {
        for i in 0...numberOfPlayers - 1 {
            if MainApp.shared.activeGame.players?.first(where: { (player) -> Bool in
                return player.id == String(i)
            }) == nil
            {
                let activePlayer = ActivePlayer()
                activePlayer.id = String(i)
                activePlayer.name =  String("Πάιχτης \(String(i + 1))")
                MainApp.shared.activeGame.players?.append(activePlayer)
            }
        }
    }
    func registerTableViewCells(){
        tableView.register(FormFieldTableViewCell.self, forCellReuseIdentifier: "FormFieldTableViewCell")         // register cell name

    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfPlayers
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "FormFieldTableViewCell") as? FormFieldTableViewCell {
            cell.textField.tag = indexPath.row
            cell.textField.placeholder = "Πάιχτης \(String(indexPath.row + 1))"
            cell.textField.delegate = self
            return cell
        }
        return UITableViewCell()

        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let activePlayer = MainApp.shared.activeGame.players?.filter({ (player) -> Bool in
            return player.id == String(textField.tag)
        }).first
        {
            activePlayer.name = textField.text
        }
        else {
            let activePlayer = ActivePlayer()
            activePlayer.id = String(textField.tag)
            activePlayer.name = textField.text
            MainApp.shared.activeGame.players?.append(activePlayer)
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
