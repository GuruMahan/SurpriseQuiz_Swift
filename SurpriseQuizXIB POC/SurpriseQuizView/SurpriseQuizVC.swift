//
//  SurpriseQuizVC.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 03/03/23.
//

import UIKit

class SurpriseQuizVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var firstButtonSelected: (() -> ())? = nil
    var optionIndexPath: ((IndexPath) -> ())? = nil
    var optindexPath = IndexPath()
    var viewModel = SurpriseQuizVM()
    @IBOutlet weak var imageHeaderView: UIView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var questionTitleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var questionTitleTextField: UITextField!
    @IBOutlet weak var backArrowBtn: UIButton!
    @IBOutlet weak var SurpQuizTableView: UITableView!
    
    var programId:String = ""
    var options:CreateOptionModel?
    
    lazy var imagePreView: UIView! = {
        var imageView = UIView()
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var popUpPreViewImageView: UIImageView! = {
        var imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var popUpXmarkBtn: UIButton! = {
        var Button = UIButton()
        Button.backgroundColor = .white
        Button.setImage(UIImage(named: "xmarkImg"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        Button.addTarget(self, action: #selector(popUpXmarkBtnAction), for: .touchUpInside)
        return Button
    }()
    
    var questionCount = 0
    var createQuestionModel: CreateQuestionModel?
    let imagePicker1 = UIImagePickerController()
    
    //MARK: -> viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imagePreView)
        imagePreView.addSubview(popUpPreViewImageView)
        imagePreView.addSubview(popUpXmarkBtn)
        questionTitleTextField.delegate = self
        self.imagePicker1.delegate = self
        self.imagePicker1.sourceType = .photoLibrary
        SurpQuizTableView.allowsSelection = false
        //createQuestionModel  // cancelBtn.roundCorners([.allCorners], radius: 20)
        cancelBtn.layer.borderWidth = 1
        cancelBtn.layer.cornerRadius = 20
        cancelBtn.layer.borderColor =  UIColor.tintColor.cgColor
        SurpQuizTableView.delegate = self
        SurpQuizTableView.dataSource = self
        SurpQuizTableView.backgroundColor = .clear
        SurpQuizTableView.showsVerticalScrollIndicator = false
        SurpQuizTableView.separatorStyle = .none
        SurpQuizTableView.sectionIndexTrackingBackgroundColor = .clear
        SurpQuizTableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        SurpQuizTableView.register(UINib(nibName: "AddQuestionViewCell", bundle: nil), forCellReuseIdentifier: "AddQuestionViewCell")
        SurpQuizTableView.reloadData()
        submitBtn.layer.cornerRadius = 20
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        imagePreView.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        imagePreView.isHidden = true
    }
}

extension SurpriseQuizVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.questionsList.count
        }
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cellObj = viewModel.questionsList[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell",for: indexPath) as! QuestionCell
            cell.questionTextField.placeholder = "Question"
            cell.questionNumberLabel.text = "\(indexPath.row + 1)."
            cell.configure(model: cellObj, programId: programId, indexPath: indexPath)
            cell.backgroundColor = .clear
            cell.deleteBtn.addTarget(self, action: #selector(deleteButton), for: .touchUpInside)
            cell.plusBtn.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
            cell.copyBtn.addTarget(self, action: #selector(copyButtonAction), for: .touchUpInside)
        
            cell.addOptionbtnSelected = {
                self.createQuestionModel = cellObj
                if self.createQuestionModel?.options.count ?? 0 < 4 {
                    self.viewModel.addNewOption(question: self.viewModel.questionsList[indexPath.row])
                    print(" tabelView.reloadData====>\( String(describing: self.SurpQuizTableView.reloadData))")
                    self.SurpQuizTableView.reloadData()
                }
            }
            
            cell.firstButtonSelected =  {
                tableView.reloadData()
            }
            cell.imageReloadButtonSelected = {
                self.createQuestionModel = cellObj
                tableView.reloadData()
            }
            cell.setAnswerKeySelected = {
                let viewC = PopUpView(nibName: "PopUpView", bundle: nil)
                viewC.answerKey = cellObj
                if self.viewModel.CheckQusAndOptionText(question: cellObj) {
                    self.viewModel.setKeyQuestion = cellObj
                    self.viewModel.setAnsWerKeyPopUPView = true
                    self.present(viewC, animated: true)
                    viewC.setOptionkeyAnswer = { model in
                        
                        tableView.reloadData()
                    }
                    
                }
                viewC.setOptionkeyAnswerActionSelected = {
                    self.viewModel.callBackData(question: cellObj)
                    tableView.reloadData()
                }
                viewC.optionText = cell.questionTextField.text ?? ""
                
            }
            cell.preViewImageSelected = { image, button in
                
                self.imagePreView.isHidden = false
                self.popUpPreViewImageView.image = image
                self.showAnimate()
               // self.showPopup(button: button)
                //                    let preViewVC =  ImagePreViewPopUpView(nibName: "ImagePreViewPopUpView", bundle: nil)
                //
                //                    preViewVC.preViewimageView = image
                //                    self.present(preViewVC, animated: true)
                //
            }
            
            cell.optionPreViewImageSelected = { image in
                
             //   let preViewVC =  ImagePreViewPopUpView(nibName: "ImagePreViewPopUpView", bundle: nil)
                
                self.imagePreView.isHidden = false
                self.popUpPreViewImageView.image = image
                self.showAnimate()
//                preViewVC.preViewimageView = image
//                self.present(preViewVC, animated: true)
            }
            
            //MARK: -> OptionImagePickerAction
            cell.imagebtnSelected = { option in
                //   cell.optionImagePickerPass = { imgepicker in
                self.options = option
                let imagPicker = UIImagePickerController()
                imagPicker.delegate = self
                // imagPicker.allowsEditing = true
                imagPicker.sourceType = .photoLibrary
                tableView.reloadData()
                self.SurpQuizTableView.reloadData()
                self.present(imagPicker, animated: true)
            }
            
            //MARK: -> QuestionImagePickerAction
            cell.questimagebtnSelected = {
                self.createQuestionModel = cellObj
                self.present(self.imagePicker1, animated: true)
                self.SurpQuizTableView.reloadData()
            }
            return cell
            
        } else {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "AddQuestionViewCell",for: indexPath) as! AddQuestionViewCell
            //configureCell(cell)
            cell1.addNewBtn.backgroundColor = UIColor(hexString: "#E1F5FA")
            cell1.backgroundColor = .clear
            cell1.addNewBtn.addTarget(self, action: #selector(addNewButton), for: .touchUpInside)
            
            return cell1
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == imagePicker1 {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                let question = QuestionImageModel()
                question.image = pickedImage
                createQuestionModel?.questionImageModel.append(question)
                SurpQuizTableView.reloadData()
                picker.dismiss(animated: true, completion: nil)
            }
        }else{
            if let optionPickerImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                let optionimage = OptionImageModel()
                optionimage.image = optionPickerImage
                if let option = options{
                    option.optionImageModel.append(optionimage)
                    SurpQuizTableView.reloadData()
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
    }
    //MARK: - ImagePicker delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func copyQuestionCell(question: CreateQuestionModel){
        let index = viewModel.indexOf(question: question)
        if !question.text.isEmpty && !question.options[index!].name.isEmpty{
            let newQuestion = question
            //newQuestion.id = UUID().uuidString
            viewModel.questionsList.insert(newQuestion.copyModel(), at: index! + 1)
        }
        
    }
    
    func remove( cellForRowAt indexPath: IndexPath){
        viewModel.questionsList.remove(at:indexPath.row)
        print("index===>\(indexPath.row)")
        self.SurpQuizTableView.reloadData()
    }
    
    
    func removeImageList(question:CreateQuestionModel){
        let index = question.questionImageModel.count
        let qus = CreateQuestionModel()
        qus.questionImageModel.removeAll(where: { $0.id == question.questionImageModel[index].id})
    }
    
    func removeQuestionList(){
        let question = CreateQuestionModel()
        if let index = viewModel.questionsList.lastIndex(where: { $0.id == question.id }) {
            viewModel.removeNewQuestion(question: question, index: index)
        }
        
    }
}

extension SurpriseQuizVC{
    
    @objc func copyButtonAction(){
        //          if viewModel.questionsList.count <= 1{
        //              copyQuestionCell(question: question.wrappedValue)
        //          }
        //  let question = CreateQuestionModel()
        if viewModel.questionsList.count <= 1{
            if let model = createQuestionModel {
                copyQuestionCell(question: model)
                SurpQuizTableView.reloadData()
            }
        }
    }
    
    @objc func addNewButton(){

        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            if self.viewModel.questionsList.count <= 1 {
                self.viewModel.addNewQuestion()
                self.SurpQuizTableView.reloadData()
            }
        }, completion: { _ in
        })
      
    }
    
    @objc func deleteButton(_ sender: UIButton){
     
        UIView.animate(withDuration: 1, delay: 0,options: .curveEaseInOut) {
            let btnPos = sender.convert(CGPoint.zero, to: self.SurpQuizTableView)
            guard let indexPath = self.SurpQuizTableView.indexPathForRow(at: btnPos) else {
                return
            }
            self.remove(cellForRowAt: indexPath)
            print("\(indexPath.row)")
            self.SurpQuizTableView.reloadData()
          
        }
      
        
    }
    @objc func plusButtonAction(){
        
        if viewModel.questionsList.count <= 1 {
            viewModel.addNewQuestion()
            SurpQuizTableView.reloadData()
        }
    }
    @objc func popUpXmarkBtnAction(){
        imagePreView.isHidden = true
    }
}


extension SurpriseQuizVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        questionTitleTextField.resignFirstResponder()
        return false
    }
}


