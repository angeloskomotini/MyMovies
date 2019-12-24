import UIKit
import Cosmos
class MyMovieHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        lblTitle.text = nil
        img.image = nil
        lblReleaseDate.text = nil
        rating.rating = 0.0
    }
}
