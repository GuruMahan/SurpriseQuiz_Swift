//
//  QuestionImageViewCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 08/03/23.
//

import UIKit

class QuestionImageViewCell: UITableViewCell {
    var imageXmarkSelected:((UIButton) -> ())? = nil
    var preViewImageSelected:((UIImage?, UIButton) -> ())? = nil
  
    @IBOutlet weak var questImageView: UIImageView!
    
    
    
    @IBOutlet weak var imageXmarkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        questImageView.isUserInteractionEnabled = true
        questImageView.addGestureRecognizer(tapGesture)
        //questImageView.layer.cornerRadius = 20
        questImageView.contentMode = .scaleAspectFit
        imageXmarkBtn.addTarget(self, action: #selector(imageXmarkBtnAction), for: .touchUpInside)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func imageaction(_ sender: UIButton) {
        preViewImageSelected?(questImageView.image, sender)
        
    }
    @objc func imageXmarkBtnAction(_ sender: UIButton){
        imageXmarkSelected?(sender)
    }
    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer){
//     let preViewVC =  ImagePreViewPopUpView(nibName: "ImagePreViewPopUpView", bundle: nil)
//        preViewVC.preViewImage.image = questImageView.image
   
     
        
    }
}
