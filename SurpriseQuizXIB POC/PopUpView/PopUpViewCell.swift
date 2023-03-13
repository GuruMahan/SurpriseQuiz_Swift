//
//  PopUpViewCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 07/03/23.
//

import UIKit

class PopUpViewCell: UITableViewCell {

    @IBOutlet weak var optionSelectedBtn: UIButton!
    @IBOutlet weak var optionTextfield: UITextField!
    var popUpViewOptionBtnSelected:((UIButton)->())?
    var option: CreateOptionModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        optionTextfield.delegate = self
       optionSelectedBtn.addTarget(self, action: #selector(setAnswerKeyAction), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(model: CreateOptionModel) {
        option = model
        optionSelectedBtn.setImage(UIImage(systemName:  option!.isAnswer  ? "largecircle.fill.circle" : "circle"), for: .normal)
       optionSelectedBtn.tintColor = option!.isAnswer ? .green : .black
       
        //optionSelectedBtn.setImage(UIImage(systemName: model.isAnswer ? "largecircle.fill.circle" : "largecircle.fill.circle") , for: .normal)
    }
    
    @objc func setAnswerKeyAction(_ sender: UIButton){
     
        popUpViewOptionBtnSelected?(sender)
      
       // popUpViewchangeOption(option: answerKey?.options)
    }
}

extension PopUpViewCell: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        optionTextfield.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.contentView.endEditing(true)
           return false
       }
}
