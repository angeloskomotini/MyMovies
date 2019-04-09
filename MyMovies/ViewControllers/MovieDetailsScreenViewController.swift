import UIKit
import Cosmos
class MovieDetailsScreenViewController: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    var getID:Int?
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var dTitle: UILabel!
    @IBOutlet weak var setVotes: UILabel!
    func setupViews(){
        let viewModel = ViewModel()
        self.title = "MyMovies-Details Screen"
        viewModel.ListDetailsScreen(detailsScreen: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
