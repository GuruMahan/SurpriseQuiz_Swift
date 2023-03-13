//
//  QuestionCollectionViewCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 03/03/23.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leftSideBlueView: UIView!
    @IBOutlet weak var questionFieldView: UIView!
    @IBOutlet weak var DividerView: UIView!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var questionImageBtn: UIButton!
    @IBOutlet weak var tabelView: UITableView!

    override func layoutSubviews() {
        super.layoutSubviews()
        leftSideBlueView.roundCorners([.topLeft,.bottomLeft], radius: 20)
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.separatorStyle = .none
                tabelView.register(UINib(nibName: "OptionViewCell", bundle: nil), forCellReuseIdentifier: "OptionViewCell")
    }

}


extension QuestionCollectionViewCell: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionViewCell") as! OptionViewCell
        cell.optionTextField.text = "guru"
      return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
