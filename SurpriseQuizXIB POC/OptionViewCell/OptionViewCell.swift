//
//  OptionViewCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 03/03/23.
//

import UIKit

class OptionViewCell: UITableViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    lazy var firstButtonSelected: ((UIButton) -> ())? = nil
    lazy var optionImageBtnSelected: ((NSLayoutConstraint) -> ())? = nil
    lazy var optionSelectedbtnSelected: ((UIButton) -> ())? = nil
    lazy var callMyMethod: ((String) -> ())? = nil
    lazy var passImagePicker: ((UIImagePickerController) -> ())? = nil
    lazy var optionImageXmarkBtnReloadData: (() -> ())? = nil
    var optionPreViewImageSelected:((UIImage?) -> ())? = nil
    var questionImageIndexPath: ((IndexPath) -> ())?
    var height: CGFloat = 0
    @IBOutlet weak var optionSelectedbtn: UIButton!
    
    @IBOutlet weak var optionTextField: UITextField!
    @IBOutlet weak var optionImageBtn: UIButton!
    @IBOutlet weak var optionXmarkBtn: UIButton!
    @IBOutlet weak var ImageCellTableView: UITableView!
    
    @IBOutlet weak var optionImageTableViewConstrainHeight: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    var indexpath = IndexPath()
    var options: CreateOptionModel?
    override func awakeFromNib() {
        super.awakeFromNib()
       // optionImageTableViewConstrainHeight.constant = 80
       
        optionTextField.delegate = self
        ImageCellTableView.register(UINib(nibName: "ImageViewCell", bundle: nil), forCellReuseIdentifier: "ImageViewCell")
        if ((options?.optionImageModel.isEmpty) != nil){
            optionImageTableViewConstrainHeight.constant = 80
            ImageCellTableView.reloadData()
        }else{
            optionImageTableViewConstrainHeight.constant  = 0
            ImageCellTableView.reloadData()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        optionTextField.delegate = self
        ImageCellTableView.allowsSelection = false
       // imagePicker.delegate = self
        //imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        ImageCellTableView.delegate = self
        ImageCellTableView.dataSource = self
        ImageCellTableView.separatorStyle = .none
      
        optionXmarkBtn.addTarget(self, action: #selector(optionXmarkBtnAction), for: .touchUpInside)
        optionImageBtn.addTarget(self, action: #selector(optionImageBtnAction), for: .touchUpInside)
        //  optionSelectedbtn.addTarget(self, action: #selector(optionSelectedbtnAction), for: .touchUpInside)
        optionSelectedbtn.addTarget(self, action: #selector(optionSelectedbtnAction), for: .touchUpInside)
        contentView.backgroundColor = .clear
   
        
    }
    
    func configure(model: CreateOptionModel,programId:String, indexPath: IndexPath) {
        options = model
        optionTextField.text = model.name
    }
    func imageConfigure(model: CreateOptionModel, indexPath: IndexPath) {
        options = model
       // options?.optionImageModel = model.optionImageModel.
        var optionImageHeight: CGFloat = 0
        for item in model.optionImageModel{
            var optionHeight: CGFloat = 90
            for subItem in item.attachments1{
                optionHeight += subItem.height
            }
            height = optionHeight
            optionImageHeight += height
       
        }
        
      optionImageTableViewConstrainHeight.constant = optionImageHeight
        ImageCellTableView.reloadData()
    }
}

extension OptionViewCell: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(options?.optionImageModel.count)
        return (options?.optionImageModel.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ImageCellTableView.dequeueReusableCell(withIdentifier: "ImageViewCell", for: indexPath) as! ImageViewCell

        // cell.optionImageBtnSelected = { btn in
        cell.imgview.image =  self.options?.optionImageModel[indexPath.row].image
        cell.optionImageXmarkBtnSelected = {
            self.options?.optionImageModel.remove(at: indexPath.row)
            self.optionImageXmarkBtnReloadData?()
            self.ImageCellTableView.reloadData()
        }
        cell.optionPreViewImageSelected = { image in
            self.optionPreViewImageSelected?(image)
        }
        return cell
    }
    
 
}

extension OptionViewCell{
    
    @objc func  optionXmarkBtnAction(_ sender: UIButton){
        firstButtonSelected?(sender)
    }
    @objc func  optionImageBtnAction(){
        
        optionImageBtn.setTitleColor(.blue, for: .normal)
        optionImageBtnSelected?(optionImageTableViewConstrainHeight)
       // passImagePicker?(imagePicker)
    }
    
    @objc func  optionSelectedbtnAction(_ sender: UIButton){
        optionSelectedbtnSelected?(sender)
    }
}
    
extension OptionViewCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == optionTextField{
            
            let textFieldText: NSString = textField.text! as NSString
            let optionAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            options?.name = optionAfterUpdate
        }
         
        return true// createQuestionModel.options[indexPath.row].name = optionAfterUpdate
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        optionTextField.resignFirstResponder()
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        optionTextField.resignFirstResponder()
    }
    }

