//
//  AccountConfigurator.swift
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

extension AccountViewController: AccountPresenterOutput
{
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    router.passDataToNextScene(segue: segue)
  }
}

extension AccountInteractor: AccountViewControllerOutput
{
}

extension AccountPresenter: AccountInteractorOutput
{
}

class AccountConfigurator
{
  // MARK: - Object lifecycle
  
  static let sharedInstance = AccountConfigurator()
  
  private init() {}
  
  // MARK: - Configuration
  
  func configure(viewController: AccountViewController)
  {
    let router = AccountRouter()
    router.viewController = viewController
    
    let presenter = AccountPresenter()
    presenter.output = viewController
    
    let interactor = AccountInteractor()
    interactor.output = presenter
    
    viewController.output = interactor
    viewController.router = router
  }
}
