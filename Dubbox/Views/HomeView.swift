//
//  HomeView.swift
//  Dubbox
//
//  Created by Manoel Filho on 03/07/21.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: Properties
    let defaults = UserDefaults.standard
    @ObservedObject var userData: UserData
    
    var userResponse: Response?
    
    init(userData: UserData, userResponse: Response){
        self.userResponse = userResponse
        self.userData = userData
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            ZStack{
                
                VStack{
                    
                    //MARK: Background top
                    GeometryReader{ reader in
                        
                        ZStack{
                            
                            //imagem do bg
                            Image("bg-auth")
                                .resizable()
                                .scaledToFill()
                            
                            //simulacao overlay
                            Rectangle()
                                .fill(Color("bg"))
                                .opacity(0.9)
                            
                        }
                        //deixando a imagem presa no topo
                        .offset(y: -reader.frame(in: .global).minY)
                        
                    }
                    .frame(height: 15)
                    // Background top
                    
                    VStack(alignment: .leading){
                        
                        //MARK: Logo
                        HStack(alignment: .center){
                            Spacer()
                            Text("Logo")
                                .font(.custom("Nunito-Black", size: 70))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        // Logo
                        
                        VStack{
                            
                            VStack(alignment: .leading){
                                Text("Usuário:")
                                    .font(.system(.title))
                                Spacer()
                                Text(verbatim: "Identidade: \(self.userResponse?.data.user.identity ?? "--Identidade não localizada---")")
                                Text(verbatim: "Nome: \(self.userResponse?.data.user.name ?? "--Usuário não localizado---")")
                                Text(verbatim: "Email: \(self.userResponse?.data.user.email ?? "--Email não localizado---")")
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 30)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color("transparent"), radius: 6, x: 0, y: 8)
                            
                        }
                        .padding(.horizontal, 30)
                        
                        Spacer()
                        
                    }
                    
                    
                }
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                
            }
            .overlay(
                Button(action: {
                    UserDefaults.standard.removeObject(forKey: "auth")
                    userData.loggedIn = false
                }) {
                    Text(LocalizedStringKey("signup_login"))
                        .font(.custom("Nunito-Black", size: 12))
                        .foregroundColor(.white)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .border(Color.white, width: 2)
                        .cornerRadius(5)
                }
                .padding(.leading, 10)
                .padding(.top, 35)
                .frame(width: 100, height: 80)
                ,
                alignment: .topLeading
            )
            
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        let user = User(
            name: "Name",
            email: "email@email.com",
            identity: "02419712170",
            uuid: "deef5943-b353-4527-a1dc-b5df4307d430",
            phone: "5561991235477",
            birthday: nil,
            created_at: "2021-06-03T02:19:14.000000Z",
            password: nil
        )
        
        let dataResponse = DataResponse(
            user: user,
            access_token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNDhmZmE2YmI2ZDhiYjg1NGM4MWQwYmE5MTEyYTZiYmFmZTZlZjcwMjdjZDU5YjI4ZTc3OTRiNjhjOWYyMDM0MWYyYjYzZDU0NGM5MDgzYWMiLCJpYXQiOjE2MjMwMjQzMDcuNDEyMzg1LCJuYmYiOjE2MjMwMjQzMDcuNDEyMzk0LCJleHAiOjE2NTQ1NjAzMDcuNDAyOTEyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.JkFdqc23kszC9YSa_2xTShgxyKRnJTTApd-BrPWpGZlxjSEGL0CfnZdXn71KeUAWHPN7V4KHI2KyW36IBTJdZN_FZyVwZaLI9s0kzLJTFOZFWO7cHzXPr6GvfqUJZntw0l3KjP_xuZbUO0BjPS4b9ul8mcC90eVLZ9uQvRpP2tQUHJwSqyXtUFYe9aT2C-o5yUZPPXCC_Gph7mjeOJjSWU_mGVgD1xh8EBOEXQBcobLP1dGJS-RMfcvg0NJ4eklthR-BH4l3N1xYvAISDPYIJJTB28uxCWlrR2-D7kHlGU-MoDNy1klI-tMH6_H5PfwFdS7fWP9ulPMl3YpFS7SJje4aVgbQ850jii25_b6oWM79XU-AijJrihR83V9WCCBQDDgFHGh0EdKUWcAhxlKWr-JrQfkqF9HEs0aggzKe56zabx-hB1cuAvpVG39wCJAyXerR45DRXdz4CBAlWroVPhXcsjfFtNuzf0mwdUade3Vwp__tjogOnKbKjZXu6h4S67HsBIPZUyVtnmv1aula9S_pn00iDVWHrSUzxqLBp1XyfRnZGshEVEMe0-o4N38WKlLUOOGvvEYgb875tAkViBGbQ8N0eG4mdE-gbKBgFfnhraylr30Hzo-2hGxlWERY_F5J0ma5fCiI4VJcuhF7dXWLQ1ZOv-Ns00rZtnsVUL4"
        )
        
        let userResponseTest = Response(
            success: true,
            message: "The login was realized",
            code: 2005,
            data: dataResponse
        )
        
        HomeView(userData: UserData(), userResponse: userResponseTest)
    }
}
