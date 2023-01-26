//
//  ExampleStepperItem.swift
//  StepperViewSwiftExample
//
//  Created by Aziz Hamadi on 9/1/2023.
//

import UIKit

class ExampleStepperItem: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: ExampleStepperItem.self)
        if let viewToAdd = bundle.loadNibNamed("ExampleStepperItem", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func createCustomView(index: Int) {
        titleLabel.text = "Custom Item \(index)"
    }
}
