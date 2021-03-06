//
//  StarQuestionViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 30/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class StarQuestionView: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstStarView: UIImageView!
    @IBOutlet weak var secondStarView: UIImageView!
    @IBOutlet weak var thirdStarView: UIImageView!
    @IBOutlet weak var fourthStarView: UIImageView!
    @IBOutlet weak var fifthStarView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var elements: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        if form?.formQuestions[form!.currentQuestion].answer == "" {
            nextButton.isEnabled = false
        }
        
        if form?.currentQuestion == 0 {
            backButton.setTitle("Stop", for: .normal)
        }
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        
        if form?.formQuestions[form!.currentQuestion].answer == "" {
            nextButton.isEnabled = false
        }
        
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
        
        questionLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        questionLabel.text = form?.formQuestions[form!.currentQuestion].question
        
        elements = [firstStarView, secondStarView, thirdStarView, fourthStarView, fifthStarView]
        
        for element in elements {
            element.isUserInteractionEnabled = true
            element.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(IconQuestionView.iconTapped(tapGestureRecognizer:))))
        }
    }
    
    @objc func iconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        for element in elements {
            element.tintColor = UIColor.lightGray
            element.image = UIImage(systemName: "star")
        }
        
        var elementsToHighlight: [UIImageView] = []

        switch tappedImage {
        case firstStarView:
            form?.formQuestions[form!.currentQuestion].answer = "1"
            elementsToHighlight.append(tappedImage)
        case secondStarView:
            form?.formQuestions[form!.currentQuestion].answer = "2"
            elementsToHighlight.append(firstStarView)
            elementsToHighlight.append(tappedImage)
        case thirdStarView:
            form?.formQuestions[form!.currentQuestion].answer = "3"
            elementsToHighlight.append(firstStarView)
            elementsToHighlight.append(secondStarView)
            elementsToHighlight.append(tappedImage)
        case fourthStarView:
            form?.formQuestions[form!.currentQuestion].answer = "4"
            elementsToHighlight.append(firstStarView)
            elementsToHighlight.append(secondStarView)
            elementsToHighlight.append(thirdStarView)
            elementsToHighlight.append(tappedImage)
        case fifthStarView:
            form?.formQuestions[form!.currentQuestion].answer = "5"
            elementsToHighlight.append(firstStarView)
            elementsToHighlight.append(secondStarView)
            elementsToHighlight.append(thirdStarView)
            elementsToHighlight.append(fourthStarView)
            elementsToHighlight.append(tappedImage)
        default:
            form?.formQuestions[form!.currentQuestion].answer = "nil"
        }
        
        for element in elementsToHighlight {
            element.image = UIImage(systemName: "star.fill")
            element.tintColor = .systemYellow
        }
        nextButton.isEnabled = true
    }
    
    @objc func nextButtonClicked() {
        let viewControllerIdentifier: String = (form?.formQuestions[form!.currentQuestion + 1].type)!
        form?.currentQuestion += 1
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        
        view.window!.layer.add(transition, forKey: kCATransition)

        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: false, completion: nil)
    }
    
    @objc func submitButtonClicked() {
        form?.submit(true)
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: "ThankYouView") as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        vcToPresent.modalTransitionStyle = .flipHorizontal
        present(vcToPresent, animated: true, completion: nil)
    }
    
    @objc func backButtonClicked() {
        var viewControllerIdentifier: String = ""
        if form!.currentQuestion == 0 {
            viewControllerIdentifier = "StartView"
        }
        else {
            viewControllerIdentifier = (form?.formQuestions[form!.currentQuestion - 1].type)!
        }
        
        form?.currentQuestion -= 1
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        
        view.window!.layer.add(transition, forKey: kCATransition)
        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: false, completion: nil)
        
    }
    
    @objc func logoTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        logoLogout += 1
        if logoLogout == 5 && form?.currentQuestion == 0 {
            let vcToPresent = storyboard!.instantiateViewController(withIdentifier: "LoginView") as UIViewController
            vcToPresent.modalPresentationStyle = .fullScreen
            vcToPresent.modalTransitionStyle = .crossDissolve
            present(vcToPresent, animated: true, completion: nil)
        }
    }
}
