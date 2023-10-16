//
//  CardVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import UIKit

protocol CardPVCInput: AnyObject {
    var coordinator: CardCoordinatorProtocol! {get set}
}

class CardPVC: UIPageViewController {
    weak var coordinator: CardCoordinatorProtocol!
    var interactor: CardInteractorInput!
    var pages: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pages = [MainInfoVC(), ListOfWorksVC(),
                 HistoricalBackgroundVC(), AdditionalInfoVC()]
        setViewControllers([pages[0]], direction: .forward, animated: true)
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
    }
    
    deinit {
        print("deinit CardPVC")
    }

}

extension CardPVC: CardPVCInput {

    
}

extension CardPVC: UIPageViewControllerDataSource {
    
    var pagesAmount: Int {
        return pages.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = (currentIndex + pagesAmount - 1) % pagesAmount
        return pages[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextVCIndex = (currentIndex + 1) % pagesAmount
        return pages[nextVCIndex]
    }


}
