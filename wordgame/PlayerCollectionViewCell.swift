//
//  PlayerCollectionViewCell.swift
//  wordgame
//
//  Created by Stelios Ioannou on 30/12/2017.
//  Copyright © 2017 Stelios Ioannou. All rights reserved.
//

import UIKit
import PureLayout
import CoreData

class PlayerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var letterLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func doIt(_ player: NSManagedObject){
        
        let view = UIView.init()
        self .addSubview(view)
        view.backgroundColor = .lightGray
        
        let nsLabel = UILabel.init()
        view .addSubview(nsLabel)
        view.layer.cornerRadius = 30
        
        var wordsArray = (player.value(forKeyPath: "name") as? String)?.split(separator: " ")
        var letters = ""
        for string in wordsArray! {
            letters.append(String(string.characters.first!))
        }
        
        nsLabel.text = letters.uppercased()
        nsLabel.font = UIFont.systemFont(ofSize: 30)
        nsLabel.textAlignment = .center
        nsLabel.autoPinEdge(toSuperviewEdge: .left)
        nsLabel.autoPinEdge(toSuperviewEdge: .right)
        nsLabel.autoPinEdge(toSuperviewEdge: .bottom)
        nsLabel.autoPinEdge(toSuperviewEdge: .top)
        
        
        let label = UILabel.init()
        self .addSubview(label)
        
        label.textAlignment = .center
        
        label.autoPinEdge(toSuperviewEdge: .left)
        label.autoPinEdge(toSuperviewEdge: .right)
        label.autoPinEdge(toSuperviewEdge: .bottom)
        label.autoSetDimension(.height, toSize: 15)
        
        view.autoPinEdge(toSuperviewEdge: .left)
        view.autoPinEdge(toSuperviewEdge: .right)
        view.autoPinEdge(toSuperviewEdge: .top)
        view.autoPinEdge(.bottom, to: .top, of: label)
        
        label.text = player.value(forKeyPath: "name") as? String
    }
    override func prepareForReuse() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
