//
//  StepperViewItem.swift
//  StepperView
//
//  Created by Aziz Hamadi on 16/1/2023.
//

import UIKit

class StepperViewItem: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    private func commonInit() {
        let bundle = Bundle.init(for: StepperViewItem.self)
        if let viewToAdd = bundle.loadNibNamed("StepperViewItem", owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    @IBOutlet weak var circleStepperView: UIView! {
        didSet {
            circleStepperView.layer.cornerRadius = circleStepperView.frame.height / 2
            circleStepperView.layer.borderColor = circleBorderColor.cgColor
            circleStepperView.layer.borderWidth = 2
            circleStepperView.layer.masksToBounds = false
            circleStepperView.clipsToBounds = true
            circleStepperView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var heightCircleStepperView: NSLayoutConstraint! {
        didSet {
            
        }
    }
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var checkMark: UIImageView! {
        didSet {
            checkMark.tintColor = .systemGray6
        }
    }
    @IBOutlet weak var linearStepperView: UIView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var questionBody: UIStackView!
    @IBOutlet weak var questionDescription: UILabel!
    @IBOutlet weak var questionImage: UIImageView! {
        didSet {
            questionImage.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var responseTitleLabel: UILabel!
    @IBOutlet weak var responseTFView: UIView! {
        didSet {
            responseTFView.layer.shadowOffset = CGSize(width: 1, height: 1)
            responseTFView.layer.shadowRadius = 5
            responseTFView.layer.shadowColor = UIColor.black.cgColor
            responseTFView.layer.shadowOpacity = 0.1
            responseTFView.layer.cornerRadius = 12
            responseTFView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var responseTF: UITextField!
    @IBOutlet weak var responseTVView: UIView! {
        didSet {
            responseTVView.layer.shadowOffset = CGSize(width: 1, height: 1)
            responseTVView.layer.shadowRadius = 5
            responseTVView.layer.shadowColor = UIColor.black.cgColor
            responseTVView.layer.shadowOpacity = 0.1
            responseTVView.layer.cornerRadius = 12
            responseTVView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var responseTableView: UITableView! {
        didSet {
            responseTableView.register(UINib(nibName: "ResponseTableViewCell", bundle: nil), forCellReuseIdentifier: "ResponseTableViewCell")
            responseTableView.dataSource = self
            responseTableView.delegate = self
            responseTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
            responseTableView.dragInteractionEnabled = false
            responseTableView.dragDelegate = self
            responseTableView.dropDelegate = self
        }
    }
    @IBOutlet weak var widthLinearStepperView: NSLayoutConstraint!
    @IBOutlet weak var hightResponseTableView: NSLayoutConstraint!
    var isCustomStepperView = false
    var titleFont = UIFont(name: "Futura Medium", size: 20) {
        didSet {
            questionTitle.font = titleFont!
        }
    }
    var titleColor: UIColor = .black {
        didSet {
            questionTitle.textColor = titleColor
        }
    }
    var descriptionFont = UIFont(name: "Futura Medium", size: 17) {
        didSet {
            questionDescription.font = descriptionFont
        }
    }
    var descriptionColor: UIColor = .darkGray {
        didSet {
            questionDescription.textColor = descriptionColor
        }
    }
    var widthLinearStepper: Int = 3 {
        didSet {
            widthLinearStepperView.constant = CGFloat(widthLinearStepper)
        }
    }
    var heightCircleView: Int = 42 {
        didSet {
            heightCircleStepperView.constant = CGFloat(heightCircleView)
            if !isCustomRadius {
                radiusCercleView = CGFloat(heightCircleView) / 2
            }
        }
    }
    var isCustomRadius = false
    var pendingCircleColor: UIColor! {
        didSet {
            
        }
    }
    var circleBorderColor: UIColor = .blue {
        didSet {
            if circleColor == nil {
                circleColor = circleBorderColor
            }
            circleStepperView.layer.borderColor = circleBorderColor.cgColor
            linearStepperView.backgroundColor = circleBorderColor
            questionNumber.textColor = circleBorderColor
        }
    }
    var circleColor: UIColor! {
        didSet {
            circleStepperView.backgroundColor = circleColor
        }
    }
    var isSelected = false {
        didSet {
            questionTitle.alpha = isSelected ? 1 : ( isPending ? 0.3 : 0.5)
            UIView.animate(withDuration: isSelected ? 1 : 0.2, delay: 0,
                           options: [],
                           animations: {
                self.questionBody.alpha = self.isSelected ? 1 : 0
            },completion: nil)
            UIView.animate(withDuration: isSelected ? 1 : 0.7 ,
                           delay: 0.0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
                self.questionBody.isHidden = !self.isSelected
            },completion: nil)
        }
    }
    var isFinished = false {
        didSet {
            if isFinished {
                questionNumber.isHidden = true
                checkMark.isHidden = false
                circleStepperView.backgroundColor = circleColor
                circleStepperView.layer.borderColor = UIColor.clear.cgColor
            } else {
                questionNumber.isHidden = false
                checkMark.isHidden = true
                circleStepperView.backgroundColor = .clear
                circleStepperView.layer.borderColor = circleBorderColor.cgColor
            }
        }
    }
    var isPending = true {
        didSet {
            linearStepperView.alpha = isPending ? 0.5 : 1
            circleStepperView.alpha = isPending ? 0.5 : 1
            questionTitle.alpha = isSelected ? 1 : ( isPending ? 0.3 : 0.5)
        }
    }
    var iconCercleStepper: UIImage = UIImage(systemName: "checkmark")!.withRenderingMode(.alwaysTemplate) {
        didSet {
            checkMark.image = iconCercleStepper
            checkMark.image = checkMark.image?.withRenderingMode(.alwaysTemplate)
        }
    }
    var iconColorCercleStepper: UIColor = .white {
        didSet {
            checkMark.tintColor = iconColorCercleStepper
        }
    }
    var radiusCercleView: CGFloat = 21 {
        didSet {
            circleStepperView.layer.cornerRadius = radiusCercleView
        }
    }
    var actionIconColor: UIColor = .systemBlue
    var stepperData: StepperModel.viewModel?
    var selectedIndex: [Int] = []
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    self.hightResponseTableView.constant = newsize.height
                }
            }
        }
    }
    func createStepper(stepperData: StepperModel.viewModel? = nil, index: Int, isSelected: Bool, stepperBody: UIView? = nil, title: String? = nil) {
        questionNumber.text = index.description
        questionTitle.alpha = isSelected ? 1 : ( isPending ? 0.3 : 0.5)
        linearStepperView.alpha = isPending ? 0.5 : 1
        circleStepperView.alpha = isPending ? 0.5 : 1
        circleStepperView.tag = index
        self.isSelected = isSelected
        isPending = !isSelected
        circleStepperView.alpha = isSelected ? 1 : 0.5
        circleStepperView.backgroundColor = .clear
        questionBody.isHidden = !isSelected
        if let stepperBody {
            questionBody.arrangedSubviews.forEach { view in
                view.removeFromSuperview()
            }
            questionBody.addArrangedSubview(stepperBody)
            questionTitle.text = title
        } else if let stepperData {
            createDefaultStepper(stepperData: stepperData)
        }
    }
    func createDefaultStepper(stepperData: StepperModel.viewModel) {
        responseTFView.isHidden = true
        responseTVView.isHidden = true
        responseTableView.isHidden = true
        self.stepperData = stepperData
        questionTitle.text = stepperData.title
        questionDescription.text = stepperData.description
        questionDescription.isHidden = stepperData.description?.isEmpty ?? true
        questionImage.isHidden = true
        responseTitleLabel.text = stepperData.resourceConfig?.responseTitle
        responseTitleLabel.isHidden = stepperData.resourceConfig?.responseTitle?.isEmpty ?? true
        switch stepperData.type {
            case .text:
                responseTFView.isHidden = false
                responseTF.placeholder = stepperData.resourceConfig?.responsePlaceholder
            case .textarea:
                responseTVView.isHidden = false
                if let placeholder = stepperData.resourceConfig?.responsePlaceholder {
                    addPlaceholder(placeholder: placeholder)
                }
            default:
                responseTableView.isHidden = false
                responseTableView.dragInteractionEnabled = stepperData.type == .ranking
                responseTableView.allowsSelection = stepperData.type != .ranking
        }
    }
    private func addPlaceholder(placeholder: String) {
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholder
        placeholderLabel.font = responseTextView.font!
        placeholderLabel.sizeToFit()
        responseTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (responseTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.isHidden = !responseTextView.text.isEmpty
        responseTextView.delegate = self
    }
    func toggle(isSelected: Bool, isPending: Bool, isFinished: Bool) {
        self.isSelected = isSelected
        self.isPending = isPending
        self.isFinished = isFinished
    }
    func stepperResultData() -> StepperModel.requestModel {
        let responseList = stepperData?.type == .ranking ? stepperData?.responseList : stepperData?.responseList?.filter{ $0.checked ?? false }
        let responseText = stepperData?.type == .text ? responseTF.text : responseTextView.text
        return StepperModel.requestModel(type: stepperData?.type, responseText: responseText, responseList: responseList)
    }
    func customViewFromStepper() -> UIView? {
        return questionBody.arrangedSubviews.first
    }
}
extension StepperViewItem: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepperData?.responseList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResponseTableViewCell", for: indexPath) as! ResponseTableViewCell
        cell.createResponse(responseItem: stepperData?.responseList?[indexPath.item], steppertype: stepperData?.type, actionIconColor: actionIconColor)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var isEnabled = true
        if stepperData?.type != .ranking {
            if !selectedIndex.isEmpty && stepperData?.type == .radiobox && indexPath.item != selectedIndex.first ?? 0 {
                let checked = !(stepperData?.responseList?[selectedIndex.first ?? 0].checked ?? false)
                stepperData?.responseList?[selectedIndex.first ?? 0].checked = checked
                let cell = tableView.cellForRow(at: IndexPath(row: selectedIndex.first ?? 0, section: 0)) as! ResponseTableViewCell
                cell.toggleItemAction()
                selectedIndex.removeAll()
            }
            if stepperData?.type == .checkbox
                && selectedIndex.count == stepperData?.maxChecked ?? (stepperData?.responseList?.count ?? 0)
                && selectedIndex.filter({ $0 == indexPath.item }).count == 0 {
                isEnabled = false
            }
            if isEnabled {
                if let index = selectedIndex.firstIndex(where: {$0 == indexPath.item}) {
                    selectedIndex.remove(at: index)
                } else {
                    selectedIndex.append(indexPath.item)
                }
                let cell = tableView.cellForRow(at: indexPath) as! ResponseTableViewCell
                cell.toggleItemAction()
                let checked = !(stepperData?.responseList?[indexPath.item].checked ?? false)
                stepperData?.responseList?[indexPath.item].checked = checked
            }
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if var stepperData {
            let mover = stepperData.responseList!.remove(at: sourceIndexPath.row)
            stepperData.responseList!.insert(mover, at: destinationIndexPath.row)
            self.stepperData = stepperData
        }
    }
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        UIImpactFeedbackGenerator.init(style: .heavy).impactOccurred()
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil { // Drag originated from the same app.
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}
extension StepperViewItem: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let placeholderLabel = textView.subviews.filter({$0 is UILabel}).first as? UILabel
        placeholderLabel?.isHidden = !textView.text.isEmpty
    }
}
