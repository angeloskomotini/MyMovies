import UIKit
import Cosmos
class MovieDetailsScreenViewController: UIViewController {
    let viewModel = ViewModel()
    @IBOutlet weak var poster: UIImageView!
    var getID:String?
    @IBOutlet weak var status: UILabel!
  
    @IBOutlet weak var filmOverviewText: UITextView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var dTitle: UILabel!
    @IBOutlet weak var setVotes: UILabel!
   
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
extension MovieDetailsScreenViewController{
    func setupViews(){
           self.title = "Details Screen"
           ListDetailsScreen()
    }
    func ListDetailsScreen(){
        viewModel.ListDetailsScreen(id:self.getID!,result: {
            result in
            self.dTitle.text=result[0].title
            self.poster.downloaded(link: result[0].poster!)
            self.releaseDate.text=result[0].releasedate
            self.filmOverviewText.text = result[0].overViewFilm
            self.status.text=result[0].status
            self.genre.text=result[0].genre
            if let rating=result[0].rating{
                let convertValue = Double(rating)
                self.rating.rating = convertValue! / 2.0
            }
        })
        
    }
}
