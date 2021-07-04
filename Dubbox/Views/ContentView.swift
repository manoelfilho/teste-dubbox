//
//  ContentView.swift
//  Dubbox
//
//  Created by Manoel Filho on 02/07/21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Properties
    @StateObject var userData = UserData()
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            if userData.loggedIn {
                
                if let savedPerson = defaults.object(forKey: "auth") as? Data {
                    let decoder = JSONDecoder()
                    if let loadedPerson = try? decoder.decode(Response.self, from: savedPerson) {
                        
                        HomeView(userData: userData, userResponse: loadedPerson)
                    
                    }
                }
        
            } else {
                LoginView(userData: userData)
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
