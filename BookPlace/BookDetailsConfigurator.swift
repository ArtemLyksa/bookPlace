//
//  BookDetailsConfigurator.swift
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

extension BookDetailsViewController: BookDetailsPresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    router.passDataToNextScene(segue: segue)
  }
}

extension BookDetailsInteractor: BookDetailsViewControllerOutput
{
}

extension BookDetailsPresenter: BookDetailsInteractorOutput
{
}

class BookDetailsConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = BookDetailsConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: BookDetailsViewController)
  {
    let router = BookDetailsRouter()
    router.viewController = viewController
    
    let presenter = BookDetailsPresenter()
    presenter.output = viewController
    
    let interactor = BookDetailsInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
