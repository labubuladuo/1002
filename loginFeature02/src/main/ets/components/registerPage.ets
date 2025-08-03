import { CommonConstants, DataUserRegister, DataUserRegisterResult, LoginInfo,
  request,
  ResultData, RouterMap } from 'common';
import { promptAction } from '@kit.ArkUI';
import { OtherLogin } from './OtherLogin';
import { AccountLogin } from './AccountLogin2';
import { preferences } from '@kit.ArkData';

@Extend(Text)
function blueTextStyle() {
  .fontColor('#367BF6')
  .fontSize('14fp')
  .fontWeight(FontWeight.Medium)
}

@Extend(TextInput)
function inputStyle(padding: ResourceStr, onChange: (value: string) => void) {
  .placeholderColor('#707578')
  .height(45)
  .fontSize(16)
  .backgroundColor('#F1F3F5')
  .width(CommonConstants.FULL_LENGTH)
  .padding({ left: padding })
  .margin({ top: 12 })
  .onChange(onChange)
}


@Component
export struct Register {
  //验证码登录转场动画1出场
  @Link isShow: boolean
  buttonColor: ResourceStr = '#367BF6'
  imageColor: ResourceStr = '#71767F'
  @State username: string = "";
  @State password: string = "";

  @Styles
  loginButton(){
    .width(CommonConstants.LOGIN_BUTTON_WIDTH)
    .height(40)
    .backgroundColor(this.buttonColor)
  }

  //todo 疑似bug在bindCover下
  // aboutToDisappear(): void {
  //   this.getUIContext().showAlertDialog({
  //     message: JSON.stringify('go')
  //   })
  // }


  testFont() {
    console.log('rend23')
    return 100
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Image($r('app.media.ic_huawei'))
          .width(78)
          .height(78)
          .margin({ top: 100, bottom: 30 })

        TextInput({ placeholder: "请输入用户名", text: this.username })
          .type(InputType.Normal)
          .inputStyle("12vp", (value: string) => {
            console.log(value)
          })
          .onChange((value) => {
            this.username = value
          })

        TextInput({ placeholder: "请输入密码", text: this.password })
          .type(InputType.Password)
          .inputStyle("12vp", (value: string) => {
            console.log(value)
          })
          .onChange((value) => {
            this.password = value
          })


        Row() {
          Text("短信验证码登录")
            .blueTextStyle()
            .onClick(() => {
            })
          Text("忘记密码")
            .blueTextStyle()
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(CommonConstants.FULL_LENGTH)
        .padding(12)
        .margin({ top: 12 })

        Button("登录", { type: ButtonType.Capsule })
          .loginButton()
          .fontSize(16)
          .margin({
            top: '85vp',
            bottom: '12vp'
          })
          .onClick(async () => {
            // todo 用户登录
            const Data: DataUserRegister = {
              loginId: this.username,
              loginPwd: '123',
              nickname: this.username
            }
            request.post<ResultData<DataUserRegisterResult>>('/api/user/reg', Data)
              .then(async (value: ResultData<DataUserRegisterResult>) => {
                //登陆完成
                // this.getUIContext().showAlertDialog({
                //   message: JSON.stringify(value)
                // })

                //   登录
                interface login  {
                  loginId:string
                  loginPwd:string
                }
                const loginData:login ={
                  loginId:this.username,
                  loginPwd:this.password
                }

                request.post<ResultData<LoginInfo>>('/api/user/login',loginData)
                  .then(async (data:ResultData<LoginInfo>)=>{
                    AppStorage.setOrCreate('loginInfo', value)
                    AppStorage.setOrCreate('userInfo',data)
                    const myStore = preferences.getPreferencesSync(this.getUIContext().getHostContext(), { name: 'myStore' })
                    await myStore.put('loginInfo',value)
                    await myStore.put('userInfo',data)
                    myStore.flushSync()
                    this.getUIContext().showAlertDialog({
                      message: JSON.stringify(AppStorage.get('userInfo'))
                    })
                  })
              })
          })

        Text("注册账号")
          .onClick(()=>{

          })
          .fontColor('#367BF6')
          .fontSize(16)

        Blank()

        OtherLogin()

      }
      .height(CommonConstants.FULL_LENGTH)
      .width(CommonConstants.FULL_LENGTH)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.White)// 账户密码登录方式

      Image($r("app.media.ic_close")) // 通过Stack组件，两个页面只实现一个back
        .width(15)
        .height(15)
        .margin({ top: 50, left: 20 })
        .onClick(() => {
          // this.isPresentLoginView = false;
          this.isShow = false;
          // RouterMap.pop()
        })
    }
    .width("100%")
    .height("100%")

  }
}
