//
//  SingleExperienceSwiftUIView.swift
//  AroundEgyptApplication
//
//  Created by Afnan on 07/04/2023.
//

import SwiftUI

struct SingleExperienceSwiftUIView: View {
    @ObservedObject var singleExperienceViewModel = SingleExperienceViewModel()
    
    var body: some View {
        VStack{
            AsyncImage(url: URL(string:singleExperienceViewModel.cover_photo ?? ""))
            { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 392, height: 250,alignment: .topLeading)
            
            .ignoresSafeArea()
       
 
            HStack
            {
                
                Image("eye")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.0,height:18.0)
                    .offset(x:21,y:-70)
                    .padding(5)
                
                Text(singleExperienceViewModel.viewsNum ?? "")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 158.0, height: 3.0)
                    .offset(x:-33,y:-70)
                
                    .padding(5)
                Text("Views")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .frame(width: 158.0, height: 3.0)
                    .offset(x:-149,y:-70)
                
                    .padding(5)
            }
            Spacer()
            
            HStack
            {
                Text(singleExperienceViewModel.experienceName ?? "")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                    .multilineTextAlignment(.leading)
                    .frame(width: 221.0, height: 3.0)
                    .offset(x:33 ,y:-62)
                
                    .padding(.all)
        
                Image(systemName:singleExperienceViewModel.isFav  ? "heart.fill" : "heart")
                    .foregroundColor(.orange)
                   .offset(x:88 ,y:-62)
                    .onTapGesture {
                        singleExperienceViewModel.postLike()
                         }
 
                Text(singleExperienceViewModel.LikeNum ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                    .multilineTextAlignment(.center)
                    .frame(width: 161.0, height: 2.0)
                    .offset(x:-9 ,y:-62)
                
                    .padding(30)

            }
            Rectangle()
                .fill(Color(hue: 0.086, saturation: 0.026, brightness: 0.876))
                .frame(width: 347, height:2)
                .offset(x:-8 ,y:-67)
                .padding(10)
            
            Text("Description")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                .multilineTextAlignment(.leading)
                .frame(width: 167.0, height: 3.0)
                .offset(x:-104 ,y:-83)
            
                .padding(40)
            Spacer()
            
            Text(singleExperienceViewModel.description ?? "")
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundColor(Color(hue: 1.0, saturation: 0.095, brightness: 0.152))
                .multilineTextAlignment(.leading)
                .frame(width: 360.0, height: 318.0)
                .offset(x:-4 ,y:-145)
            
                .padding(40)
        }
        
        .onAppear(perform: singleExperienceViewModel.getSignleExperience)
        
        
        
    }
}

struct SingleExperienceSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SingleExperienceSwiftUIView( )
    }
    
}
