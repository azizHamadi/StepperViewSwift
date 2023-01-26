//
//  ViewController.swift
//  tepperViewSwiftExample
//
//  Created by Aziz Hamadi on 20/1/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toDefaultStepperAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let defaultStepperViewController = storyboard.instantiateViewController(withIdentifier: "DefaultExampleViewController")
                as? DefaultExampleViewController else { return }
        navigationController?.pushViewController(defaultStepperViewController, animated: true)
    }
    
    @IBAction func toCustomStepperAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let customStepperViewController = storyboard.instantiateViewController(withIdentifier: "CustomExampleViewController")
                as? CustomExampleViewController else { return }
        navigationController?.pushViewController(customStepperViewController, animated: true)
    }
}
