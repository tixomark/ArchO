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
    private var closeButton: UIBarButtonItem!
    private var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    
    convenience init(viewControllers: [UIViewController]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pages = viewControllers
    }
    
    
    
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        self.dataSource = self
        self.delegate = self
        
        closeButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelButton))
        navigationItem.leftBarButtonItem = closeButton
        
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        navigationItem.rightBarButtonItem = doneButton
        
        setViewControllers([pages[0]], direction: .forward, animated: true)
    }
    
    deinit {
        print("deinit CardPVC")
    }
    
    @objc func didTapCancelButton() {
        coordinator.dismissModule()
    }
    
    @objc func didTapDoneButton() {
        interactor.loadCard()
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

extension CardPVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

    }
}

extension CardPVC: ResponderAction {
    func showPicker(_ sender: PickerProtocol) {
        switch sender {
        case is FilePicker:
            self.present((sender as! FilePicker).picker, animated: true)
        case is ImagePicker:
            self.present((sender as! ImagePicker).picker, animated: true)
        default:
            print("Some unknown picker")
        }
    }
}
