//
//  PopUpView.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 07/03/23.
//

import UIKit

class PopUpView: UIViewController,UISheetPresentationControllerDelegate {
   
    var setOptionkeyAnswer:((CreateQuestionModel?)->())?
    var setOptionkeyAnswerActionSelected:(()->())?
    @IBOutlet weak var popUpTableView: UITableView!
    @IBOutlet weak var setKeyBtn: UIButton!
    var optionText = ""
    var answerKey:CreateQuestionModel?
    override var sheetPresentationController: UISheetPresentationController{
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpTableView.allowsSelection = false
        setKeyBtn.layer.borderWidth = 1
        setKeyBtn.layer.borderColor = UIColor.blue.cgColor
        setKeyBtn.layer.cornerRadius = 10
        setKeyBtn.addTarget(self, action: #selector(setAnswerKeyAction), for: .touchUpInside)
        popUpTableView.register(UINib(nibName: "PopUpViewCell", bundle: nil), forCellReuseIdentifier: "PopUpViewCell")
        popUpTableView.delegate = self
        popUpTableView.dataSource = self
        
        popUpTableView.showsVerticalScrollIndicator = false
        popUpTableView.separatorStyle = .none
        popUpTableView.sectionIndexTrackingBackgroundColor = .clear
        // Do any additional setup after loading the view.
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        
        sheetPresentationController.detents = [
            .medium(),
            .large()
        ]
    }
    
    func popUpViewchangeOption(option: CreateOptionModel) {
      
        if let answer = answerKey?.options.enumerated(){
            for (indexI,model) in answer {
                   if model.id == option.id {
                       answerKey?.options[indexI].isAnswer = true
                       
                   } else {
                       answerKey?.options[indexI].isAnswer = false
                   }
               }
        }
   }
    
}

extension PopUpView: UITableViewDelegate,UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerKey?.options.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpViewCell") as! PopUpViewCell
        let option = answerKey?.options[indexPath.row]
        cell.optionTextfield.text = option?.name ?? ""
        if let opt = option{
            cell.configure(model: opt)
        }
        cell.popUpViewOptionBtnSelected = { button in
          //  cell.option?.isAnswer = (option != nil)
            if let opt = option{
                self.popUpViewchangeOption(option: opt)
            }
                self.popUpTableView.reloadData()
            self.setOptionkeyAnswer?(self.answerKey)
       
        }
      
        return cell
    }
    
    @objc func setAnswerKeyAction(){
        setOptionkeyAnswerActionSelected?()
        self.dismiss(animated: true, completion: nil)
    }
    
}
