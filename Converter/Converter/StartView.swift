import SwiftUI

struct StartView: View {
    @State var isShowedPage1 = false
    var body: some View {
        NavigationView{
            VStack{
                TitleText(text: "Converter", size: 70)
                    .padding()
                    .position(x: 180, y: 60)
                HStack{
                    NavigationLink(destination: CurrencyView()) {
                        Image(systemName: "dollarsign.square.fill")
                            .font(.custom("Academy Engraved LET", size: 70))
                            .foregroundColor(.black)
                            .padding()
                    }
                    .position(x: 60, y: -20)
                    NavigationLink(destination: LengthView()) {
                        Image(systemName: "ruler.fill")
                            .font(.custom("Academy Engraved LET", size: 60))
                            .foregroundColor(.black)
                    }
                    .position(x: 55, y: 10)
                    NavigationLink(destination: WeightView()) {
                        Image(systemName: "gearshape.fill")
                            .font(.custom("Academy Engraved LET", size: 60))
                            .foregroundColor(.black)
                    }
                    .position(x: 50, y: 30)
                }
            }.background(Image("phon"))
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
                .previewInterfaceOrientation(.portrait)
                .previewInterfaceOrientation(.portraitUpsideDown)
        }
    }
}
