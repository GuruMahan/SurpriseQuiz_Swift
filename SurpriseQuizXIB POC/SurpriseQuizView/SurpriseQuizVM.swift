//
//  SurpriseQuizVM.swift
//  Surprise QuizUI Demo
//
//  Created by Guru Mahan on 19/01/23.
//

import Foundation
import UIKit

class SurpriseQuizVM {
    
    public var setKeyQuestion: CreateQuestionModel?
    public var questionsList: [CreateQuestionModel] = []
    public var questionsSelected: CreateQuestionModel?
    public var optionSelected: CreateOptionModel?
    public var questionIndex: Int?
    public var optionIndex: Int?
    public var selectedIndex: Int = 0
    public var setAnsWerKeyPopUPView = false
    public var answerKey:CreateQuestionModel?
   // @Published var optionTextfielf = ["guru","guru"]
    init() {
        questionsList.append(createNewQuestion(index: questionCount))
    }
    
    var questionCount: Int {
        questionsList.count
    }
    
    func createNewQuestion(index: Int) ->CreateQuestionModel {
        
        var question =  createQuestion(text: "", placeHolder: "Question", option: CreateOptionModel(),  optionPlaceHolder: "option-1", optionId: "0")
        for _ in 1..<2{
            question.options.append(CreateOptionModel())
        }
        return question
        
    }
   
   
    func createQuestion(text:String,placeHolder:String,option:CreateOptionModel,optionPlaceHolder:String,optionId:String) -> CreateQuestionModel{
       
        var question = CreateQuestionModel()
        question.text = text
        question.placeHolder = placeHolder
       
        
        var option1 = option
        option1.placeHolder = optionPlaceHolder
        question.options.append(option1)
        return question
    }
    
    
    func optionIndexOf(question: CreateQuestionModel,option:CreateOptionModel) -> Int? {
        if let index =  questionsList.lastIndex(where: { $0.id == question.id }){
            return questionsList[index].options.lastIndex(where: {$0.id == option.id})
        }
      //  questionsList[index].options.lastIndex(where: {$0.id == option.id})
     return nil
    }
    func indexOf(option: CreateOptionModel) -> Int? {
        questionsList.lastIndex(where: { $0.id == option.id })
    }
    
    func indexOf(question: CreateQuestionModel) -> Int? {
        questionsList.lastIndex(where: { $0.id == question.id })
    }
    func removeNewQuestion(question:CreateQuestionModel,  index: Int) {
        if let index = questionsList.lastIndex(where: { $0.id == question.id }) {
            questionsList.remove(at: index)
        }
     
    }
    func delete(at offsets: IndexSet){
        
        var question = CreateQuestionModel()
        question.options.remove(atOffsets: offsets)
    }
   
    func addNewQuestion() {
        questionsList.append(createNewQuestion(index: questionCount))
        
    }

    func insertNewQuestion(question: CreateQuestionModel) {
        
        if let index = questionsList.lastIndex(where: { $0.id == question.id }) {
            questionsList.insert(createNewQuestion(index: index+1), at: index+1)
        }
        
    }
  
    func addNewOption(question: CreateQuestionModel) {

        if let index = questionsList.lastIndex(where: { $0.id == question.id }) {
            let option = CreateOptionModel()
            option.placeHolder = "Option-\(index+1)"
            return  questionsList[index].options.append(option)
    
        }
        
    }
//    func popUpViewchangeOption(question: CreateQuestionModel, option: CreateOptionModel) {
//        
//        if let indexO = questionsList.lastIndex(where: { $0.id ==  question.id }) {
//            
//            for (indexI,model) in questionsList[indexO].options.enumerated() {
//                if model.id == option.id {
//                    questionsList[indexO].options[indexI].isAnswer = true
//                } else {
//                    questionsList[indexO].options[indexI].isAnswer = false
//                }
//            }
//        }
//    }

    func popViewchangeOption(question: CreateQuestionModel) {
        
            for (indexI,model) in question.options.enumerated() {
               question.options[indexI].isAnswer = model.isAnswer
            }
    }
  
    func callBackData(question: CreateQuestionModel) {
            for (indexI,model) in question.options.enumerated() {
                question.options[indexI].isSelected = model.isAnswer
            }
    }
    
    func changeOption(question: CreateQuestionModel, option: CreateOptionModel) {
        
        for (indexI,model) in question.options.enumerated() {
            if model.id == option.id {
                question.options[indexI].isSelected = true
            } else {
                question.options[indexI].isSelected = false
            }
        }
       
    }
    
    
    func CheckQusAndOptionText(question: CreateQuestionModel) -> Bool {
        var flag = true
        question.options.forEach { option in
            
            if option.name.isEmpty {
                flag = false
            }
    
        }
        if question.options.count < 2 {
           flag = false
        }
        return flag
       }
    
//    func copyQuestionCell(question: CreateQuestionModel){
//       
//        if !question.text.isEmpty, let index = indexOf(question: question){
//            var newQuestion = question
//            newQuestion.id = UUID().uuidString
//           questionsList.insert(newQuestion, at: index + 1)
//        }

      
    

}
