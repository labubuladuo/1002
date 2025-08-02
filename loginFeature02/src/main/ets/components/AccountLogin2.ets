import { CommonConstants, DataUserRegister, DataUserRegisterResult, request, ResultData } from 'common';
import { OtherLogin } from './OtherLogin';

@Extend(Text)
function blueTextStyle(){
  .fontColor('#367BF6')
  .fontSize('14fp')
  .fontWeight(FontWeight.Medium)
}

@Extend(TextInput)
function inputStyle(padding:ResourceStr, onChange:(value: string) => void){
  .placeholderColor('#707578')
  .height(45)
  .fontSize(16)
  .backgroundColor('#F1F3F5')
  .width(CommonConstants.FULL_LENGTH)
  .padding({left:padding})
  .margin({top:12})
  .onChange(onChange)
}
//2xiugai
@Component
export struct AccountLogin {

  buttonColor:ResourceStr = '#367BF6'
  imageColor:ResourceStr = '#71767F'

  @State username:string = "";
  @State password:string = "";
  @Link isDefaultLogin:boolean
  @Link isShowTransition:boolean
  @Styles loginButton(){
    .width(CommonConstants.LOGIN_BUTTON_WIDTH)
    .height(40)
    .backgroundColor(this.buttonColor)
  }

  build() {
    Column(){
      Image($r('app.media.ic_huawei'))
        .width(78)
        .height(78)
        .margin({top:100,bottom:30})

      TextInput({placeholder:"请输入用户名", text:this.username})
        .type(InputType.Normal)
        .inputStyle("12vp", (value:string)=>{
          console.log(value)
        })
        .onChange((value)=>{
          this.username = value
        })

      TextInput({placeholder:"请输入密码", text:this.password})
        .type(InputType.Password)
        .inputStyle("12vp", (value:string)=>{
          console.log(value)
        })
        .onChange((value)=>{
          this.password = value
        })


      Row(){
        Text("短信验证码登录")
          .blueTextStyle()
          .onClick(() => {
            this.isShowTransition = false;
            this.isDefaultLogin = true;
          })
        Text("忘记密码")
          .blueTextStyle()
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width(CommonConstants.FULL_LENGTH)
      .padding(12)
      .margin({top:12})

      Button("登录", {type:ButtonType.Capsule})
        .loginButton()
        .fontSize(16)
        .margin({
          top:'85vp',
          bottom:'12vp'
        })
        .onClick(async ()=>{
          // todo 用户登录
          const Data:DataUserRegister = {
            loginId:this.username,
            loginPwd:'123',
            nickname:''
          }
          request.post<ResultData<DataUserRegisterResult>>('/api/user/reg',Data)
            .then((value:ResultData<DataUserRegisterResult>)=>{
              //登陆完成
              this.getUIContext().showAlertDialog({
                message: JSON.stringify(value)
              })
            })
        })

      Text("注册账号")
        .fontColor('#367BF6')
        .fontSize(16)

      Blank()

      OtherLogin()

    }
    .height(CommonConstants.FULL_LENGTH)
    .width(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
  }
}