//
//  QuestionCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 03/03/23.
//

import UIKit

class QuestionCell: UITableViewCell, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    lazy var firstButtonSelected: (() -> ())? = nil
    lazy var imageReloadButtonSelected: (() -> ())? = nil
    var setAnswerKeySelected: (() -> ())? = nil
    var imagebtnSelected: ((CreateOptionModel) -> ())? = nil
    var questimagebtnSelected: (() -> ())? = nil
    var addOptionbtnSelected: (() -> ())? = nil
   var optionIndexPath: ((IndexPath) -> ())? = nil
    var optionModelpass: ((CreateOptionModel) -> ())? = nil
    var preViewImageSelected: ((UIImage?, UIButton) -> ())? = nil
    var optionPreViewImageSelected:((UIImage?) -> ())? = nil

    @IBOutlet weak var leftSideBlueView: UIView!
    @IBOutlet weak var questionFieldView: UIView!
    @IBOutlet weak var DividerView: UIView!
    @IBOutlet weak var optionBtnDownDividerView: UIView!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var tabelViewHeightConstrain: NSLayoutConstraint!

    @IBOutlet weak var questImageTableConstrains: NSLayoutConstraint!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var questionImageTabelView: UITableView!
    @IBOutlet weak var questionAddImage: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var setAnswerKey: UIButton!
    @IBOutlet weak var blueRightSideVIew: UIView!
    @IBOutlet weak var addOptionBtn: UIButton!
    var count = 0
    var constrainHeight: CGFloat = 0
    var height: CGFloat = 0
    var programId = ""
    var optionImageConstrainHeight : NSLayoutConstraint?
    lazy var viewModel: SurpriseQuizVM! = SurpriseQuizVM()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tabelViewHeightConstrain.constant = 0
        backView.layer.cornerRadius = 10
        blueRightSideVIew.layer.cornerRadius = 10
        leftSideBlueView.layer.cornerRadius = 10
       // leftSideBlueView.layer.cornerRadius = 10
        if createQuestionModel.questionImageModel.isEmpty{
            questImageTableConstrains.constant = 0
            questionImageTabelView.reloadData()
        }else{
            questImageTableConstrains.constant  = 80
            questionImageTabelView.reloadData()
        }
        optionTableView.delegate = self
        optionTableView.dataSource = self
        questionImageTabelView.delegate = self
        questionImageTabelView.dataSource = self
        questionImageTabelView.separatorStyle = .none
        optionTableView.separatorStyle = .none
        optionTableView.backgroundColor  = .white
        optionTableView.register(UINib(nibName: "OptionViewCell", bundle: nil), forCellReuseIdentifier: "OptionViewCell")
        setAnswerKey.addTarget(self, action: #selector(setAnswerKeyAction), for: .touchUpInside)
        questionImageTabelView.register(UINib(nibName: "QuestionImageViewCell", bundle: nil), forCellReuseIdentifier: "QuestionImageViewCell")
        questionAddImage.addTarget(self, action: #selector(questImageAction), for: .touchUpInside)
       addOptionBtn.addTarget(self, action: #selector(addOptionAction), for: .touchUpInside)
      //  backView.layer
       // tabelView.translatesAutoresizingMaskIntoConstraints = false
        //constrainHeight = 42
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        let prevFrame = self.frame
        self.frame = CGRect(x: 0, y: 0, width: prevFrame.width, height: 1500)
    }
        override func layoutSubviews() {
        super.layoutSubviews()
            questionTextField.delegate = self
        backView.backgroundColor = .clear
            questionImageTabelView.allowsSelection = false
            optionTableView.allowsSelection = false
        contentView.backgroundColor = .clear
              addOptionBtn.roundCorners([.allCorners], radius: 15)
             //  backView.roundCorners([.allCorners], radius: 10)
               questionAddImage.roundCorners([.topRight], radius: 10)
               questionFieldView.roundCorners([.topLeft,.topRight], radius: 10)
            
//             blueRightSideVIew.roundCorners([.topRight,.bottomRight], radius: 10)
      
               backView.backgroundColor = .clear
    }
  
    var createQuestionModel =  CreateQuestionModel()
   // var indexPath: IndexPath!
    
    func configure(model: CreateQuestionModel,programId:String, indexPath: IndexPath) {
        createQuestionModel = model
       // self.indexPath = indexPath
        questionTextField.text = model.text
        questionTextField.delegate = self
        optionTableView.reloadData()
      
        var optionTableHeight: CGFloat = 0//CGFloat(model.options.count * 42)
        for item in model.options {
            var optionHeight: CGFloat = 55
           
            for _ in item.optionImageModel {
                optionHeight += 90
            }
//            height = optionHeight
            optionTableHeight += optionHeight
        }
        
        var imageTableheight: CGFloat = 0
        for item in model.questionImageModel{
            var optionHeight: CGFloat = 100
            for subItem in item.attachments {
                optionHeight += subItem.height
            }
          //  height = optionHeight
            imageTableheight += optionHeight
        }
        
       
        tabelViewHeightConstrain.constant = optionTableHeight
        questImageTableConstrains.constant = imageTableheight
       // optionImageConstrainHeight
        
        optionTableView.reloadData()
        questionImageTabelView.reloadData()
        
    }
  
}
extension QuestionCell: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return optionTableView == tableView ? createQuestionModel.options.count : createQuestionModel.questionImageModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        if optionTableView == tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionViewCell") as! OptionViewCell
            let option = createQuestionModel.options[indexPath.row]
            //optionIndexPath?(indexPath)
           
            cell.optionTextField.text = option.name
            cell.imageConfigure(model: option, indexPath: indexPath)
            //cell.optionTextField.delegate = self
            cell.optionTextField.placeholder = "option-\(indexPath.row + 1)"
            cell.optionImageBtn.addTarget(self, action: #selector(optionImageBtnAction), for: .touchUpInside)
           // viewModel.callBackData(question: createQuestionModel)
            // questionCellTabelView.reloadData()
            cell.optionSelectedbtn.tintColor = option.isSelected ? .green : .black
            cell.optionSelectedbtn.setImage(UIImage(systemName: option.isSelected  ?  "largecircle.fill.circle" : "circle"), for: .normal)
            cell.optionImageXmarkBtnReloadData = {
                tableView.reloadData()
            }
            cell.firstButtonSelected = {  button in
                if self.createQuestionModel.options.count > 2 {
                    self.optionRemove(indexPath: indexPath)
                }
                self.firstButtonSelected?()
                tableView.reloadData()
            }
           // cell.ImageCellTableView.reloadData()
            cell.optionImageBtnSelected = { optionConstrainHeight in
                self.optionImageConstrainHeight = optionConstrainHeight
               cell.ImageCellTableView.reloadData()
                tableView.reloadData()
                self.imagebtnSelected?(option)
            }
            cell.optionSelectedbtnSelected = { button in
                self.viewModel.changeOption(question: self.createQuestionModel, option: option)
                tableView.reloadData()
            }
            cell.optionPreViewImageSelected = { image in
                self.optionPreViewImageSelected?(image)
            }
            return cell
        }
        
        let imgCell = questionImageTabelView.dequeueReusableCell(withIdentifier: "QuestionImageViewCell", for: indexPath) as! QuestionImageViewCell
        imgCell.questImageView.image =  createQuestionModel.questionImageModel[indexPath.row].image
        imgCell.imageXmarkSelected = { btn in
            self.imageRemove(indexPath: indexPath)
            self.imageReloadButtonSelected?()
        }
        imgCell.preViewImageSelected = { image ,button in
            self.preViewImageSelected?(image, button)
        }
        return imgCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       questionTextField.resignFirstResponder()
    }
    
    func optionRemove(indexPath: IndexPath){
    
        createQuestionModel.options.remove(at: indexPath.row)
            optionTableView.reloadData()
     
    }
    func imageRemove(indexPath: IndexPath){
        createQuestionModel.questionImageModel.remove(at: indexPath.row)
        questionImageTabelView.reloadData()
    }
  
}

