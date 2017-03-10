//
//  BookBasketPresenter.swift
//  BookPlace
//
//  Created by Artem Lyksa on 3/9/17.
//  Copyright (c) 2017 Artem Lyksa. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol BookBasketPresenterInput
{
  func presentSomething(response: BookBasket.Something.Response)
}

protocol BookBasketPresenterOutput: class
{
}

class BookBasketPresenter: BookBasketPresenterInput
{
  weak var output: BookBasketPresenterOutput!
  
  // MARK: - Presentation logic
  
  func presentSomething(response: BookBasket.Something.Response)
  {
    // NOTE: Format the response from the Interactor and pass the result back to the View Controller
  }
}