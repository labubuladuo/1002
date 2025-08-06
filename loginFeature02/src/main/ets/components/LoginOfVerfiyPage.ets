import { CommonConstants, RouterMap } from 'common';
import { promptAction } from '@kit.ArkUI';
import { OtherLogin } from './OtherLogin';
import { AccountLogin } from './AccountLogin2';

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

@Builder
export function
CaptchaLogin() {
  // LoginOfVerifyPage({is})
}

@CustomDialog
@Component
export struct LoginOfVerifyPage {
  private controller: CustomDialogController
  //验证码登录转场动画1出场
  @Link isPresent: boolean
  private Effect1: TransitionEffect =
    TransitionEffect.asymmetric(TransitionEffect.move(TransitionEdge.BOTTOM).animation({ duration: 300 }),
      TransitionEffect.move(TransitionEdge.BOTTOM).animation({ duration: 200 }))
  // 账号密码转场de
  private Effect2: TransitionEffect =
    TransitionEffect.move(TransitionEdge.END).animation({ duration: 300, curve: Curve.EaseOut })
  //验证码登录转场动画2
  private Effect3: TransitionEffect =
    TransitionEffect.asymmetric(TransitionEffect.move(TransitionEdge.START).animation({ duration: 300 }),
      TransitionEffect.move(TransitionEdge.START).animation({ duration: 300 }))
  // 控制验证码登录的展示
  private EffectToTop: TransitionEffect = TransitionEffect.asymmetric(TransitionEffect.move(TransitionEdge.BOTTOM)
    .animation({ duration: 300, curve: Curve.EaseOut }),
    TransitionEffect.move(TransitionEdge.START).animation({ duration: 300, curve: Curve.EaseOut }))
  private EffectToLeft: TransitionEffect =
    TransitionEffect.move(TransitionEdge.START).animation({ duration: 300, curve: Curve.EaseOut })
  @State isShowAccount: boolean = true;
  buttonColor: ResourceStr = '#367BF6'
  imageColor: ResourceStr = '#71767F'
  @State username: string = "";
  @State password: string = "";
  @State allHidden: boolean = false;
  @Link isDefaultLogin: boolean
  @State isShowTransition: boolean = true;

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
  private time1: number = 0;
  time2: number = 0;
  time3: number = 0

  aboutToAppear(): void {
    this.allHidden = false
    this.time3 = setTimeout(() => {
      this.isShowTransition = false;
    }, 32)
  }

  @Link daiLogShow: boolean;

  aboutToDisappear(): void {
    RouterMap.pop()
    clearTimeout(this.time1)
    clearTimeout(this.time2)
    clearTimeout(this.time3)
  }

  testFont() {
    console.log('rend23')
    return 100
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      if (!this.allHidden) {
        if (this.isDefaultLogin) {
          Column() {
            Image($r('app.media.ic_huawei'))
              .width(78)
              .height(78)
              .margin({ top: this.testFont(), bottom: 30 })

            Row() {
              Text("+86")
              Image($r("app.media.ic_right_arrow"))
                .size({ width: 16, height: 16 })
                .margin(10)
              TextInput({ placeholder: "请输入手机号" })
                .type(InputType.PhoneNumber) // 电话号码输入模式
                .backgroundColor(Color.Transparent)
                .caretColor(Color.Grey)
                .width("100%")
                .maxLength(11) // 设置最大输入字符数
                .onChange((value: string) => {

                })
            }
            .width("90%")

            Row() {
              Text("账号密码登录")
                .blueTextStyle()
                .onClick(() => {
                  // 切换登录方式
                  this.isDefaultLogin = false;
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
                promptAction.showToast({ message: "验证码已发送" })

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
          .transition(this.isShowTransition ? this.Effect1 : this.Effect3)
        } else {
          AccountLogin({
            isDefaultLogin: this.isDefaultLogin,
            isShowTransition: this.isShowTransition,
            daiLogShow: this.daiLogShow

          }) // 账户密码登录方式
            .transition(this.Effect2)
        }
      }

      Image($r("app.media.ic_close")) // 通过Stack组件，两个页面只实现一个back
        .width(15)
        .height(15)
        .margin({ top: 50, left: 20 })
        .onClick(() => {
          // this.isPresentLoginView = false;
          this.isShowTransition = true;
          this.time1 = setTimeout(() => {
            this.allHidden = true;
            this.isDefaultLogin = false;
          }, 32)

          this.time2 = setTimeout(() => {
            this.daiLogShow = false;
          }, 300)
        })
    }
    .width("100%")
    .height("100%")

  }
}

