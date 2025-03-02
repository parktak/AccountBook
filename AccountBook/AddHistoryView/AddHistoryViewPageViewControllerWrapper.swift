//
//  AddHistoryViewPageViewControllerWrapper.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/02.
//

import Foundation
import SwiftUI

struct AddHistoryViewPageViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var page: Int
    
    init(page: Binding<Int>) {
        self._page = page
    }
    
    func makeUIViewController(context: Context) -> PageViewController {
        DIContainer.getPageViewController(delegate: context.coordinator)
    }
    
    func makeCoordinator() -> AddHistoryViewPageCoordinator {
        return AddHistoryViewPageCoordinator(currentPage: _page)
    }
    
    func updateUIViewController(_ uiViewController: PageViewController, context: Context) {
        let viewControllers = context.coordinator.viewControllers
        
        let direction: UIPageViewController.NavigationDirection
        
        if let prevVc = uiViewController.viewControllers?.first, let index = viewControllers.firstIndex(of: prevVc) {
            
            direction = page < index ? .forward : .reverse
            
        } else {
            direction = .forward
        }
        
        uiViewController.setViewControllers([viewControllers[page]], direction: direction, animated: context.coordinator.withAnimated)
    }
    
    typealias UIViewControllerType = PageViewController
    
}

class AddHistoryViewPageCoordinator: PageViewControllerDatasource {

    @Binding var currentPage: Int
    private(set) var withAnimated = false
    
    init(currentPage: Binding<Int>) {
        self._currentPage = currentPage
    }
    
    func didChangePage(_ index: Int) {
        setCurrentPage(index, animated: true)
    }
    
    func getCurrentIndex() -> Int {
        self.currentPage
    }
    
    func rollBackPage(_ index: Int) {
        setCurrentPage(index, animated: false)
    }
    
    private func setCurrentPage(_ index: Int, animated: Bool) {
        self.currentPage = index
        self.withAnimated = animated
    }
    
    lazy var viewControllers: [UIViewController] = {
        [UIHostingController(rootView: SpendingView()),
         UIHostingController(rootView: IncomingView()),
         UIHostingController(rootView: TransferView())
         ]
    }()
}
