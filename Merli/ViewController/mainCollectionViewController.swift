//
//  mainCollectionViewController.swift
//  Merli
//
//  Created by Jésica González Baqué on 22/05/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

struct Petition: Codable
{
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}

var petitions = [Petition]()



class mainCollectionViewController: UIViewController {

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Traigo JSON
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL( string: urlString ) {
            if let data = try? Data(contentsOf: url) {
                // Todo OK
                print("TODO OK")
                parse(json: data)
            }
        }
        
    }
    func parse(json:Data) {
        let decoder = JSONDecoder()
        
        if let jsonData = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonData.results
            
            productsCollectionView.reloadData()
        }
    }

}

// MARK: UICollectionViewDataSource

override func numberOfSections(in collectionView: UICollectionView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
}


override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of items
    return petitions.count
}

/*
    1) Aparece la pantalla sin elementos
    2) Se realiza una búsqueda
        3) Descargar un JSON con el resultado
        4) Recargar la CV
 
 */

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! productCollectionViewCell

    // Configure the cell
    cell.backgroundColor = .lightGray
    
    let registro = petitions[indexPath.row]
    
    cell.titleLabel.text = registro.title
    
    return cell
}

// MARK: UICollectionViewDelegate


// Uncomment this method to specify if the specified item should be selected
override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
    
    print("SELECT ITEM")
    
    let storyBoard : UIStoryboard  = UIStoryboard(name: "Main", bundle: nil)
    
    let detailViewController = storyBoard.instantiateViewController(identifier: "detailViewController")
    
    self.present(detailViewController, animated:true, completion: nil)
    
    return true
}
}


private let itemsPerRow : CGFloat = 2
private let sectionInsets = UIEdgeInsets (
top:  50.0,
left: 20.0,
bottom: 50.0,
right: 20.0 )

extension mainCollectionViewController: UICollectionViewDelegateFlowLayout {

func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout,
                     sizeForItemAt indexPath: IndexPath
) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow+1)
    let availableWidth = view.frame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow
    
    /*
    if indexPath.row % 2 == 1 {
        return CGSize(width: widthPerItem, height: widthPerItem - 20)
    }
    else
    {*/
        return CGSize(width: widthPerItem, height: widthPerItem + 20)
   // }
}

func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
    return sectionInsets
    }


func collectionView(
    _ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int ) -> CGFloat {
    return sectionInsets.left
}
}

    

  

