//
//  IconQuestionViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 27/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class IconQuestionButtonView: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }
    
    @objc func iconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        for element in elements {
            element.isHighlighted = false
        }
        tappedImage.isHighlighted = true
        // Saves answer
//        form?.formQuestions[form!.currentQuestion].answer =
    }
    
    func setUp() {
        if form?.currentQuestion == form?.totalQuestion {
            nextButton.setTitle("Submit", for: .normal)
            nextButton.removeTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
            nextButton.addTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
        }
        else {
            nextButton.setTitle("Next", for: .normal)
            nextButton.removeTarget(self, action: #selector(submitButtonClicked), for: .touchUpInside)
            nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        }
        
        let elements: [UIImageView] = [veryBadImageView, badImageView, okImageView, goodImageView, greatImageView]
        
        for element in elements {
            // Any other customization that applies to all ImageViews
            element.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(IconQuestionView.iconTapped(tapGestureRecognizer:))))
            element.isUserInteractionEnabled = true
        }
        
        veryBadImageView.image = UIImage(named: "very bad")
        badImageView.image = UIImage(named: "bad")
        okImageView.image = UIImage(named: "ok")
        goodImageView.image = UIImage(named: "good")
        greatImageView.image = UIImage(named: "great")
        questionLabel.text = form?.formQuestions[form!.currentQuestion].question
    }
    
    @objc func nextButtonClicked() {
        let viewControllerIdentifier: String = (form?.formQuestions[form!.currentQuestion + 1].type)!
        form?.currentQuestion += 1
        
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: true, completion: nil)
    }
    
    @objc func submitButtonClicked() {
        form?.submit()
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: "StartView") as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: true, completion: nil)
    }
}
