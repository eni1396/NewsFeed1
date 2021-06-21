//
//  Extension + UIView.swift
//  NewsFeed
//
//  Created by Nikita Entin on 15.06.2021.
//

import Foundation
import UIKit

extension UIView {
    public func add(_ views: [UIView]) -> UIView {
        views.forEach {
            self.addSubview($0)
        }
        return self
    }
}
