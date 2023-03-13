//
//  ImagePreViewPopUpView.swift
//  SurpriseQuizXIB POC
//
//  Created by Guru Mahan on 09/03/23.
//

import UIKit

class ImagePreViewPopUpView: UIViewController {
    
    var preViewImagePass: ((UIImage) -> ())? = nil
    var preViewimageView : UIImage?
    @IBOutlet weak var preViewImage: UIImageView?
    
    @IBOutlet weak var imageBackgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
        imageBackgroundView.backgroundColor = .clear
        preViewImage?.image = preViewimageView
    }
    
    var myview:UIView?
//
//    func animate(){
//        UIView.animate(withDuration: 1, animations: {
//            self.myview.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
//            self.myview?.center = self.view.center
//        }, completion: nil)
//    }
//
//    func shrink(){
//        UIView.animate(withDuration: 1, animations: {
//            self.myview.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//            self.myview?.center = self.view.center
//        },completion: { done in
//            self.animate()
//        })
//    }

}
