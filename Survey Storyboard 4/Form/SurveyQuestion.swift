//
//  SurveyQuestion.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 27/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class SurveyQuestion: Codable {
    let question: String
    let type: String
    var choices: [String]
    var answer: String = ""
    
    init(_ questionData: [String: Any]) {
        question = questionData["question"] as? String ?? "Error getting prompt"
        type = questionData["type"] as? String ?? "Error getting type"
        choices = questionData["choices"] as? [String] ?? ["Error getting choices"]
    }
}
