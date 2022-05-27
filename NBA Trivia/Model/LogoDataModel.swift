//
//  LogoDataModel.swift
//  NBA Trivia
//
//  Created by Vince Verdadero on 17/03/2022.
//

import Foundation

// This must be hashable in order to be identified
struct Logo: Hashable {
    
    // the name of the NBA team
    let name: String
    // calling the number from the assets folder linking it to the name of the NBA team.
    let number: String
    
    // assigning each number from the assets and pair it with the NBA team name, many more will be added soon in future development...
    static var allLogo = [
        
        Logo(name: "Oklahoma City Thunder", number: "001"),
        Logo(name: "Houston Rockets", number: "002"),
        Logo(name: "Chicago Bulls", number: "003"),
        Logo(name: "Phoenix Suns", number: "004"),
        Logo(name: "Orlando Magic", number: "005"),
        Logo(name: "Washington Wizards", number: "006"),
        Logo(name: "Atlanta Hawks", number: "007"),
        Logo(name: "Boston Celtics", number: "008"),
        Logo(name: "New Orleans Pelicans", number: "009"),
        Logo(name: "Toronto Raptors", number: "010"),
        Logo(name: "Dallas Mavericks", number: "011"),
        Logo(name: "Indiana Pacers", number: "012"),
        Logo(name: "Minnesota Timberwolves", number: "013"),
        Logo(name: "Brooklyn Nets", number: "014"),
        Logo(name: "Philadelphia 76ers", number: "015"),
        Logo(name: "Los Angeles Clippers", number: "016"),
        Logo(name: "Memphis Grizzlies", number: "017"),
        Logo(name: "Milwaukee Bucks", number: "018"),
        Logo(name: "Detroit Pistons", number: "019"),
        Logo(name: "Los Angeles Lakers", number: "020"),
        Logo(name: "Golden State Warriors", number: "021"),
        Logo(name: "Miami Heat", number: "022"),
        Logo(name: "Sacremento Kings", number: "023"),
        Logo(name: "Portland Trail Blazers", number: "024"),
        Logo(name: "New York Knicks", number: "025"),
        Logo(name: "Charlotte Hornets", number: "026"),
        Logo(name: "Cleavland Cavaliers", number: "027"),
        Logo(name: "San Antonio Spurs", number: "028"),
        Logo(name: "Utah Jazz", number: "029"),
        Logo(name: "Denver Nuggets", number: "030"),
        Logo(name: "90s Toronto Raptors", number: "031"),
        Logo(name: "Vancouver Grizzlies", number: "032"),
        Logo(name: "New Jersey Nets", number: "033"),
        Logo(name: "90s Golden State Warriors", number: "034"),
        Logo(name: "90s Houston Rockets", number: "035"),
        Logo(name: "Seattle Supersonics", number: "036"),
        Logo(name: "90s Detroit Pistons", number: "037"),
        Logo(name: "50s Boston Celtics", number: "038"),
        Logo(name: "Charlotte Bobcats", number: "039"),
        Logo(name: "90s Milwaukee Bucks", number: "040"),
    ]
    
}
