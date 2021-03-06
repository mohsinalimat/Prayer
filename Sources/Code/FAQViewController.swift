//
//  FAQViewController.swift
//  Prayer
//
//  Created by Cihat Gündüz on 19.02.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import UIKit
import Imperio
import HandyUIKit

enum FAQAction {
    case doneButtonPressed
}

class FAQViewController: BrandedViewController, Coordinatable {
    // MARK: - Coordinatable Protocol Implementation

    typealias Action = FAQAction
    var coordinate: ((FAQAction) -> Void)!


    // MARK: - IBOutlets

    @IBOutlet var collectionView: UICollectionView!


    // MARK: - Stored Instance Properties

    private let l10n = L10n.Settings.Faq.self
    fileprivate let cellReuseIdentifier = "FAQCell"

    var viewModel: FAQViewModel! {
        didSet {
            if view != nil {
                collectionView.reloadData()
            }
        }
    }


    // MARK: - IBAction Methods

    @IBAction func doneButtonPressed() {
        coordinate(.doneButtonPressed)
    }


    // MARK: - View Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        title = l10n.title
        (collectionView.collectionViewLayout as! FAQCollectionViewLayout).delegate = self
    }
}


// MARK: - UICollectionViewDataSource Protocol Implementation

extension FAQViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.entries.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FAQCollectionViewCell

        cell.questionLabel.font = (collectionView.collectionViewLayout as! FAQCollectionViewLayout).questionLabelFont
        cell.answerLabel.font = (collectionView.collectionViewLayout as! FAQCollectionViewLayout).answerLabelFont

        cell.questionLabel.attributedText = viewModel.entries[indexPath.item].question.hyphenated()
        cell.answerLabel.attributedText = viewModel.entries[indexPath.item].answer.hyphenated()

        return cell
    }
}


// MARK: - FAQCollectionViewLayoutDelegate Protocol Implementation

extension FAQViewController: FAQCollectionViewLayoutDelegate {
    func question(at indexPath: IndexPath) -> String {
        return viewModel.entries[indexPath.item].question
    }

    func answer(at indexPath: IndexPath) -> String {
        return viewModel.entries[indexPath.item].answer
    }
}
