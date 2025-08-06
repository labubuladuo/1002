import {
  CommonConstants,
  DataUserRegister,
  DataUserRegisterResult,
  LoginInfo,
  request,
  ResultData,
  RouterMap
} from 'common';
import { OtherLogin } from './OtherLogin';
import { preferences } from '@kit.ArkData';
import { Register } from './registerPage';
import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { Context } from '@ohos.arkui.UIContext';
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

//2xiugai
@Component
export struct AccountLogin {
  buttonColor: ResourceStr = '#367BF6'
  imageColor: ResourceStr = '#71767F'
  private context: Context | null = null
  @State username: string = "";
  @State password: string = "";
  @State isShow: boolean = false;
  @Link isDefaultLogin: boolean
  @Link isShowTransition: boolean
  @Link daiLogShow:boolean
  @Builder
  registerBuilder() {
    Register({
      isShow: this.isShow
    })
  }

  aboutToAppear(): void {
    this.context = this.getUIContext().getHostContext() as Context;
  }

  // private context:common.UIAbilityContext = this.getUIContext().getHostContext()
  @Styles
  loginButton(){
    .width(CommonConstants.LOGIN_BUTTON_WIDTH)
    .height(40)
    .backgroundColor(this.buttonColor)
  }

  build() {
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
            this.isShowTransition = false;
            this.isDefaultLogin = true;
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
            loginPwd: this.password,
            nickname: this.username
          }
          request.post<ResultData<LoginInfo>>('/api/user/login', Data)
            .then(async (data: ResultData<LoginInfo>) => {

              AppStorage.setOrCreate('loginInfo', data)
              try {
                const myStore =
                  preferences.getPreferencesSync(this.context, { name: 'myStore' })
                await myStore.put('loginInfo', JSON.stringify(data))
                await myStore.flush()
              } catch (e) {
                this.getUIContext().showAlertDialog({
                  message: JSON.stringify((e as BusinessError))
                })
              }
              promptAction.showToast({
                message: '登录成功！',
                duration:1500,
                backgroundColor:'#eee'
              })
              this.daiLogShow = false;
            })
            .catch((err: BusinessError) => {
              this.getUIContext().showAlertDialog({
                message: JSON.stringify(err) + 'error'
              })
            })
        })

      Text("注册账号")
        .onClick(() => {

          this.isShow = true;
        })
        .fontColor('#367BF6')
        .fontSize(16)

      Blank()

      OtherLogin()

    }
    .bindContentCover($$this.isShow, this.registerBuilder, {})
    .height(CommonConstants.FULL_LENGTH)
    .width(CommonConstants.FULL_LENGTH)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
  }
}