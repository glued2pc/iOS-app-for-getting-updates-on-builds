//
//  ViewController.swift
//  systemInsightsWofilter
//
//  Created by Development on 19/04/17.
//  Copyright © 2017 Development. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var Manager : Alamofire.SessionManager = {
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "vhmcdbfadb.mcd.rot.hec.sap.biz": .disableEvaluation
        ]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let man = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        return man
    }()
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var trackers : [sysIns]? = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchData()
        
    }
    
    func fetchData() {
    
        
        let user = "C5235326"
        let password = "14Hana94$"
        
        var headers: HTTPHeaders = [:]
        
        if let authorizationHeader = Request.authorizationHeader(user: user, password: password) {
            headers[authorizationHeader.key] = authorizationHeader.value
        }
        
        Manager.request("https://vhmcdbfadb.mcd.rot.hec.sap.biz:4304/iOS_DEVPDT/pdtracker1/XSJSservices/lfcycle.xsjs?cmd=GETPROGRESS", headers: headers)
            .responseJSON { response in
             
            debugPrint(response)
        if response.error != nil {
            print(response.error)
                    return
        }
         self.trackers = [sysIns]()
                do {
                
                    let json = response.result.value as? [String : AnyObject]
                    
                    if let reportsfromJson = json?["trackers"] as? [[String:AnyObject]] {
                        
                        for reportfromJson in reportsfromJson {
                            
                            let systemIns = sysIns ()
                            if let cidsid = reportfromJson["CIDSID"] as? String, let tier = reportfromJson["tier"] as? String, let region = reportfromJson["region"]as? String, let solName = reportfromJson["solutionDesc"]as? String, let cddDate = reportfromJson["CDD"]as? String, let opprId = reportfromJson["B1OpprId"]as? String, let spcPerc = reportfromJson["spcPercentage"]as? String, let implType = reportfromJson["implementationType"]as? String, let CusName = reportfromJson["customerName"]as? String, let spocName = reportfromJson["spocName"]as? String, let cplName = reportfromJson["cplName"]as? String, let ctcName = reportfromJson["ctcName"]as? String, let startDate = reportfromJson["start"]as? String, let remaining = reportfromJson["remainingDays"]as? String, let spcProcessID = reportfromJson["spcProcessId"]as? String, let tickCount = reportfromJson["ticketCount"]as? String
                                {
                                    systemIns.cidsid = cidsid
                                    systemIns.tier = tier
                                    systemIns.region = region
                                    systemIns.solName = solName
                                    systemIns.cddDate = cddDate
                                    systemIns.opprId = opprId
                                    systemIns.spcPerc = spcPerc
                                    systemIns.implType = implType
                                    systemIns.CusName = CusName
                                    systemIns.spocName = spocName
                                    systemIns.cplName = cplName
                                    systemIns.ctcName = ctcName
                                    systemIns.startDate = startDate
                                    systemIns.remaining = remaining
                                    systemIns.spcProcessID = spcProcessID
                                    systemIns.tickCount = tickCount
                                    
                            }
                            self.trackers?.append(systemIns)
                            
                            }
                            
                            
                        }
                        DispatchQueue.main.async {
                        self.tableView.reloadData()
                        }
                        
                } catch let error{
                    print(response.error as Any)
                }
                
            
            }
                
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sysInsCell", for: indexPath) as! sysInsTableViewCell
        
        cell.cidsid.text = self.trackers?[indexPath.item].cidsid
        cell.region.text = self.trackers?[indexPath.item].region
        cell.solName.text = self.trackers?[indexPath.item].solName
        cell.opprId.text = self.trackers?[indexPath.item].opprId
        cell.cddDate.text = self.trackers?[indexPath.item].cddDate
        cell.spcPerc.text = self.trackers?[indexPath.item].spcPerc
        cell.tier.text = self.trackers?[indexPath.item].tier
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trackers?.count ?? 0
    }

}

