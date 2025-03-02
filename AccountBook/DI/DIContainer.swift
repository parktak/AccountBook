//
//  DIContainer.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/02.
//

import Foundation
import SwiftUI

class DIContainer {
    static func getPageViewController(delegate: PageViewControllerDatasource) -> PageViewController {
        let vc = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        vc.dataSourceDelegate = delegate
        return vc
    }
}