extension SurpriseQuizVC{
    
    func setConstrain(){
        //view.addSubview(imagePreView)
        
        
        NSLayoutConstraint.activate([
            imagePreView.topAnchor.constraint(equalTo: view.topAnchor),
            imagePreView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagePreView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagePreView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //imagePreView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          //  imagePreView.heightAnchor.constraint(equalToConstant: 200),
           // imagePreView.widthAnchor.constraint(equalToConstant: 300),
            
            popUpXmarkBtn.topAnchor.constraint(equalTo: popUpPreViewImageView.topAnchor),
            popUpXmarkBtn.trailingAnchor.constraint(equalTo: popUpPreViewImageView.trailingAnchor),
            popUpXmarkBtn.heightAnchor.constraint(equalToConstant: 30),
            popUpXmarkBtn.widthAnchor.constraint(equalToConstant: 30),
            
            popUpPreViewImageView.centerXAnchor.constraint(equalTo: imagePreView.centerXAnchor),
            popUpPreViewImageView.topAnchor.constraint(equalTo: imagePreView.topAnchor, constant: 200),
            //popUpPreViewImageView.trailingAnchor.constraint(equalTo: imagePreView.trailingAnchor),
           // popUpPreViewImageView.bottomAnchor.constraint(equalTo: imagePreView.bottomAnchor,constant: 200),
            popUpPreViewImageView.heightAnchor.constraint(equalToConstant: 200),
            
            popUpPreViewImageView.widthAnchor.constraint(equalToConstant: 300),
            
            
            
        ])
        
    }
    
