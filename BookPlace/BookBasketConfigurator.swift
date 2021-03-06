//
//  BookBasketConfigurator.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/9/17.
//  Copyright (c) 2017 Artem Lyksa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension BookBasketViewController: BookBasketPresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    router.passDataToNextScene(segue: segue)
  }
}

extension BookBasketInteractor: BookBasketViewControllerOutput
{
}

extension BookBasketPresenter: BookBasketInteractorOutput
{
}

class BookBasketConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = BookBasketConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: BookBasketViewController)
  {
    let router = BookBasketRouter()
    router.viewController = viewController
    
    let presenter = BookBasketPresenter()
    presenter.output = viewController
    
    let interactor = BookBasketInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
