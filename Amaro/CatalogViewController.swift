//
//  CatalogViewController.swift
//  Amaro
//
//  Created by Diego Cavalcante Costa on 09/01/17.
//  Copyright © 2017 Diego Cavalcante Costa. All rights reserved.
//

import UIKit

class CatalogViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    
    
    fileprivate lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Pesquisar por nome do produto"
        searchBar.enablesReturnKeyAutomatically = false
        return searchBar
    }()
    
    fileprivate lazy var model : CatalogModel = {
        return CatalogModel(delegate : self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        model.getJson()
        
    }
    private func setup() {
        navigationItem.titleView = searchBar
//        filterBarButton.imageInsets = UIEdgeInsetsMake(0.0, 20, 0, 0)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        let alert = UIAlertController(title: "Ordenar por: ", message: nil, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Em promoção", style: .default, handler: {(action) in
            self.model.searchProductOnSale()
        })
        let limparAction = UIAlertAction(title: "Limpar todos os filtros", style: .cancel, handler: {(action) in
            self.model.getJson()
        })
        alert.addAction(okAction)
        alert.addAction(limparAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension CatalogViewController : UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            model.getJson()
            searchBar.resignFirstResponder()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        model.searchProduct(with: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension CatalogViewController : CatalogModelDelegate {
    func model(jsonResponse model : CatalogModel, error : NSError?) {
        collectionView.reloadData()
    }
}
extension CatalogViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width / 2) - 6, height: 286)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}
extension CatalogViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !model.products.isEmpty {
            performSegue(withIdentifier: String(describing : CatalogDetailViewController.self), sender: model.products[indexPath.row])
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CatalogDetailViewController {
            let destination = segue.destination as! CatalogDetailViewController
            let model = CatalogDetailModel(delegate: destination)
            model.product = sender as! Product
            destination.model = model
        }
    }
}
extension CatalogViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.products.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CatalogCollectionViewCell
        cell.populate(with: model.products[indexPath.row])
        return cell
    }
}