extension QuestionCell:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == questionTextField {
           // textField.resignFirstResponder()
            let textFieldText: NSString = textField.text! as NSString
            let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            createQuestionModel.text = txtAfterUpdate
          
            
        }
      
          return true

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        questionTextField.resignFirstResponder()
        return false
    }
}



extension QuestionCell {
    
    @objc func  optionImageBtnAction(_ sender: UIButton){
      
    }
    
    @objc func setAnswerKeyAction(_ sender: UIButton){
        setAnswerKeySelected?()
        questionTextField.resignFirstResponder()
    
    }
    
    @objc func questImageAction(){
        questimagebtnSelected?()
       
        
    }
    @objc func addOptionAction(){
        addOptionbtnSelected?()
       
        
    }
    
}


extension QuestionCell{
   
    func setConstraina(){
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            leftSideBlueView.topAnchor.constraint(equalTo: backView.topAnchor,constant: 10),
            leftSideBlueView.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            leftSideBlueView.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: 10),
            leftSideBlueView.widthAnchor.constraint(equalToConstant: 5 ),
            
            blueRightSideVIew.leadingAnchor.constraint(equalTo: leftSideBlueView.trailingAnchor),
            blueRightSideVIew.topAnchor.constraint(equalTo: backView.topAnchor,constant: 10),
            blueRightSideVIew.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: 10),

            blueRightSideVIew.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            
            questionFieldView.topAnchor.constraint(equalTo: blueRightSideVIew.topAnchor,constant: 5),
            questionFieldView.leadingAnchor.constraint(equalTo: blueRightSideVIew.leadingAnchor,constant: 5),
            questionFieldView.trailingAnchor.constraint(equalTo: blueRightSideVIew.trailingAnchor,constant: -5),
            questionFieldView.heightAnchor.constraint(equalToConstant: 50),
            
            questionTextField.topAnchor.constraint(equalTo: questionFieldView.topAnchor,constant: 5),
            questionTextField.leadingAnchor.constraint(equalTo: questionFieldView.leadingAnchor,constant: 5),
            questionTextField.bottomAnchor.constraint(equalTo: questionFieldView.bottomAnchor,constant: 5),
            questionTextField.trailingAnchor.constraint(equalTo: questionAddImage.leadingAnchor,constant: 10),
            
            questionAddImage.topAnchor.constraint(equalTo: questionFieldView.topAnchor,constant: 6),
            questionAddImage.trailingAnchor.constraint(equalTo: questionFieldView.trailingAnchor,constant: -10),
            
            DividerView.topAnchor.constraint(equalTo: questionFieldView.bottomAnchor,constant: 5),
            DividerView.leadingAnchor.constraint(equalTo: blueRightSideVIew.leadingAnchor),
            DividerView.trailingAnchor.constraint(equalTo: blueRightSideVIew.trailingAnchor),
            
            optionTableView.topAnchor.constraint(equalTo: DividerView.bottomAnchor,constant: 5),
            optionTableView.leadingAnchor.constraint(equalTo: blueRightSideVIew.leadingAnchor),
            optionTableView.trailingAnchor.constraint(equalTo: blueRightSideVIew.trailingAnchor),
            optionTableView.heightAnchor.constraint(equalToConstant: CGFloat(constrainHeight)),
            
            addOptionBtn.topAnchor.constraint(equalTo: optionTableView.bottomAnchor,constant: 5),
            addOptionBtn.leadingAnchor.constraint(equalTo: blueRightSideVIew.leadingAnchor,constant: 5),
            addOptionBtn.heightAnchor.constraint(equalToConstant: 35),
            
            optionBtnDownDividerView.topAnchor.constraint(equalTo: addOptionBtn.bottomAnchor,constant: 7),
            optionBtnDownDividerView.leadingAnchor.constraint(equalTo: blueRightSideVIew.leadingAnchor),
            optionBtnDownDividerView.trailingAnchor.constraint(equalTo: blueRightSideVIew.trailingAnchor),
            
            setAnswerKey.topAnchor.constraint(equalTo: optionBtnDownDividerView.bottomAnchor, constant: 20),
            setAnswerKey.leadingAnchor.constraint(equalTo: blueRightSideVIew.leadingAnchor,constant: 10),
            setAnswerKey.bottomAnchor.constraint(equalTo: blueRightSideVIew.bottomAnchor,constant: 10),
            setAnswerKey.heightAnchor.constraint(equalToConstant: 45),
            
            plusBtn.topAnchor.constraint(equalTo: optionBtnDownDividerView.bottomAnchor,constant: 10),
            plusBtn.trailingAnchor.constraint(equalTo: copyBtn.leadingAnchor),
            plusBtn.bottomAnchor.constraint(equalTo: blueRightSideVIew.bottomAnchor, constant: -10),
            
            copyBtn.topAnchor.constraint(equalTo: optionBtnDownDividerView.bottomAnchor,constant: 10),
            copyBtn.trailingAnchor.constraint(equalTo: deleteBtn.leadingAnchor),
            copyBtn.bottomAnchor.constraint(equalTo: blueRightSideVIew.bottomAnchor, constant: -10),
            
            deleteBtn.topAnchor.constraint(equalTo: optionBtnDownDividerView.bottomAnchor,constant: 10),
            
            deleteBtn.trailingAnchor.constraint(equalTo: blueRightSideVIew.trailingAnchor, constant: -10),
            deleteBtn.bottomAnchor.constraint(equalTo: blueRightSideVIew.bottomAnchor, constant: -10),
            
            
            
            
            
            
            
            
            
            
        
        ])
    }
}





//  blueRightSideVIew.roundCorners([.topRight,.bottomRight], radius: 10)
//               leftSideBlueView.roundCorners([.topLeft,.bottomLeft], radius: 30)
//        leftSideBlueView.translatesAutoresizingMaskIntoConstraints = false
//        tabelView.translatesAutoresizingMaskIntoConstraints = false
//        questionFieldView.translatesAutoresizingMaskIntoConstraints = false
//        DividerView.translatesAutoresizingMaskIntoConstraints = false
//        optionBtnDownDividerView.translatesAutoresizingMaskIntoConstraints = false
//        backView.translatesAutoresizingMaskIntoConstraints = false
//        questionTextField.translatesAutoresizingMaskIntoConstraints = false
//        questionAddImage.translatesAutoresizingMaskIntoConstraints = false
//        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
//        copyBtn.translatesAutoresizingMaskIntoConstraints = false
//        plusBtn.translatesAutoresizingMaskIntoConstraints = false
//        setAnswerKey.translatesAutoresizingMaskIntoConstraints = false
//       blueRightSideVIew.translatesAutoresizingMaskIntoConstraints = false
//        addOptionBtn.translatesAutoresizingMaskIntoConstraints = false
//
//        setConstraina()
