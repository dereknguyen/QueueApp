//
//  AlertService.swift
//  Queue
//
//  Created by Derek Nguyen on 10/22/19.
//  Copyright © 2019 Derek Nguyen. All rights reserved.
//

import UIKit

class AlertService {
    public static func loadingController(title: String, message: String) -> LoadingViewController {
        let storyboard = UIStoryboard(name: StoryboardID.loading, bundle: nil)
        let loadingViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerID.loading) as! LoadingViewController
        loadingViewController.setContent(title: title, message: message)
        return loadingViewController
    }
}
