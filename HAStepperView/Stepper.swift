//
//  StepperScrollView.swift
//  StepperView
//
//  Created by Aziz Hamadi on 4/1/2023.
//

import UIKit

public protocol StepperDataSource: AnyObject {
    func numberOfRowsInStepper() -> Int
    func stepper(cellForRowAtIndexPath indexPath: NSIndexPath) -> UIView?
    func stepper(dataForRowAtIndexPath indexPath: NSIndexPath) -> StepperModel.viewModel?
    func titleStepper(cellForRowAtIndexPath indexPath: NSIndexPath) -> String?
}
public protocol StepperDelegate: AnyObject {
    func resultStepper(dataAtIndexPath indexPath: NSIndexPath, data: StepperModel.requestModel?)
    func stepperCustomView(viewAtIndexPath indexPath: NSIndexPath, view: UIView?)
}
@IBDesignable public class Stepper: UIView {
    override init(frame: CGRect) {
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
    open override func prepareForInterfaceBuilder() {
        let data: [StepperModel.viewModel] = [
            StepperModel.viewModel(title: "Stepper Title 1", type: .textarea),
            StepperModel.viewModel(title: "Stepper Title 2", type: .textarea, resourceConfig:
                                    ResourceConfig(responseTitle: "Short answer*", responsePlaceholder: "placeholder text")),
            StepperModel.viewModel(title: "Stepper Title 3", type: .text)]
        for i in 0...(data.count - 1) {
            let stepperViewItem = createStepperViewForInterfaceBuilder(index: i, data: data[i], count: data.count)
            mainStackView.addArrangedSubview(stepperViewItem)
        }
    }
    private func createStepperViewForInterfaceBuilder(index: Int, data: StepperModel.viewModel, count: Int) -> StepperViewItem {
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
    @IBInspectable var widthLinearStepperView: Int = 3
    @IBInspectable var heightCircleView: Int = 42
    @IBInspectable var radiusCercleView: CGFloat = 21 {
        didSet {
            isCustomRadius = true
        }
    }
    @IBInspectable var circleColor: UIColor = .systemBlue {
        didSet {
            isDefaultCircleColor = false
        }
    }
    @IBInspectable var borderCircleColor: UIColor = .systemBlue {
        didSet {
            if isDefaultCircleColor {
                circleColor = borderCircleColor
            }
        }
    }
    @IBInspectable var enableCircleInteraction: Bool = true
    @IBInspectable var iconCercleView: UIImage = UIImage(named: "checkmark", in: Bundle(for: Stepper.self), compatibleWith: nil)!
    @IBInspectable var iconColorCercle: UIColor = .white
    @IBInspectable var isCustomStepperView: Bool = false {
        didSet {
            if !isCustomStepperView {
            }
        }
    }
    public var titleFont: UIFont = .systemFont(ofSize: 20)
    public var titleColor: UIColor = .black
    public var descriptionFont: UIFont = .systemFont(ofSize: 17)
    public var descriptionColor: UIColor = .darkGray
    public var actionIconColor: UIColor = .systemBlue
    private var isDefaultCircleColor = true
    private var isCustomRadius = false

    public weak var dataSource: StepperDataSource? {
        didSet {
            mainStackView.arrangedSubviews.forEach { view in
                view.removeFromSuperview()
            }
            numberOfRowsInStepper = dataSource?.numberOfRowsInStepper() ?? 0
            for i in 0...numberOfRowsInStepper-1 {
                mainStackView.addArrangedSubview(createStepperView(index: i))
            }
        }
    }
    public weak var delegate: StepperDelegate?
    private var numberOfRowsInStepper: Int = 0
    private var selectedStepperIndex = 1
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    @objc func dismissKeyboard() {
        scrollView.endEditing(true)
    }
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
        stepperViewItem.isCustomStepperView = isCustomStepperView
        if isCustomRadius {
            stepperViewItem.radiusCercleView = radiusCercleView
            stepperViewItem.isCustomRadius = isCustomRadius
        }
        let view = dataSource?.stepper(cellForRowAtIndexPath: NSIndexPath(row: index, section: 0))
        let data = dataSource?.stepper(dataForRowAtIndexPath: NSIndexPath(row: index, section: 0))
        let title = dataSource?.titleStepper(cellForRowAtIndexPath: NSIndexPath(row: index, section: 0))
        stepperViewItem.createStepper(stepperData: data, index: index+1, isSelected: index == 0, stepperBody: view, title: title)
        stepperViewItem.linearStepperView.isHidden = index == numberOfRowsInStepper-1
        stepperViewItem.isUserInteractionEnabled = enableCircleInteraction
        stepperViewItem.circleStepperView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleStepperView(_:))))
        return stepperViewItem
    }
    public func numberOfStepper() -> Int {
        return numberOfRowsInStepper
    }
    public func selectedIndex() -> Int {
        return selectedStepperIndex
    }
    public func customViewFromStepper(indexPath: IndexPath) -> UIView? {
        return (mainStackView.arrangedSubviews[indexPath.row] as! StepperViewItem).customViewFromStepper()
    }
    @objc func toggleStepperView(_ sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            if selectedStepperIndex != index {
                if isCustomStepperView {
                    stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         view: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).customViewFromStepper())
                } else {
                    resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                         data: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).stepperResultData())
                }
                (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).toggle(isSelected: false, isPending: false, isFinished: true)
                (mainStackView.arrangedSubviews[index-1] as! StepperViewItem).toggle(isSelected: true, isPending: false, isFinished: false)
                selectedStepperIndex = index
            }
        }
    }
    public func nextStepper() {
        if selectedStepperIndex < numberOfRowsInStepper {
            if isCustomStepperView {
                stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                     view: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).customViewFromStepper())
            } else {
                resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                     data: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).stepperResultData())
            }
            (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).toggle(isSelected: false, isPending: false, isFinished: true)
            (mainStackView.arrangedSubviews[selectedStepperIndex] as! StepperViewItem).toggle(isSelected: true, isPending: false, isFinished: false)
            selectedStepperIndex += 1
        } else {
            (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).toggle(isSelected: true, isPending: false, isFinished: true)
            if isCustomStepperView {
                stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                     view: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).customViewFromStepper())
            } else {
                resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex-1, section: 0),
                                     data: (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).stepperResultData())
            }
        }
    }
    public func previousStepper() {
        if selectedStepperIndex-1 > 0 {
            selectedStepperIndex -= 1
            if isCustomStepperView {
                stepperCustomView(indexPath: NSIndexPath(row: selectedStepperIndex, section: 0),
                                     view: (mainStackView.arrangedSubviews[selectedStepperIndex] as! StepperViewItem).customViewFromStepper())
            } else {
                resultDataForStepper(indexPath: NSIndexPath(row: selectedStepperIndex, section: 0),
                                     data: (mainStackView.arrangedSubviews[selectedStepperIndex] as! StepperViewItem).stepperResultData())
            }
            (mainStackView.arrangedSubviews[selectedStepperIndex] as! StepperViewItem).toggle(isSelected: false, isPending: false, isFinished: true)
            (mainStackView.arrangedSubviews[selectedStepperIndex-1] as! StepperViewItem).toggle(isSelected: true, isPending: false, isFinished: false)
        }
    }
    public func isLastStepper() -> Bool {
        return selectedStepperIndex == numberOfRowsInStepper
    }
    private func resultDataForStepper(indexPath: NSIndexPath, data: StepperModel.requestModel?) {
        delegate?.resultStepper(dataAtIndexPath: indexPath,
                                data: data)
    }
    private func stepperCustomView(indexPath: NSIndexPath, view: UIView?) {
        delegate?.stepperCustomView(viewAtIndexPath: indexPath, view: view)
    }
}
