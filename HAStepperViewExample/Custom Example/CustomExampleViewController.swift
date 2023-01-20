//
//  CustomExampleViewController.swift
//  HAStepperViewExample
//
//  Created by Tarek Messadi on 20/1/2023.
//

import UIKit
import HAStepperView

class CustomExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var titles = ["Stepper title 1", "Stepper title 2", "Stepper title 3", "Stepper title 4"]

    @IBOutlet var stepperView: Stepper! {
        didSet {
            stepperView.dataSource = self
            stepperView.delegate = self
        }
    }
    
    @IBAction func previousAction(_ sender: Any) {
        stepperView.previousStepper()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        stepperView.nextStepper()
        if stepperView.isLastStepper() {
            print("last stepper item")
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension CustomExampleViewController: StepperDataSource {
    func numberOfRowsInStepper() -> Int {
        return titles.count
    }
    
    func stepper(dataForRowAtIndexPath indexPath: NSIndexPath) -> StepperModel.viewModel? {
        return nil
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
extension CustomExampleViewController: StepperDelegate {
    func resultStepper(dataAtIndexPath indexPath: NSIndexPath, data: StepperModel.requestModel?) {}
    
    func stepperCustomView(viewAtIndexPath indexPath: NSIndexPath, view: UIView?) {
        if let customStepperView = view as? ExampleStepperItem {
            print("Index of custom stepper view : \(indexPath.row) and titleLabel : \(customStepperView.titleLabel.text ?? "")")
        }
    }
}