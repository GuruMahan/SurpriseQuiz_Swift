//
//  ImageViewCell.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 08/03/23.
//

import UIKit

class ImageViewCell: UITableViewCell {
    var optionImageXmarkBtnSelected: (() -> ())? = nil
    var optionPreViewImageSelected:((UIImage?) -> ())? = nil
    @IBOutlet weak var imgview: UIImageView!
 
    @IBOutlet weak var optionImageXmarkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        imgview.image = UIImage(systemName: "person")
        optionImageXmarkBtn.addTarget(self, action: #selector(optionImageXmarkBtnAction), for: .touchUpInside)
       
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgview.isUserInteractionEnabled = true
        imgview.addGestureRecognizer(tapGesture)
        //questImageView.layer.cornerRadius = 20
        imgview.contentMode = .scaleAspectFit
    }
    @objc func optionImageXmarkBtnAction(){
        optionImageXmarkBtnSelected?()
    }
    @objc func imageTapped(tapGestureRecognizer:UITapGestureRecognizer){
//     let preViewVC =  ImagePreViewPopUpView(nibName: "ImagePreViewPopUpView", bundle: nil)
//        preViewVC.preViewImage.image = questImageView.image
        optionPreViewImageSelected?(imgview.image)
     
        
    }
}
