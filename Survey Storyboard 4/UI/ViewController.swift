//
//  ViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 27/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import UIKit

var logoLogout: Int = 0
let storyboard = UIStoryboard(name: "Main", bundle: nil)

class ViewController: UIViewController {

    @IBAction func startButton(_ sender: UIButton) {
        let viewControllerIdentifier: String = form!.formQuestions[form!.currentQuestion].type
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // get formData from server
        let formData: String =
        """
        {
            "name": "Tourist Survey Form",
            "questions": [
                { "question": "Where did you come from?", "type": "pick", "choices": ["China", "India", "Japan", "Thailand", "United States of America", "Other"]},
                { "question": "Do you have a pet with you?", "type": "pick", "choices": ["Yes", "No"]},
                { "question": "Please rate our service!", "type": "icon", "choices": ["n/a"]},
                { "question": "Stars", "type": "star", "choices": ["n/a"]}
            ]
        }
        """
        form = SurveyForm(formData)
    }
}

