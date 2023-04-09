//
//  SingleExperienceSwiftUIView.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 07/04/2023.
//

import SwiftUI
struct SingleExperienceSwiftUIView: View {
    @ObservedObject var singleExperienceViewModel = SingleExperienceViewModel()
    @StateObject var networkHelper = NetworkHelper()
    
    
    var body: some View {
        VStack{
            if networkHelper.isConnected {
                AsyncImage(url: URL(string:singleExperienceViewModel.cover_photo ?? "placeholder"))
                { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 392, height: 250,alignment: .topLeading)
                .offset(x:0,y:0)
                .ignoresSafeArea()
                
            } else {
                Image("placeholder")
                    .resizable()
                    .frame(width: 392, height: 250,alignment: .topLeading)
                    .offset(x:0,y:0)
                    .ignoresSafeArea()
                
            }
            
            HStack
            {
                
                Image("eye")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.0,height:18.0)
                    .offset(x:21,y:-140)
                    .padding(5)
                
                Text(singleExperienceViewModel.viewsNum ?? "")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 158.0, height: 3.0)
                    .offset(x:-33,y:-140)
                
                    .padding(5)
                Text("Views")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 158.0, height: 3.0)
                    .offset(x:-149,y:-140)
                
                    .padding(5)
            }
            Spacer()
                .frame(width: 3.0, height: 3.0)
            
            HStack
            {
                Text(singleExperienceViewModel.experienceName ?? "")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                    .multilineTextAlignment(.leading)
                    .frame(width: 221.0, height: 3.0)
                    .offset(x:31 ,y:-110)
                
                
                Image(systemName:singleExperienceViewModel.isFav  ? "heart.fill" : "heart")
                    .foregroundColor(.orange)
                    .offset(x:88 ,y:-110)
                    .onTapGesture {
                        singleExperienceViewModel.postLike()
                    }
                
                Text(singleExperienceViewModel.LikeNum ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                    .multilineTextAlignment(.center)
                    .frame(width: 161.0, height: 2.0)
                    .offset(x:-9 ,y:-110)
                
                    .padding(.leading, 30)
                
            }
            Rectangle()
                .fill(Color(hue: 0.086, saturation: 0.026, brightness: 0.876))
                .frame(width: 347, height:2)
                .offset(x:-8 ,y:-98)
                .padding(10)
            
            Text("Description")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                .multilineTextAlignment(.leading)
                .frame(width: 167.0, height: 3.0)
                .offset(x:-104 ,y:-83)
            
            
            Text(singleExperienceViewModel.description ?? "")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                .multilineTextAlignment(.leading)
                .frame(width: 360.0,height: 360)
                .offset(x:4 ,y:-65)
                .padding(15.0)
                .scaledToFit()
            
            
        }
        
        .onAppear
        {
            
            if networkHelper.isConnected {
                print("Connected to the network")
                singleExperienceViewModel.getSignleExperience()
                
            }
            else {
                print("No network connection")
            }
            
            
        }
        
        
    }
    
}
struct SingleExperienceSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SingleExperienceSwiftUIView( )
    }
    
}
