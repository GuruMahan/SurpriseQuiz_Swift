//
//  AddQuestionViewCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 04/03/23.
//

import UIKit

class AddQuestionViewCell: UITableViewCell {

    @IBOutlet weak var addNewBtn: UIButton!
   
    override func layoutSubviews() {
        super.layoutSubviews()
        addNewBtn.roundCorners([.allCorners], radius: 10)
      contentView.backgroundColor = .clear
//        addNewBtn.backgroundColor = UIColor(hexString: "#E1F5FA")
    }
    
    
}
