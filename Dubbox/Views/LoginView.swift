//
//  LoginView.swift
//  Dubbox
//
//  Created by Manoel Filho on 02/07/21.
//

import SwiftUI

struct LoginView: View {
    
    //MARK: Proprerties
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
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
                
                //efeito paralax
                .frame(
                    width: UIScreen.main.bounds.width + 1,
                    height: reader.frame(in: .global).minY + 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                )
                
            }
            .frame(height: 15)
            // Background top
            
            VStack(alignment: .leading, spacing: 15){
                
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
                    
                    HStack{
                        
                        VStack{
                            
                            //MARK: Email
                            VStack{
                                HStack{
                                    
                                    Text(LocalizedStringKey("Email"))
                                        .font(.footnote)
                                        .foregroundColor(Color("font-gray"))
                                    Spacer()
                                    
                                }
                                HStack {
                    
                                    Image(systemName: "envelope")
                                        .foregroundColor(Color("font-gray"))
                                    
                                    TextField(LocalizedStringKey("Email"), text: $email)
                                        .font(.custom("Nunito-Regular", size: 16))
                                        .foregroundColor(Color("font-gray"))
                    
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(Color("font-gray"))
                                )
                            }
                            // Email
                            
                            //MARK: Password
                            VStack{
                                
                                HStack{
                                    Text(LocalizedStringKey("Password"))
                                        .font(.footnote)
                                        .foregroundColor(Color("font-gray"))
                                    Spacer()
                                }
                                .padding(.top, 20)
                                
                                HStack {
                                    
                                    Image(systemName: "lock")
                                        .foregroundColor(Color("font-gray"))
                                    
                                    TextField(LocalizedStringKey("Password"), text: $password)
                                        .font(.custom("Nunito-Regular", size: 16))
                                        .foregroundColor(Color("font-gray"))
                                    
                                    Button(
                                        action:{
                                            //action
                                        }
                                    ){
                                        Image(systemName: "eye")
                                            .foregroundColor(Color("font-gray"))
                                    }
                    
                                }
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1)
                                        .foregroundColor(Color("font-gray"))
                                )
                            }
                            //Password
                            
                            //MARK: Did you lost your password
                            HStack{
                                Button(
                                    action: {
                                        //action
                                    }
                                ){
                                    Text(LocalizedStringKey("Did you lost your password?"))
                                        .font(.custom("Nunito-Regular", size: 15))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("bg"))
                                    Spacer()
                                }
                            }
                            .padding(.top, 10)
                            
                            //MARK: Enter
                            Button(
                                action:{
                                    //action
                                }
                            ){
                                ZStack{
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 50)
                                        .accentColor(Color("green-clear"))
                                    
                                    Text(LocalizedStringKey("Enter"))
                                        .font(.custom("Nunito-Regular", size: 20))
                                        .fontWeight(.regular)
                                        .foregroundColor(.white)
                                    
                                }
                            }
                            .padding(.top, 20)
                            
                            Text(LocalizedStringKey("Or"))
                                .font(.custom("Nunito-Regular", size: 15))
                                .foregroundColor(Color("font-gray"))
                            
                            //MARK: Login with google and facebook
                            HStack{
                                Spacer()
                                
                                Button(
                                    action:{
                                        //action
                                    }
                                ){
                                    Image("icon-google")
                                }
                                .padding(.horizontal)
                                                                
                                Button(
                                    action:{
                                        //action
                                    }
                                ){
                                    Image("icon-facebook")
                                }
                                .padding(.horizontal)
                                
                                Spacer()
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color("transparent"), radius: 6, x: 0, y: 8)
                    
                    //MARK: Your first time?
                    HStack{
                        Text(LocalizedStringKey("Your first time?"))
                            .font(.custom("Nunito-Regular", size: 15))
                            .foregroundColor(Color("font-gray"))
                        Button(
                            action: {
                                //action
                            }
                        ){
                            Text(LocalizedStringKey("Join us"))
                                .font(.custom("Nunito-Regular", size: 15))
                                .foregroundColor(Color("bg"))
                        }
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
            }
            
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
