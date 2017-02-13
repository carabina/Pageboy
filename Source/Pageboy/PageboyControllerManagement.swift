//
//  PageboyControllerManagement.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

internal extension PageboyViewController {
    
    internal func reloadPages(reloadViewControllers: Bool = true) {
        
        if reloadViewControllers || self.viewControllers == nil {
            self.viewControllers = self.dataSource?.viewControllers(forPageboyViewController: self)
        }
        let defaultIndex = self.dataSource?.defaultPageIndex(forPageboyViewController: self) ?? 0
        
        guard defaultIndex < self.viewControllers?.count ?? 0,
            let viewController = self.viewControllers?[defaultIndex] else {
                return
        }
        
        self.currentPageIndex = defaultIndex
        self.pageViewController.setViewControllers([viewController],
                                                   direction: .forward,
                                                   animated: false,
                                                   completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource, PageboyViewControllerDataSource
extension PageboyViewController: UIPageViewControllerDataSource, PageboyViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = self.viewControllers else {
            return nil
        }
        
        if let index = viewControllers.index(of: viewController), index != 0 {
            return viewControllers[index - 1]
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllers = self.viewControllers else {
            return nil
        }
        
        if let index = viewControllers.index(of: viewController), index != viewControllers.count - 1 {
            return viewControllers[index + 1]
        }
        return nil
    }
    
    // MARK: PageboyViewControllerDataSource
    
    open func viewControllers(forPageboyViewController pageboyViewController: PageboyViewController) -> [UIViewController]? {
        return nil
    }
    
    open func defaultPageIndex(forPageboyViewController pageboyViewController: PageboyViewController) -> Int {
        return 0
    }
}
