//
//  StepperScrollView.swift
//  StepperViewSwift
//
//  Created by Aziz Hamadi on 4/1/2023.
//

import UIKit

public protocol CustomStepperDataSource: AnyObject {
    func numberOfRowsInStepper() -> Int
    func stepper(cellForRowAtIndexPath indexPath: NSIndexPath) -> UIView?
    func titleStepper(cellForRowAtIndexPath indexPath: NSIndexPath) -> String?
}
public protocol DefaultStepperDataSource: AnyObject {
    func numberOfRowsInStepper() -> Int
    func stepper(dataForRowAtIndexPath indexPath: NSIndexPath) -> StepperModel.ViewModel?
}
public protocol CustomStepperDelegate: AnyObject {
    func resultStepper(viewAtIndexPath indexPath: NSIndexPath, view: UIView?)
}
public protocol DefaultStepperDelegate: AnyObject {
    func resultStepper(dataAtIndexPath indexPath: NSIndexPath, data: StepperModel.RequestModel?)
}
@IBDesignable public class Stepper: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func commonInit() {
        self.frame = self.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView = UIScrollView(frame: self.bounds)
        self.addSubview(scrollView)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainStackView = UIStackView()
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    var scrollView: UIScrollView! {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            scrollView.addGestureRecognizer(tap)
        }
    }
    var mainStackView: UIStackView! {
        didSet {
            mainStackView.axis = .vertical
        }
    }
    @IBInspectable public var widthLinearStepperView: Int = 3 {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.widthLinearStepper = widthLinearStepperView
                }
            }
        }
    }
    @IBInspectable public var heightCircleView: Int = 42 {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.heightCircleView = heightCircleView
                }
            }
        }
    }
    @IBInspectable public var radiusCercleView: CGFloat = 21 {
        didSet {
            isCustomRadius = true
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.radiusCercleView = radiusCercleView
                }
            }
        }
    }
    @IBInspectable public var circleColor: UIColor = .systemBlue {
        didSet {
            isDefaultCircleColor = false
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.circleColor = circleColor
                }
            }
        }
    }
    @IBInspectable public var borderCircleColor: UIColor = .systemBlue {
        didSet {
            if isDefaultCircleColor {
                circleColor = borderCircleColor
            }
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.circleBorderColor = borderCircleColor
                }
            }
        }
    }
    @IBInspectable public var enableCircleInteraction: Bool = true {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.isUserInteractionEnabled = enableCircleInteraction
                }
            }
        }
    }
    @IBInspectable public var iconCercleView: UIImage = UIImage(named: "checkmark", in: Bundle(for: Stepper.self), compatibleWith: nil)! {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.iconCercleStepper = iconCercleView
                }
            }
        }
    }
    @IBInspectable public var iconColorCercle: UIColor = .white {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.iconColorCercleStepper = iconColorCercle
                }
            }
        }
    }
    public var titleFont: UIFont = .systemFont(ofSize: 20) {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.titleFont = titleFont
                }
            }
        }
    }
    public var titleColor: UIColor = .black {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.titleColor = titleColor
                }
            }
        }
    }
    public var descriptionFont: UIFont = .systemFont(ofSize: 17) {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.descriptionFont = descriptionFont
                }
            }
        }
    }
    public var descriptionColor: UIColor = .darkGray {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.descriptionColor = descriptionColor
                }
            }
        }
    }
    public var actionIconColor: UIColor = .systemBlue {
        didSet {
            if numberOfRowsInStepper > 0 {
                for stepperIndex in 0...numberOfRowsInStepper-1 {
                    (mainStackView.arrangedSubviews[stepperIndex] as? StepperViewItem)?.actionIconColor = actionIconColor
                }
            }
        }
    }
    private var isDefaultCircleColor = true
    private var isCustomRadius = false

    public weak var customDataSource: CustomStepperDataSource? {
        didSet {
            numberOfRowsInStepper = customDataSource?.numberOfRowsInStepper() ?? 0
            reloadData()
        }
    }
    public weak var defaultDataSource: DefaultStepperDataSource? {
        didSet {
            numberOfRowsInStepper = defaultDataSource?.numberOfRowsInStepper() ?? 0
            reloadData()
        }
    }
    public weak var customDelegate: CustomStepperDelegate?
    public weak var defaultDelegate: DefaultStepperDelegate?
    private var numberOfRowsInStepper: Int = 0
    private var selectedStepperIndex = 1

    private func createStepperView(index: Int) -> StepperViewItem {
        let stepperViewItem = StepperViewItem()
        stepperViewItem.circleColor = circleColor
        stepperViewItem.circleBorderColor = borderCircleColor
        stepperViewItem.heightCircleView = heightCircleView
        stepperViewItem.widthLinearStepper = widthLinearStepperView
        stepperViewItem.iconCercleStepper = iconCercleView
        stepperViewItem.iconColorCercleStepper = iconColorCercle
        stepperViewItem.titleColor = titleColor
        stepperViewItem.titleFont = titleFont
        stepperViewItem.descriptionFont = descriptionFont
        stepperViewItem.descriptionColor = descriptionColor
        stepperViewItem.actionIconColor = actionIconColor
        stepperViewItem.isCustomStepperView = customDelegate != nil
        if isCustomRadius {
            stepperViewItem.radiusCercleView = radiusCercleView
            stepperViewItem.isCustomRadius = isCustomRadius
        }
        let view = customDataSource?.stepper(cellForRowAtIndexPath: NSIndexPath(row: index, section: 0))
        let data = defaultDataSource?.stepper(dataForRowAtIndexPath: NSIndexPath(row: index, section: 0))
        let title = customDataSource?.titleStepper(cellForRowAtIndexPath: NSIndexPath(row: index, section: 0))
        stepperViewItem.createStepper(stepperData: data, index: index+1, isSelected: index == 0, stepperBody: view, title: title)
        stepperViewItem.linearStepperView.isHidden = index == numberOfRowsInStepper-1
        stepperViewItem.isUserInteractionEnabled = enableCircleInteraction
        stepperViewItem.circleStepperView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleStepperView(_:))))
        return stepperViewItem
    }
    public func reloadData() {
        mainStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        selectedStepperIndex = 1
        if numberOfRowsInStepper > 0 {
            for stepperIndex in 0...numberOfRowsInStepper-1 {
                mainStackView.addArrangedSubview(createStepperView(index: stepperIndex))
            }
            scrollView.layoutIfNeeded()
        }
    }
    public func numberOfStepper() -> Int {
        return numberOfRowsInStepper
    }
    public func selectedIndex() -> Int {
        return selectedStepperIndex
    }
    public func isLastStepper() -> Bool {
        return selectedStepperIndex == numberOfRowsInStepper
    }
    public func customViewFromStepper(indexPath: IndexPath) -> UIView? {
        return (mainStackView.arrangedSubviews[indexPath.row] as? StepperViewItem)?.customViewFromStepper()
    }
    @objc func toggleStepperView(_ sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            if selectedStepperIndex != index {
                if customDataSource != nil {
                    stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         view: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.customViewFromStepper())
                } else {
                    resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         data: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.stepperResultData())
                }
                (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.toggle(isSelected: false, isPending: false, isFinished: true)
                (mainStackView.arrangedSubviews[index-1] as? StepperViewItem)?.toggle(isSelected: true, isPending: false, isFinished: false)
                selectedStepperIndex = index
            }
        }
    }
    public func nextStepper() {
        if numberOfRowsInStepper > 0 {
            if selectedStepperIndex < numberOfRowsInStepper {
                if customDataSource != nil {
                    stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         view: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.customViewFromStepper())
                } else {
                    resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         data: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.stepperResultData())
                }
                (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.toggle(isSelected: false, isPending: false, isFinished: true)
                (mainStackView.arrangedSubviews[selectedStepperIndex] as? StepperViewItem)?.toggle(isSelected: true, isPending: false, isFinished: false)
                selectedStepperIndex += 1
            } else {
                (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.toggle(isSelected: true, isPending: false, isFinished: true)
                if customDataSource != nil {
                    stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         view: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.customViewFromStepper())
                } else {
                    resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         data: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.stepperResultData())
                }
            }
        }
    }
    public func previousStepper() {
        if numberOfRowsInStepper > 0 {
            if selectedStepperIndex-1 > 0 {
                selectedStepperIndex -= 1
                if customDataSource != nil {
                    stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex, section: 0),
                                         view: (mainStackView.arrangedSubviews[selectedStepperIndex] as? StepperViewItem)?.customViewFromStepper())
                } else {
                    resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex, section: 0),
                                         data: (mainStackView.arrangedSubviews[selectedStepperIndex] as? StepperViewItem)?.stepperResultData())
                }
                (mainStackView.arrangedSubviews[selectedStepperIndex] as? StepperViewItem)?.toggle(isSelected: false, isPending: false, isFinished: true)
                (mainStackView.arrangedSubviews[selectedStepperIndex-1] as? StepperViewItem)?.toggle(isSelected: true, isPending: false, isFinished: false)
            }
        }
    }
    private func resultDataForStepper(indexPath: NSIndexPath, data: StepperModel.RequestModel?) {
        defaultDelegate?.resultStepper(dataAtIndexPath: indexPath, data: data)
    }
    private func stepperCustomView(indexPath: NSIndexPath, view: UIView?) {
        customDelegate?.resultStepper(viewAtIndexPath: indexPath, view: view)
    }
}
extension Stepper {
    open override func prepareForInterfaceBuilder() {
        let data: [StepperModel.ViewModel] = [
            StepperModel.ViewModel(title: "Stepper Title 1", type: .textarea),
            StepperModel.ViewModel(title: "Stepper Title 2", type: .textarea, resourceConfig:
                                    ResourceConfig(responseTitle: "Short answer*", responsePlaceholder: "placeholder text")),
            StepperModel.ViewModel(title: "Stepper Title 3", type: .text)]
        for stepperIndex in 0...(data.count - 1) {
            let stepperViewItem = createStepperViewForInterfaceBuilder(index: stepperIndex, data: data[stepperIndex], count: data.count)
            mainStackView.addArrangedSubview(stepperViewItem)
        }
    }
    private func createStepperViewForInterfaceBuilder(index: Int, data: StepperModel.ViewModel, count: Int) -> StepperViewItem {
        let stepperViewItem = StepperViewItem()
        stepperViewItem.circleColor = circleColor
        stepperViewItem.circleBorderColor = borderCircleColor
        stepperViewItem.heightCircleView = heightCircleView
        stepperViewItem.widthLinearStepper = widthLinearStepperView
        stepperViewItem.iconCercleStepper = iconCercleView
        stepperViewItem.iconColorCercleStepper = iconColorCercle
        stepperViewItem.titleColor = titleColor
        stepperViewItem.titleFont = titleFont
        stepperViewItem.descriptionFont = descriptionFont
        stepperViewItem.descriptionColor = descriptionColor
        if isCustomRadius {
            stepperViewItem.radiusCercleView = radiusCercleView
            stepperViewItem.isCustomRadius = isCustomRadius
        }
        stepperViewItem.createStepper(stepperData: data, index: index+1, isSelected: index == 1, stepperBody: nil)
        stepperViewItem.linearStepperView.isHidden = index == count - 1
        stepperViewItem.linearStepperView.isHidden = index == count - 1
        if index == 0 {
            stepperViewItem.toggle(isSelected: false, isPending: false, isFinished: true)
        }
        return stepperViewItem
    }
}
extension Stepper {
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    @objc func dismissKeyboard() {
        scrollView.endEditing(true)
    }
}
