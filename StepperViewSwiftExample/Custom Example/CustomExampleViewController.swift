//
//  CustomExampleViewController.swift
//  StepperViewSwiftExample
//
//  Created by Aziz Hamadi on 20/1/2023.
//

import UIKit
import StepperViewSwift

class CustomExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var titles = ["Stepper title 1", "Stepper title 2", "Stepper title 3", "Stepper title 4"]

    @IBOutlet var stepperView: Stepper! {
        didSet {
            stepperView.customDataSource = self
            stepperView.customDelegate = self
        }
    }
    
    @IBAction func previousAction(_ sender: Any) {
        stepperView.previousStepper()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if stepperView.isLastStepper() {
            let alert = UIAlertController(title: "Congratulations", message: "You have completed the stepper", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.stepperView.reloadData()
            }))
            present(alert, animated: true)
        }
        stepperView.nextStepper()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension CustomExampleViewController: CustomStepperDataSource {
    func numberOfRowsInStepper() -> Int {
        return titles.count
    }
    
    func stepper(cellForRowAtIndexPath indexPath: NSIndexPath) -> UIView? {
        let customStepperView = ExampleStepperItem()
        customStepperView.createCustomView(index: indexPath.row)
        return customStepperView
    }
    
    func titleStepper(cellForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return titles[indexPath.row]
    }
}
extension CustomExampleViewController: CustomStepperDelegate {
    func resultStepper(viewAtIndexPath indexPath: NSIndexPath, view: UIView?) {
        if let customStepperView = view as? ExampleStepperItem {
            print("Index of custom stepper view : \(indexPath.row) and titleLabel : \(customStepperView.titleLabel.text ?? "")")
        }
    }
}
