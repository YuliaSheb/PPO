
import SwiftUI

enum CalccButton: String {
    case zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5", six = "6", seven = "7", eight = "8", nine =
    "9"
    case dot = "."
    var title:String{
        switch self{
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .dot: return "."
        default:
            return " "
        }
    }
}

extension Color {
    static let owhite = Color(red:22/255, green: 220/255, blue: 22/255)
}

struct SimplButtonStyle: ButtonStyle{
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .background(){
                Circle()
                    .fill(Color.owhite)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y:10)
                    .shadow(color: Color.black.opacity(0.7), radius: 10, x: -5, y: -5)
            }
    }
}

struct WeightView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    let buttons: [[CalcButton]] =
    [
        [.one, .two, .three, .four],
        [.five, .six, .seven, .eight],
        [.dot, .nine, .zero]
    ]
    let buttonss: [[CalcButton]] =
    [
        [.one, .two, .three, .four, .five, .six, .seven],
        [.eight,.dot, .nine, .zero],
    ]
    @State private var itemSelected1 = 0
    @State private var itemS = 0
    @State private var itemSelected2 = 1
    @State private var amount: String = ""
    private let currencies = ["Sm","M","Dm","Mm"]
    private let characterLimit = 12
    @FocusState private var IsFocused: Bool
    
    func convert(_ convert:String)->String{
        var conversion: Double = 1.0
        let amount = Double(convert.doubleValue)
        let selectedCurrency = currencies[itemSelected1]
        let to = currencies[itemSelected2]
        let smRates = ["Sm": 1.0, "M": 0.01, "Dm": 0.1 ,"Mm": 10]
        let mRates = ["Sm": 100, "M": 1.0, "Dm": 10,"Mm":1000]
        let dmRates = ["Sm": 10, "M": 10, "Dm": 1.0,"Mm":100]
        let mmRates = ["Sm": 0.1, "M": 0.001, "Dm": 0.01,"Mm":1.0]
        switch(selectedCurrency){
        case "Sm":
            conversion = amount *  (smRates[to] ?? 0.0)
        case "M":
            conversion = amount *  (mRates[to] ?? 0.0)
        case "Dm":
            conversion = amount *  (dmRates[to] ?? 0.0)
        case "Mm":
            conversion = amount *  (mmRates[to] ?? 0.0)
        default:
            print("Something went wrong!")
        }
        return String(conversion)
    }
    func howMany(input:String, count: Character) -> Int {
        var letterCount = 0
        for letter in input {
            if letter == count {
                letterCount += 1
            }
        }
        return letterCount
    }
    
    @State private var rowC = 0
    @State private var rowD = 0
    @State private var showAlert = false
    @State private var showAlertDot = false
    @Environment(\.editMode) private var editMode
    @State private var disableTextField = true
    @State private var isShow = false
    @State private var isShow2 = false
    private let pasteBoard = UIPasteboard.general
    var body: some View {
        NavigationView{
            VStack{
                TitleText(text: "Convert a length", size: 38)
                    .foregroundColor(.white)
                    .padding()
                    .position(x: 180, y: 60)
                    .focused($IsFocused)
                HStack{
                    TextField("Enter an amount",text:
                                $amount)
                    .focused($IsFocused)
                        .disabled(amount.count > (characterLimit-1))
    //                            .keyboardType(.decimalPad)
                        .disabled(disableTextField)
                            .onChange(of: editMode?.wrappedValue) { newValue in
                                if (newValue != nil) && (newValue!.isEditing) {
                                    // Edit button tapped
                                    disableTextField = false
                                }
                                else {
                                    // Done button tapped
                                    disableTextField = true
                                }
                            }
                        .padding(5)
                        .background(Color.offwhite)
                        .cornerRadius(92)
                        .offset(y:70)
                        .font(.custom("Academy Engraved LET", size: 30))
                    Button(action:{isShow=true
                        copyToClicBoard()
                    } , label: {Image(systemName: "doc.on.doc.fill"
                    )
                            .font(.custom("Academy Engraved LET", size: 30))
                    })
                    .overlay(overlayView: ToastView(toast: Toast(title: "Copied", image: "done"), show: $isShow), show: $isShow)
                        .offset(y:70)
                }
                HStack {
                    Text("From:")
                        .offset(x:-85)
                        .font(.custom("Academy Engraved LET", size: 20))
                        .foregroundColor(.black)
                    Picker(selection: $itemSelected1,label: Text("From")){
                        ForEach(0..<currencies.count){
                            index in Text(self.currencies[index]).tag(index)
                        }
                    }.offset(x:-70,y:-4)
                    Text("To:")
                        .offset(x:15)
                        .font(.custom("Academy Engraved LET", size: 20))
                        .foregroundColor(.black)
                    Picker(selection: $itemSelected2,label: Text("To")){
                        ForEach(0..<currencies.count){
                            index in Text(self.currencies[index]).tag(index)
                        }
                    }.offset(x:20,y:-4)
                }.offset(y:60)
                    .padding()
                Group{
                    if orientation.isLandscape{ HStack {
                        Text("Conversion: ")
                            .offset(x:10, y:40)
                            .font(.custom("Academy Engraved LET", size: 25))
                            .foregroundColor(.black)
                        HStack{
                            Text("\(convert(amount))\( currencies[itemSelected2]) ")
                                .frame(width: 280)
                                .padding(.top,8)
                                .padding(.horizontal,90)
                                .background(Color.offwhite)
                                .cornerRadius(92)
                                .textSelection(.enabled)
                                .font(.custom("Academy Engraved LET", size: 18))
                                .offset(y:40)
                            Button(action:{isShow2=true
                                copyToClicBoard()
                            } , label: {Image(systemName: "doc.on.doc.fill"
                            )
                                    .font(.custom("Academy Engraved LET", size: 20))
                            })
                            .overlay(overlayView: ToastView(toast: Toast(title: "Copied", image: "done"), show: $isShow2), show: $isShow2)
                            .offset(x:-10,y:40)
                        }
                    }
                        Button(action:{
                            amount = convert(amount)
                            itemS = itemSelected2
                            itemSelected2 = itemSelected1
                            itemSelected1 = itemS
                        },label:{
                            Image(systemName: "arrow.up.arrow.down")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        } ).offset(x:230,y:-60)
                            .buttonStyle(SimpleButtonStyle())
                    }
                    else{
                        VStack{
                            Text("Conversion: ")
                                .offset(x:-100, y:40)
                                .font(.custom("Academy Engraved LET", size: 25))
                                .foregroundColor(.black)
                            HStack{
                                Text("\(convert(amount))\( currencies[itemSelected2]) ")
                                    .frame(width: 180)
                                    .padding(.top,8)
                                    .padding(.horizontal,90)
                                    .background(Color.offwhite)
                                    .cornerRadius(92)
                                    .textSelection(.enabled)
                                    .font(.custom("Academy Engraved LET", size: 18))
                                    .offset(y:40)
                                Button(action:{isShow2=true
                                    copyToClicBoard2()
                                } , label: {Image(systemName: "doc.on.doc.fill"
                                )
                                        .font(.custom("Academy Engraved LET", size: 20))
                                })
                                .overlay(overlayView: ToastView(toast: Toast(title: "Copied", image: "done"), show: $isShow2), show: $isShow2)
                                .offset(x:-10,y:40)
                            }
                            Button(action:{
                                amount = convert(amount)
                                itemS = itemSelected2
                                itemSelected2 = itemSelected1
                                itemSelected1 = itemS
                            },label:{
                                Image(systemName: "arrow.up.arrow.down")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                            } ).offset(x:130,y:-80)
                                .buttonStyle(SimpleButtonStyle())
                        }
                    }
                }.onRotate { newOrientation in
                    orientation = newOrientation
                }
                ZStack(alignment: .bottom){
                    VStack{
                        if (orientation.isLandscape){
                            ForEach(buttonss, id:\.self){row in HStack{
                                ForEach(row, id:\.self){button in
                                    Button(action: {
                                        self.didTap(button:button)
                                        rowC += 1
                                        if rowC > 14 {
                                            showAlert = true
                                        }
                                    }, label: {
                                        Text(button.title)
                                            .font(.custom("Academy Engraved LET", size: 15))
                                            .frame(width: 50, height: 18)
                                            .cornerRadius(100)
                                    })
                                    .buttonStyle(SimpleButtonStyle())
                                }.disabled(rowC>14)
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("It is too long"))
                                    }
                                    .disabled(rowD>1)
                                        .alert(isPresented: $showAlertDot) {
                                            Alert(title: Text("I think that you need only one dot)"))
                                        }
                                        .offset(y:-10)
                                }
                            }
                            Button(action: {amount="0"
                                rowC=0
                                rowD=0
                            }, label:{ Text("AC")
                                    .font(.custom("Academy Engraved LET", size: 15))
                                .frame(width: 50, height: 18)
                                .cornerRadius(100)
                            })
                            .buttonStyle(SimpleButtonStyle())
                            .offset(x:220,y:-70)
                        }
                        else{
                            ForEach(buttons, id:\.self){row in HStack{
                                ForEach(row, id:\.self){button in
                                    Button(action: {
                                        self.didTap(button:button)
                                        rowC += 1
                                        if rowC > 10 {
                                            showAlert = true
                                        }
                                    }, label: {
                                        Text(button.title)
                                            .font(.custom("Academy Engraved LET", size: 15))
                                            .frame(width: 50, height: 18)
                                            .cornerRadius(100)
                                    })
                                    .buttonStyle(SimpleButtonStyle())
                                }.disabled(rowC>14)
                                    .alert(isPresented: $showAlert) {
                                        Alert(title: Text("It is too long"))
                                    }
                                    .disabled(rowD>1)
                                        .alert(isPresented: $showAlertDot) {
                                            Alert(title: Text("I think that you need only one dot)"))
                                        }
                                        .offset(y:-30)
                                }
                            }
                            Button(action: {amount="0"
                                rowC=0
                                rowD=0
                            }, label:{ Text("AC")
                                    .font(.custom("Academy Engraved LET", size: 15))
                                .frame(width: 50, height: 18)
                                .cornerRadius(100)
                            })
                            .buttonStyle(SimpleButtonStyle())
                            .offset(y:-30)
                        }
                    }.onRotate { newOrientation in
                        orientation = newOrientation
                    }
                }
            }.background(.white)
        }
    }
    func copyToClicBoard(){
        pasteBoard.string = self.amount
    }
    func copyToClicBoard2(){
        pasteBoard.string = self.convert(amount)
    }
    func didTap(button:CalcButton){
        switch button {
        default:
            let number = button.rawValue
            if self.amount == "0" {
                if number == "." {
                    rowD += 1
                    self.amount = "0."
                }
                else {
                    amount = number
                }
            }
            else if number == "."{
                rowD += 1
                if rowD>1{
                    showAlertDot = true
                }
                self.amount = "\(self.amount)\(number)"
            }
            else {
                self.amount = "\(self.amount)\(number)"
            }
        }
    }
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
            .previewInterfaceOrientation(.portrait)
    }
}
