import UIKit
import AFNNetworking
class MainTableViewController: UITableViewController,UITextFieldDelegate {
    
    let viewModel=ViewModel()
    
    @IBOutlet weak var txtSearch: UITextField!
    
    var setID = Int()
    
    var results = [MyMovieHomeScreen]()
    
    var searchString:String?
    
    
    @IBAction func btnSearch(_ sender: Any) {
        searchString = txtSearch.text
        searchResults()
        
    }
    
    private func gotoMovieDetailsScreen(id:String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailsVC = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsScreenViewController") as! MovieDetailsScreenViewController
        detailsVC.getID = id
        self.navigationController?.pushViewController(detailsVC, animated:true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }  
    
    // MARK: - Table view data source
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoMovieDetailsScreen(id: self.results[indexPath.row].id!)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MyMovieHomeTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyMovieHomeTableViewCell
        setupCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension MainTableViewController{
    func setupViews(){
        self.title = "My Movies"
        self.tableView.register(UINib(nibName: "MyMovieHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        txtSearch.delegate=self
        
    }
    func setupCell(cell:MyMovieHomeTableViewCell,indexPath:IndexPath){
        if(indexPath.row<self.results.count){
            cell.lblTitle?.text = self.results[indexPath.row].title
            cell.img.contentMode = .scaleAspectFit
            cell.img.downloaded(link: self.results[indexPath.row].poster!)
            cell.lblReleaseDate?.text = self.results[indexPath.row].releasedate
            if let rating=self.results[indexPath.row].rating{
                let convertValue = Double(rating)
                cell.rating.rating = convertValue! / 2.0
                
            }
            
        }
        
    }
    func searchResults(){
        viewModel.ListSearchResults(searchString:self.searchString!,result: {
            result in
            for countResults in 0..<result.count {
                self.results.append(result[countResults])
            }
            self.tableView.reloadData()
       
        })
    }
}
