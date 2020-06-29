//
//  PickQuestionViewController.swift
//  Survey Storyboard 4
//
//  Created by Phoom Punpeng on 27/6/2563 BE.
//  Copyright © 2563 Phoom Punpeng. All rights reserved.
//

import Foundation
import UIKit

class PickQuestionView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    let pickerData: [String] = (form?.formQuestions[form!.currentQuestion].choices)!
    var logoLogout: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        setup()
    }
    
    func setup() {
        logoView.isUserInteractionEnabled = true
        logoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoTapped(_:))))
        
        for index in 0 ..< (form?.formQuestions[form!.currentQuestion].choices.count)! {
            if form?.formQuestions[form!.currentQuestion].answer == pickerData[index] {
                pickerView.selectRow(index, inComponent: 0, animated: true)
            }
        }

        if form?.currentQuestion == 0 {
            backButton.setTitle("Stop", for: .normal)
        }
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        
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
    }
    
    @objc func nextButtonClicked() {
        let picked = pickerView.selectedRow(inComponent: 0)
        form?.formQuestions[form!.currentQuestion].answer = pickerData[picked]
        
        let viewControllerIdentifier: String = (form?.formQuestions[form!.currentQuestion + 1].type)!
        form?.currentQuestion += 1
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        
        view.window!.layer.add(transition, forKey: kCATransition)
        
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: viewControllerIdentifier) as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: false, completion: nil)
    }
    
    @objc func submitButtonClicked() {
        form?.submit(true)
        let vcToPresent = storyboard!.instantiateViewController(withIdentifier: "ThankYouView") as UIViewController
        vcToPresent.modalPresentationStyle = .fullScreen
        vcToPresent.modalTransitionStyle = .flipHorizontal
        present(vcToPresent, animated: false, completion: nil)
    }
    
    @objc func backButtonClicked() {
        let picked = pickerView.selectedRow(inComponent: 0)
        form?.formQuestions[form!.currentQuestion].answer = pickerData[picked]
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel;

        if pickerLabel == nil {
            pickerLabel = UILabel()

            pickerLabel?.font = UIFont.systemFont(ofSize: 50, weight: .thin)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }

        pickerLabel?.text = pickerData[row]
        return pickerLabel!
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
