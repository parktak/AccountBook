//
//  PageViewController.swift
//  AccountBook
//
//  Created by 박탁인 on 2025/03/02.
//

import UIKit
import SwiftUI


protocol PageViewControllerDatasource: AnyObject {
    var viewControllers: [UIViewController] { get }
    func didChangePage(_ index: Int)
    func rollBackPage(_ index: Int)
    func getCurrentIndex() -> Int
}

class PageViewController: UIPageViewController {

    weak var dataSourceDelegate: PageViewControllerDatasource?
    private var willMoveIndex: Int?
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.dataSource = self
        
        guard let dataSourceDelegate else {
            Logger.writeLog(message: "need set DataSource")
            return
        }
        currentPage = dataSourceDelegate.getCurrentIndex()
        
        setViewControllers([dataSourceDelegate.viewControllers[0]], direction: .forward, animated: true)
    }
}


extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = dataSourceDelegate?.viewControllers, let index = dataSourceDelegate?.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        var previousIndex = index - 1
        if previousIndex < 0 {
            previousIndex = viewControllers.count - 1
        }
        
        return viewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllers = dataSourceDelegate?.viewControllers, let index = dataSourceDelegate?.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        var nextIndex = index + 1
        if nextIndex >= viewControllers.count {
            nextIndex = 0
        }
        
        return viewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        guard
           let visibleViewController = pendingViewControllers.first,
           let index = dataSourceDelegate?.viewControllers.firstIndex(of: visibleViewController) else {
            return
        }
        
        willMoveIndex = index
        dataSourceDelegate?.didChangePage(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed, let willMoveIndex {
            currentPage = willMoveIndex
            
        } else {
            dataSourceDelegate?.rollBackPage(currentPage)
        }
        
        willMoveIndex = nil
    }
}
