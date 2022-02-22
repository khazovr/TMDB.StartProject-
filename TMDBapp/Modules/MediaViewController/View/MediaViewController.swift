//
//  ViewController.swift
//  TMDBapp
//
//  Created by 1 on 10.01.2022.
//

import UIKit


class MediaViewController: BaseViewController {
    
    @IBOutlet weak var mediaViewTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actorsNameLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nullButton: UIButton!
    
    let collectionViewCellHeightCoefficient: CGFloat = 0.85
    let collectionViewCellWidthCoefficient: CGFloat = 0.55
    let gradientFirstColor = UIColor(hex: "ff8181").cgColor
    let gradientSecondColor = UIColor(hex: "a81382").cgColor
    let cellsShadowColor = UIColor(hex: "2a002a").cgColor
    
    var actorsViewModel: [ActorsViewModel] = []
    var actorsCollectionViewCell: ActorsCollectionViewCell = ActorsCollectionViewCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        self.mediaViewTitleLabel.text = "Популярные актеры"
        self.mediaViewTitleLabel.textColor = .red
        self.nullButton.setTitle("О актёре", for: .normal)
        self.nullButton.setTitleColor(.white, for: .normal)
        self.nullButton.backgroundColor = .red
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    private func configureCollectionView() {
        let gravitySliderLayout = GravitySliderFlowLayout(with: CGSize(width: collectionView.frame.size.height * collectionViewCellWidthCoefficient, height: collectionView.frame.size.height * collectionViewCellHeightCoefficient))
        collectionView.collectionViewLayout = gravitySliderLayout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func loadData() {
        DispatchQueue.main.async {
            ActorsNetworkManager.shared.actorsList { popularActors in
                if let popularActors = popularActors {
                    self.actorsViewModel = popularActors.actors.map { ActorsViewModel(actors: $0)}
                    self.collectionView?.reloadData()
                }
            } onFailure: { error in
                Router.shared.showError(error: error, in: self)
            }
        }
    }
    private func configureProductCell(cell: ActorsCollectionViewCell, for indexPath: IndexPath) -> UICollectionViewCell {
        
        let actorsViewModel = self.actorsViewModel[indexPath.row]
        
        cell.clipsToBounds = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [gradientFirstColor, gradientSecondColor]
        gradientLayer.cornerRadius = 21
        gradientLayer.masksToBounds = true
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.layer.shadowColor = cellsShadowColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 30)
        
        cell.popularityLabel.layer.cornerRadius = 8
        cell.popularityLabel.clipsToBounds = true
        cell.popularityLabel.layer.borderColor = UIColor.white.cgColor
        cell.popularityLabel.layer.borderWidth = 1.0
        
        cell.popularityLabel.text = actorsViewModel.popularity
        cell.actorImageView?.sd_setImage(with: actorsViewModel.posterImage)
        return cell
    }
    
    
    private func animateChangingTitle(for indexPath: IndexPath) {
        let actorsViewModel = self.actorsViewModel[indexPath.row]
        
        UIView.transition(with: actorsNameLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.actorsNameLabel.text = actorsViewModel.name
        }, completion: nil)
    }
}

extension MediaViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.actorsViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorsCollectionViewCell.identifier, for: indexPath) as? ActorsCollectionViewCell else {
            return UICollectionViewCell()
        }
        self.configureProductCell(cell: cell, for: indexPath)
        return cell
    }
}
extension MediaViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationFirst = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationSecond = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x + 20, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationThird = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x - 20, y: collectionView.center.y + scrollView.contentOffset.y)
        
        if let indexPathFirst = collectionView.indexPathForItem(at: locationFirst), let indexPathSecond = collectionView.indexPathForItem(at: locationSecond), let indexPathThird = collectionView.indexPathForItem(at: locationThird), indexPathFirst.row == indexPathSecond.row && indexPathSecond.row == indexPathThird.row && indexPathFirst.row != pageControl.currentPage {
            pageControl.currentPage = indexPathFirst.row % actorsViewModel.count
            self.animateChangingTitle(for: indexPathFirst)
        }
    }
}

extension MediaViewController: LoadableDelegate {
    func reloadData() {
    }
}
