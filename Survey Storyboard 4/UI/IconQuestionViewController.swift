//
//  IconQuestionViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 27/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class IconQuestionView: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var veryBadImageView: UIImageView!
    @IBOutlet weak var badImageView: UIImageView!
    @IBOutlet weak var okImageView: UIImageView!
    @IBOutlet weak var goodImageView: UIImageView!
    @IBOutlet weak var greatImageView: UIImageView!
    
    var elements: [UIImageView] = []
    var logoLogout: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elements = [veryBadImageView, badImageView, okImageView, goodImageView, greatImageView]
        setUp()
        
    }
    
    @objc func iconTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        for element in elements {
            element.tintColor = UIColor.lightGray
        }

        switch tappedImage {
        case veryBadImageView:
            form?.formQuestions[form!.currentQuestion].answer = "very bad"
            tappedImage.tintColor = UIColor.red
        case badImageView:
            form?.formQuestions[form!.currentQuestion].answer = "bad"
            tappedImage.tintColor = UIColor.orange
        case okImageView:
            form?.formQuestions[form!.currentQuestion].answer = "ok"
            tappedImage.tintColor = UIColor.systemYellow
        case goodImageView:
            form?.formQuestions[form!.currentQuestion].answer = "good"
            tappedImage.tintColor = UIColor.systemGreen
        case greatImageView:
            form?.formQuestions[form!.currentQuestion].answer = "great"
            tappedImage.tintColor = UIColor.systemTeal
        default:
            form?.formQuestions[form!.currentQuestion].answer = "nil"
        }
        
        nextButton.isEnabled = true
    }
    
    func setUp() {
        logoView.isUserInteractionEnabled = true
        logoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoTapped(_:))))
        
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
        
        veryBadImageView.image = UIImage(named: "very bad")!.withRenderingMode(.alwaysTemplate)
        badImageView.image = UIImage(named: "bad")!.withRenderingMode(.alwaysTemplate)
        okImageView.image = UIImage(named: "ok")!.withRenderingMode(.alwaysTemplate)
        goodImageView.image = UIImage(named: "good")!.withRenderingMode(.alwaysTemplate)
        greatImageView.image = UIImage(named: "great")!.withRenderingMode(.alwaysTemplate)
        questionLabel.font = UIFont.systemFont(ofSize: 60, weight: .medium)
        questionLabel.text = form?.formQuestions[form!.currentQuestion].question
        
        for element in elements {
            // Any other customization that applies to all ImageViews
            element.tintColor = UIColor.lightGray
            element.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(IconQuestionView.iconTapped(tapGestureRecognizer:))))
            element.isUserInteractionEnabled = true
            
            if form?.formQuestions[form!.currentQuestion].answer != "" || form?.formQuestions[form!.currentQuestion].answer != "nil" {
                switch form?.formQuestions[form!.currentQuestion].answer {
                case "very bad":
                    veryBadImageView.tintColor = UIColor.red
                case "bad":
                    badImageView.tintColor = UIColor.orange
                case "ok":
                    okImageView.tintColor = UIColor.systemYellow
                case "good":
                    goodImageView.tintColor = UIColor.systemGreen
                case "great":
                    greatImageView.tintColor = UIColor.systemTeal
                default:
                    let _ = 0
                }
            }
        }
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
