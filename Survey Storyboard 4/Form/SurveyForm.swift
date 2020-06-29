//
//  SurveyForm.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 27/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class SurveyForm: Codable {
    
    var formName: String
    var formQuestions: [SurveyQuestion]
    var currentQuestion: Int = 0
    var totalQuestion: Int
    
    init(_ rawFormData: String) {
        let json: [String: Any] = try! JSONSerialization.jsonObject(with: rawFormData.data(using: .utf8)!, options: []) as! [String : Any]
        formName = json["name"] as? String ?? "Error getting form name"
        formQuestions = []
        for question in json["questions"] as! [[String: Any]] {
            formQuestions.append(SurveyQuestion(question))
        }
        totalQuestion = formQuestions.count - 1
    }
    
    func submit(_ formExists: Bool) {
        let _ = submitForm(formExists)
    }
}

func submitForm(_ formInitialized: Bool) -> Bool {
    // Get server status
    var serverOnline = true
    
    if serverOnline {
        // Get remaining data
        var allForms: [SurveyForm] = []
        var indexToSave: Int? = UserDefaults.standard.integer(forKey: "indexToSave")
        if indexToSave == nil { indexToSave = 0 }
        
        if formInitialized {
            allForms.append(form!)
        }
        
        for index in 0 ..< (indexToSave! as Int) {
            guard let formData = UserDefaults.standard.object(forKey: "form: \(index)") as? Data else { return false }
            guard let retrievedForm = try? PropertyListDecoder().decode(SurveyForm.self, from: formData) else { return false }
            allForms.append(retrievedForm)
        }
        let userDefaultDict = UserDefaults.standard.dictionaryRepresentation()
        userDefaultDict.keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.synchronize()
        
        // Send allForms to server
        return true
    }
    else {
        var indexToSave: Int? = UserDefaults.standard.integer(forKey: "indexToSave")
        if indexToSave == nil {
            indexToSave = 0
        }
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(form), forKey: "form: \(indexToSave!)")
        UserDefaults.standard.set(indexToSave! + 1, forKey: "indexToSave")
        UserDefaults.standard.synchronize()
        
        return false
    }
}
