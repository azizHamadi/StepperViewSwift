//
//  StepperModel.swift
//  StepperView
//
//  Created by Aziz Hamadi on 16/1/2023.
//

public enum Steppertype {
    case text
    case textarea
    case radiobox
    case checkbox
    case ranking
}
public struct StepperModel {
    public struct viewModel {
        public var title: String
        public var description: String?
        public var type: Steppertype
        public var resourceConfig: ResourceConfig?
        public var maxChecked: Int?
        public var responseList: [ResponseItem]?
        public init(title: String, description: String? = nil, type: Steppertype, resourceConfig: ResourceConfig? = nil, maxChecked: Int? = nil, responseList: [ResponseItem]? = nil) {
            self.title = title
            self.description = description
            self.type = type
            self.resourceConfig = resourceConfig
            self.maxChecked = maxChecked
            self.responseList = responseList
        }
    }
    public struct requestModel {
        public var type: Steppertype?
        public var responseText: String?
        public var responseList: [ResponseItem]?
        public init(type: Steppertype? = nil, responseText: String? = nil, responseList: [ResponseItem]? = nil) {
            self.type = type
            self.responseText = responseText
            self.responseList = responseList
        }
    }
}
public struct ResourceConfig {
    public var responseTitle: String?
    public var responsePlaceholder: String?
    public init(responseTitle: String? = nil, responsePlaceholder: String? = nil) {
        self.responseTitle = responseTitle
        self.responsePlaceholder = responsePlaceholder
    }
}
public enum ImageType {
    case assets
    case system
    case presignedUrl
}
public struct ResponseItem {
    public var responseText: String?
    public var image: String?
    public var imageType: ImageType?
    public var checked: Bool?
    public init(responseText: String? = nil, image: String? = nil, imageType: ImageType? = nil, checked: Bool? = nil) {
        self.responseText = responseText
        self.image = image
        self.imageType = imageType
        self.checked = checked
    }
}
