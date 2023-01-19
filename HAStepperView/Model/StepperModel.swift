//
//  StepperModel.swift
//  StepperView
//
//  Created by Aziz Hamadi on 16/1/2023.
//

enum Steppertype {
    case text
    case textarea
    case radiobox
    case checkbox
    case ranking
}
struct StepperModel {
    struct viewModel {
        var title: String
        var description: String?
        var type: Steppertype
        var resourceConfig: ResourceConfig?
        var maxChecked: Int?
        var responseList: [ResponseItem]?
    }
    struct requestModel {
        var type: Steppertype?
        var responseText: String?
        var responseList: [ResponseItem]?
    }
}
struct ResourceConfig {
    var responseTitle: String?
    var responsePlaceholder: String?
}
enum ImageType {
    case assets
    case system
    case presignedUrl
}
struct ResponseItem {
    var responseText: String?
    var image: String?
    var imageType: ImageType?
    var checked: Bool?
}
