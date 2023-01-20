//
//  ResponseTableViewCell.swift
//  StepperView
//
//  Created by Aziz Hamadi on 16/1/2023.
//

import UIKit

class ResponseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.layer.shadowOffset = CGSize(width: 1, height: 1)
            mainView.layer.shadowRadius = 5
            mainView.layer.shadowColor = UIColor.black.cgColor
            mainView.layer.shadowOpacity = 0.1
            mainView.layer.cornerRadius = 25
            mainView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var actionIconView: UIView!
    @IBOutlet weak var actionIcon: UIImageView!
    @IBOutlet weak var leadingActionIcon: NSLayoutConstraint!
    @IBOutlet weak var widthActionIcon: NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var topResponseStackView: NSLayoutConstraint!
    @IBOutlet weak var imageResponseView: UIView!
    @IBOutlet weak var imageResponse: UIImageView! {
        didSet {
            imageResponse.layer.cornerRadius = 8
            imageResponse.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var textResponse: UILabel!
    var actionIconColor: UIColor = .systemBlue {
        didSet {
            actionIcon.tintColor = actionIconColor
            separatorView.backgroundColor = actionIconColor
        }
    }
    var checkedIcon = UIImage(named: "radiobox_checked", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    var uncheckedIcon = UIImage(named: "radiobox", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    var responseItem: ResponseItem?
    var steppertype: Steppertype?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func createResponse(responseItem: ResponseItem?, steppertype: Steppertype?, actionIconColor: UIColor) {
        self.actionIconColor = actionIconColor
        self.steppertype = steppertype
        self.responseItem = responseItem
        if let image = responseItem?.image {
            imageResponseView.isHidden = false
            switch responseItem?.imageType {
                case .assets:
                    imageResponse.image = UIImage(named: image)
                case .presignedUrl:
                    imageResponse.load(from: image)
                default:
                    imageResponse.image = UIImage(systemName: image)
            }
        }
        textResponse.text = responseItem?.responseText
        separatorView.isHidden = true
        switch steppertype {
            case .ranking:
                uncheckedIcon = UIImage(named: "arrow.up.and.down.and.arrow.left.and.right", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                separatorView.isHidden = false
            case .checkbox:
                checkedIcon = UIImage(named: "checkbox_checked", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                uncheckedIcon = UIImage(named: "checkbox", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
            default:
                checkedIcon = UIImage(named: "radiobox_checked", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
                uncheckedIcon = UIImage(named: "radiobox", in: Bundle(for: ResponseTableViewCell.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        }
        actionIcon.image = uncheckedIcon
    }
    func toggleItemAction() {
        UIImpactFeedbackGenerator.init(style: .medium).impactOccurred()
        actionIcon.image = actionIcon.image == checkedIcon ? uncheckedIcon : checkedIcon
    }
}
