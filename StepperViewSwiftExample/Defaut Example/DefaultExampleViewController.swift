//
//  DefaultExampleViewController.swift
//  StepperViewSwiftExample
//
//  Created by Aziz Hamadi on 5/1/2023.
//

import UIKit
import StepperViewSwift

class DefaultExampleViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let data: [StepperModel.ViewModel] = [ StepperModel.ViewModel(title: "Which of the following is NOT a primary color of light?",
                                                                  type: .radiobox,
                                                                  responseList: [ ResponseItem(responseText: "Red"),
                                                                                  ResponseItem(responseText: "Green"),
                                                                                  ResponseItem(responseText: "Blue"),
                                                                                  ResponseItem(responseText: "Orange") ]),
                                          StepperModel.ViewModel(title: "Compared to their body weight, what animal is the strongest",
                                                                 type: .checkbox,
                                                                 resourceConfig: ResourceConfig(responseTitle: "You cannot choose more than two answers"),
                                                                 maxChecked: 2,
                                                                 responseList: [ResponseItem(responseText: "Dung Beetle",
                                                                                             image: "https://www.harmasjeanhenrifabre.fr/sites/harmas/files/styles/324x192/public/thumbnails/image/1440x550_bousier.jpg?itok=vt0weu2q&c=2dfde7f4925aa0d26bafa46c32335a87",
                                                                                             imageType: .presignedUrl),
                                                                                ResponseItem(responseText: "Elephant",
                                                                                             image: "https://cdn.britannica.com/02/152302-050-1A984FCB/African-savanna-elephant.jpg",
                                                                                             imageType: .presignedUrl),
                                                                                ResponseItem(responseText: "Cat",
                                                                                             image: "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
                                                                                             imageType: .presignedUrl),
                                                                                ResponseItem(responseText: "Cow",
                                                                                             image: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Cow_female_black_white.jpg/1280px-Cow_female_black_white.jpg",
                                                                                             imageType: .presignedUrl),
                                                                                ResponseItem(responseText: "Lion",
                                                                                             image: "https://www.larousse.fr/encyclopedie/data/images/1309528-Lion.jpg",
                                                                                             imageType: .presignedUrl)]),
                                           StepperModel.ViewModel(title: "Armando Maradona",
                                                                  description: "What was the first name of Argentinian soccer star Maradona?",
                                                                  type: .text,
                                                                  resourceConfig: ResourceConfig(responseTitle: "first character is 'D'",
                                                                                                 responsePlaceholder: "Name")),
                                           StepperModel.ViewModel(title: "Geography",
                                                                  description: "Sort in ascending order countries by population density",
                                                                  type: .ranking,
                                                                  responseList: [ ResponseItem(responseText: "Monaco"),
                                                                                  ResponseItem(responseText: "Bahrain"),
                                                                                  ResponseItem(responseText: "Tunisia"),
                                                                                  ResponseItem(responseText: "Benin"),
                                                                                  ResponseItem(responseText: "Singapore"),
                                                                                  ResponseItem(responseText: "Macau") ]),
                                           StepperModel.ViewModel(title: "Describe your profile",
                                                                  description: """
A short 3-5 sentence paragraph that summarizes your career. It covers your main achievements, skills and years of experience
""",
                                                                  type: .textarea,
                                                                  resourceConfig: ResourceConfig(responsePlaceholder: "Short description"))]

    @IBOutlet var stepperView: Stepper! {
        didSet {
            stepperView.defaultDataSource = self
            stepperView.defaultDelegate = self
        }
    }
    
    @IBAction func previousAction(_ sender: Any) {
        stepperView.previousStepper()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if stepperView.isLastStepper() {
            stepperView.reloadData()
            print("last stepper item")
        } else {
            stepperView.nextStepper()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension DefaultExampleViewController: DefaultStepperDataSource {
    func numberOfRowsInStepper() -> Int {
        return data.count
    }
    
    func stepper(dataForRowAtIndexPath indexPath: NSIndexPath) -> StepperModel.ViewModel? {
        return data[indexPath.row]
    }
}
extension DefaultExampleViewController: DefaultStepperDelegate {
    func resultStepper(dataAtIndexPath indexPath: NSIndexPath, data: StepperModel.RequestModel?) {
        print("Index of default stepper data : \(indexPath.row)")
        print("data : \(String(describing: data))")
    }
}
