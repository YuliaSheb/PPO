//
//  Copy.swift
//  Converter
//
//  Created by Яна Шебеко on 3.11.22.
//

import SwiftUI

struct Copy: View {
    var body: some View {
        Text("h")
    }
}

struct Toast{
    var title:String
    var image:String
}

struct ToastView: View {
    let toast: Toast
    @Binding var show:Bool
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                HStack{
                    Image(systemName: toast.image)
                    Text(toast.title)
                }
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.vertical,20)
                .padding(.horizontal,40)
                .background(.mint.opacity(0.4),in:Capsule())
            }
            .frame(width: UIScreen.main.bounds.size.width,alignment: .center)
            .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
            .onTapGesture{
                withAnimation{
                    self.show = false
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now()+1){
                    withAnimation{
                        self.show = false
                    }
                }
            }
        }
    }
}

struct Overlay<T: View>: ViewModifier{
    @Binding var show: Bool
    let overlayView: T
    
    func body(content: Content) -> some View {
        ZStack{
            content
            if show{
                overlayView
            }
        }
    }
}

extension View{
    func overlay<T:View>(overlayView:T,show:Binding<Bool>)->some View{
        self.modifier(Overlay(show: show, overlayView: overlayView))
    }
}

struct Copy_Previews: PreviewProvider {
    static var previews: some View {
        Copy()
    }
}
