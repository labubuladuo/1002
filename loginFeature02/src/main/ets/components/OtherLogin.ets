@Component
export struct OtherLogin {
  build() {
    Column(){
      Text("其他登录方式")
        .fontColor('#71767F')
        .fontSize(12)
        .margin({
          bottom:12
        })

      Row({space:30}){
        Button({type:ButtonType.Circle, stateEffect:true}){
          Image($r('app.media.ic_qq'))
            .fillColor('#71767F')
        }
        .width(48)
        .height(48)
        .backgroundColor('#F1F3F5')

        Button({type:ButtonType.Circle, stateEffect:false}){
          Image($r('app.media.ic_wechat'))
            .fillColor('#71767F')
        }
        .width(48)
        .height(48)
        .backgroundColor('#F1F3F5')

        Button({type:ButtonType.Circle, stateEffect:true}){
          Image($r('app.media.ic_weibo'))
            .fillColor('#71767F')
        }
        .width(48)
        .height(48)
        .backgroundColor('#F1F3F5')
      }
      .margin({
        bottom: 12
      })
    }

  }
}