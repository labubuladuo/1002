// @Builder
// export
// function NeedLoginPage() {
//   Index()
// }
//
// @Component
// struct Index {
//   @State isLogin:string = ''
//   aboutToAppear(): void {
//     if(!AppStorage.get('login')){
//      this.isLogin = 'unLogin'
//     }
//     else{
//       this.isLogin = AppStorage.get('login') as string
//     }
//   }
//   build() {
//     Column(){
//       Text('NeedLoginPageIndex')
//       Text(this.isLogin)
//     }
//   }
// }