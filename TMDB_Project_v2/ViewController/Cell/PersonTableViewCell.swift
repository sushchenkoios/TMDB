//
//  PersonTableViewCell.swift
//  TMDB_Project_v2
//
//  Created by Oleksandr Sushchenko on 02.03.2023.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImagePerson: UIImageView!
    @IBOutlet weak var namePerson: UILabel!
    
    
    
    //MARK: - Result == person
    func configurePerson(with media: PersonResult) {
        
        posterImagePerson.layer.cornerRadius = 200
        self.namePerson.text = media.name
        loadImage(path: media.profilePath ?? "")
        
    }
    
    // MARK: Result == image
    func loadImage (path: String) {
     
        let imageURLString = Url.urlImagePoster + path
        let imageURL = URL(string: imageURLString)
        let defaultImage = UIImage(named: "defaultImage") // деф картинка
         
        posterImagePerson.sd_setImage(with: imageURL, placeholderImage: defaultImage)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
