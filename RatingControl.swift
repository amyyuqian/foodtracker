//
//  RatingControl.swift
//  foodtracker
//
//  Created by Amy Qian on 1/11/17.
//  Copyright © 2017 Amy Qian. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    // MARK: properties
    private var ratingButtons = [UIButton] ()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    // MARK: initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: button action
    
    func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button \(button) is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // calculates the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // if the selected star represents the current rating, reset the rating to 0
            rating = 0
        } else {
            // otherwise set the rating to the selected star
            rating = selectedRating
        }
    }
    
    // MARK: private methods
    
    private func setupButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // load button images
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for index in 0..<starCount {
            
            // create the button
            let button = UIButton()
            
            // set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // set the accessibility label
            button.accessibilityLabel = "set \(index + 1) star rating"
            
            // setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // add the button to the stack
            addArrangedSubview(button)
            
            // add the new button to the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            // if the index of a button is less than the rating, the button should be selected
            button.isSelected = index < rating
            
            // set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "tap to reset the rating to zero"
            } else {
                hintString = nil
            }
            
            // calculate the value stirng
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "no rating set"
            case 1:
                valueString = "1 star set"
            default:
                valueString = "\(rating) stars set"
            }
            
            // assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
}
