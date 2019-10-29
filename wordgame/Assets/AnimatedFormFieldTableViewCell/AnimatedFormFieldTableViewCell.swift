//
//  AnimatedFormFieldTableViewCell.swift
//  AnimatedFormFieldTableViewCell
//
//  Created by Zaltzberg, Ido on 25/07/2016.
//  Copyright © 2016 Intuit. All rights reserved.
//
import UIKit

class FormFieldTableViewCell: UITableViewCell, UITextFieldDelegate {
    var delegate: UITextFieldDelegate?
    var scaledLabelMode = false
    
    lazy var textField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "test"
        return tf
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
  
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        return delegate?.textField?(textField, shouldChangeCharactersInRange: range, replacementString: string) ?? true
//    }
//
}
