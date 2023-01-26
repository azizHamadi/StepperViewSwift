//
//  UIImageView.swift
//  StepperViewSwift
//
//  Created by Aziz Hamadi on 16/1/2023.
//

import UIKit

extension UIImageView {
    func load(from link: String) {
        guard let url = URL(string: link) else { return }
        load(from: url)
    }
    func load(from url: URL) {
        URLSession.shared.configuration.timeoutIntervalForRequest = .infinity
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
