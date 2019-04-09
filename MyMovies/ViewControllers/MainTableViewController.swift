import UIKit

class MainTableViewController: UITableViewController,UITextFieldDelegate {
    let viewModel=ViewModel()
    
    @IBOutlet weak var txtSearch: UITextField!
    
    var results: [MyMovieHomeScreen] = [] {
        didSet {
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    var searchString:String?
 
   
    @IBAction func btnSearch(_ sender: Any) {
        searchString = txtSearch.text
        viewModel.ListSearchResults(homeScreen:self)
    
    }
    
    func setupViews(){
        self.title = "MyMovies"
        self.tableView.register(UINib(nibName: "MyMovieHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        viewModel.ListPopularMovies(homeScreen:self)
        txtSearch.delegate=self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Popular Movies", style: .plain, target: self, action: #selector(self.loadPopularMovies))
    }
    
    func reloadData(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    func setupCell(cell:MyMovieHomeTableViewCell,indexPath:IndexPath){
        if(indexPath.row<self.results.count){
            cell.lblTitle?.text = self.results[indexPath.row].title
            cell.img.contentMode = .scaleAspectFit
            cell.img.downloaded(from: self.results[indexPath.row].poster!)
            cell.lblReleaseDate?.text = self.results[indexPath.row].releasedate
            if let rating=self.results[indexPath.row].rating{
                let convertValue = Double(rating)
                cell.rating.rating = convertValue! / 2.0
                
            }
            
        }
        
    }
    @objc func loadPopularMovies(){
        results.removeAll()
        viewModel.ListPopularMovies(homeScreen:self)
        reloadData()
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
        
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let detailsVC = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsScreenViewController") as! MovieDetailsScreenViewController
               detailsVC.getID = self.results[indexPath.row].id
               self.navigationController?.pushViewController(detailsVC, animated:true)
                
        
       
       

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