    func showAnimate()
    {
        setConstrain()
        self.imagePreView.transform = CGAffineTransform(scaleX: 1.3, y: -1.0)
        self.imagePreView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.imagePreView.alpha = 1
            self.imagePreView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.imagePreView.sizeToFit()
        },completion: {_ in
          //  self.hidePopup()
        })
    }
    
    func hidePopup() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
          
            self.imagePreView?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }, completion: { _ in
         //   self.showAnimate()
           // self.imagePreView?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        })
    }
    
    func showPopup(button:UIButton) {
        setConstrain()
//        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
        
        
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear], animations: {
          //  self.imagePreView.frame = button.frame.offsetBy(dx: 0 * button.frame.size.width, dy: 0.5)
            self.imagePreView.frame = button.frame.offsetBy(dx:0, dy: 0.5)
          }, completion: nil)
        
        
            
//            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
//
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
//                             self.imagePreView.center.y = button.bounds.height - 20
//                         })
//
//
//            })
            
            
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
//                self.imagePreView.backgroundColor = .magenta
//            })
//
//            self.viewIndicators.frame = sender.frame.offsetBy(dx:0,dy:20)
//            self.imagePreView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }, completion: nil)
        
        
        
        
        
        
        
        
        
        
      
        
        
    }
    
}

