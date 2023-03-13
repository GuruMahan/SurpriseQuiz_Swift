//
//  SurpriseQuizModel.swift
//  Surprise QuizUI Demo
//
//  Created by Guru Mahan on 19/01/23.
//

import Foundation
import UIKit

class CreateQuestionModel{
  var id: String = UUID().uuidString
  var name: String = ""
  var placeHolder = ""
  var text: String = ""
  var questionImageModel: [QuestionImageModel] = []
 
  var options: [CreateOptionModel] = []
  var height: CGFloat = 0
 // var option: CreateOptionModel?
    func copyModel(with zone: NSZone? = nil) -> CreateQuestionModel {
        let copy = CreateQuestionModel()
        copy.text = self.text
        //copy.attachments = self.attachments.map({ $0.copy() })
        copy.options = self.options.map({ $0.copy() })
        copy.questionImageModel = self.questionImageModel.map({ $0.copy() })
         //copy.sessionFlow = self.sessionFlow.map({ $0 })
        //copy.slo = self.slo.map({ $0 })
        //copy.taxonomy = self.taxonomy.map({ $0 })
        //copy.feedback = self.feedback.map({ $0 })
        return copy
    }
}
class CreateOptionModel{
    
  var id: String = UUID().uuidString
  var name: String = ""
  var placeHolder = ""
  var optionImageModel:  [OptionImageModel] = []
  var attachments: [Attachments] = []
  var height: CGFloat = 0
  var textHeight: CGFloat = 0
  var isAnswer: Bool = false
  var isSelected = false
    
    func copy(with zone: NSZone? = nil) -> CreateOptionModel {
        let copy = CreateOptionModel()
        copy.id = self.id
        copy.name = self.name
        copy.height = self.height
        copy.textHeight = self.textHeight
        copy.isAnswer = self.isAnswer
        copy.isSelected = self.isSelected
      
        copy.optionImageModel = self.optionImageModel.map({ $0.copy() })
       // copy.attachments = self.questions.map({ $0.copyModel() })
        copy.attachments = self.attachments
        return copy
    }
}

class QuestionImageModel{
    var id: String = UUID().uuidString
    var image:UIImage?
    var attachments: [Attachments] = []
    
    func copy(with zone: NSZone? = nil) -> QuestionImageModel {
        let copy = QuestionImageModel()
        copy.id = self.id
        copy.image = self.image
       
        copy.attachments = self.attachments
        return copy
    }
    
}

class OptionImageModel{
    var id: String = UUID().uuidString
    var image:UIImage?
    var attachments1: [Attachments] = []
    
    func copy(with zone: NSZone? = nil) -> OptionImageModel {
        let copy = OptionImageModel()
        copy.id = self.id
        copy.image = self.image
        copy.attachments1 = self.attachments1
        return copy
    }
}
class Attachments: Codable{
    var height: CGFloat = 0
}
