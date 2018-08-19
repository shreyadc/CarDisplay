//
//  CustomMapPopoverView.swift
//  Wunder
//
//  Created by Shreya Dutta Chowdhury on 18/08/18.
//  Copyright © 2018 Shreya. All rights reserved.
//

import UIKit

protocol CustomMapPopoverDelegate: class {
    func didTapCustomMapPopover(_ popover: CustomMapPopoverView?)
}

class CustomMapPopoverView: UIView {

    @IBOutlet weak var carNameLabel: UILabel!
    weak var delegate: CustomMapPopoverDelegate? = nil
    
    @IBAction func popoverTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTapCustomMapPopover(self)
    }
    
}
