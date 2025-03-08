//
//  AddHistoryViewPageViewControllerWrapper.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/02.
//

import Foundation
import SwiftUI

struct AddHistoryViewPageViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = PageViewController
    @Binding var page: Int
    var viewModel: AddHistoryViewModel
    
    func makeUIViewController(context: Context) -> PageViewController {
        DIContainer.getPageViewController(delegate: context.coordinator)
    }
    
    func makeCoordinator() -> AddHistoryViewPageCoordinator {
        return AddHistoryViewPageCoordinator(currentPage: _page, viewModel: viewModel)
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
    
    
}

class AddHistoryViewPageCoordinator: PageViewControllerDatasource {

    @Binding var currentPage: Int
    private(set) var withAnimated = false
    var viewModel: AddHistoryViewModel
    
    init(currentPage: Binding<Int>, viewModel: AddHistoryViewModel) {
        self._currentPage = currentPage
        self.viewModel = viewModel
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
        [UIHostingController(rootView:AddHistoryDIContainer.createSpendingView(viewModel)),
         UIHostingController(rootView: AddHistoryDIContainer.createIncomingView(viewModel)),
         UIHostingController(rootView: TransferView())
         ]
    }()
}
