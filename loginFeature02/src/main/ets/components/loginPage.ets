import { Interceptor, InterceptorExecute, RouterMap } from 'common';
import { promptAction } from '@kit.ArkUI';
import { CaptchaLogin, LoginOfVerifyPage } from './LoginOfVerfiyPage';



// @CustomDialog
// @Component export
// struct Index {
//
//
//   build() {
//
//   }
// }

// struct captchaLogin {
//   aboutToDisappear(): void {
//     this.getUIContext().showAlertDialog({
//       message: JSON.stringify('???')
//     })
//   }
//   @State test:string = 'captcha'
//   build() {
//     Column() {
//       Text('captcha')
//         .onClick(()=>{
//           this.test = '88888888'
//         })
//     }
//
//     .width('100%')
//     .height('100%').backgroundColor(Color.Blue)
//   }
// }
//
// @Component
// struct LoginComp {
//   aboutToDisappear(): void {
//     this.getUIContext().showAlertDialog({
//       message: JSON.stringify('login !!!')
//     })
//   }
//   @Link isPresent:boolean
//   @Link captchaPageIsShow:boolean
//   build() {
//     Text('captchaLogin')
//       .onClick(() => {
//         this.isPresent = false;
//         this.captchaPageIsShow = true;
//       })
//   }
// }



@Extend(Image)
function LoginImage() {
  .height(40)
  .width(40)
  .fillColor('#ffa09696')
}

@Component
export struct LoginPage {
  // pageInfos: NavPathStack = new NavPathStack()
  // // 初始登录页面是否显示
  // @State isPresent: boolean = true;
  // @State sheetHeight: number = 500;
  // // 是否同意协议
  // @State isConfirmed: boolean = false
  // // 验证码页面的显示
  // @State captchaPageIsShow: boolean = false;
  //
  // @Builder
  // loginBuilder() {
  //   LoginComp({
  //     isPresent:this.isPresent,
  //     captchaPageIsShow:this.captchaPageIsShow
  //   })
  // }
  //
  // @Builder
  // captchaLoginBuilder() {
  //   captchaLogin()
  // }
  //
  // build() {
  //   NavDestination() {
  //     Row()
  //       .bindContentCover($$this.captchaPageIsShow,this.captchaLoginBuilder())
  //     // Row()
  //       .bindSheet($$this.isPresent, this.loginBuilder(), {
  //         height: 800,
  //         backgroundColor: '#eee'
  //       })
  //
  //
  //   }
  //   .onReady((data: NavDestinationContext) => {
  //     this.pageInfos = data.pathStack
  //   })
  // }

  @State message: string = '登录页面';
  @Prop value: object;
  pathInfos: NavPathStack = new NavPathStack()
  // 初始登录页面是否显示
  @State isPresent: boolean = true;
  @State sheetHeight: number = 500;
  // 是否同意协议
  @State isConfirmed: boolean = false
  // 验证码页面的显示
  @State captchaPageIsShow: boolean = false;
  // 底部other登录方式builder
  @Builder
  OtherLogin() {
    Column({ space: 20 }) {
      Row() {
        Text('其他登录方式')
      }

      Row({ space: 20 }) {
        Image($r('app.media.ic_qq'))
          .LoginImage()
        Image($r('app.media.ic_weibo'))
          .LoginImage()
        Image($r('app.media.ic_wechat'))
          .LoginImage()
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }


  // 半模态
  @Builder
  popupModalLogin() {
    Column() {
      Image($r('app.media.ic_huawei'))
        .width(78)
        .height(78)
        .margin({ top: 30, bottom: 10 })

      Text("18888888888")
        .fontColor(Color.Black)
        .fontSize(30)
        .fontWeight(50)
        .padding({ top: 30, bottom: 30 })

      Button("手机号码一键登录")
        .fontColor(Color.White)
        .type(ButtonType.Normal)
        .backgroundColor("#E72A2B")
        .onClick(() => {
          // todo 手机号码一键登录处理
          if (this.isConfirmed) {
            AppStorage.setOrCreate("login", true);
            RouterMap.pop();
            promptAction.showToast({
              message: "登录成功"
            })
          } else {
            promptAction.showToast({
              message: "请先阅读并确认协议"
            })
          }
        })
        .width("90%")
        .height(50)
        .margin({ left: 12, right: 12, bottom: 10 })

      Button("手机验证码登录")
        .fontColor(Color.Black)
        .borderRadius(1)
        .type(ButtonType.Normal)
        .backgroundColor("#FEFEFE")
        .border({
          color: "#A3A3A3",
          width: 1
        })
        .onClick(() => {
          // todo 手机验证码登录
          if (this.isConfirmed) {
            this.DialogisShow = true;
            this.captchaPageIsShow = true;
            this.isPresent = false;
            // this.isPresent = false;
          } else {
            promptAction.showToast({
              message: "请先阅读并确认协议"
            })
          }
        })
        .width("90%")
        .height(50)
        .margin({ bottom: 30 })
      Blank()

      this.OtherLogin()
      Row() {
        Checkbox({ name: 'checkbox' })
          .select(this.isConfirmed)
          .width(14)
          .onChange((value: boolean) => {
            this.isConfirmed = value;
          })
        Text() {
          Span("阅读并同意")
            .fontColor("#999999")
          Span("服务协议")
            .fontColor("#368AEF")
            .onClick(() => {
              promptAction.showToast({ message: "此功能暂未开放" });
            })
        }.fontSize(14)
      }
      .margin({ left: 32 })
      .width("100%")
    }
  }
  DaiLogShow(){
    if(this.DialogisShow){
      this.dialogController?.open()
    }else{
      this.dialogController?.close()
    }
  }
  @State @Watch('DaiLogShow') DialogisShow:boolean = false;

  // 自定义弹窗的偏移量
  dialogController: CustomDialogController | null = new CustomDialogController({
    builder:LoginOfVerifyPage({
      isDefaultLogin:this.captchaPageIsShow,
      isPresent:this.isPresent,
      daiLogShow:this.DialogisShow
    }),
    autoCancel: false,
    onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
      console.info("reason=" + JSON.stringify(dismissDialogAction.reason));
      console.info("dialog onWillDismiss");
      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
        dismissDialogAction.dismiss();
      }
      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
        dismissDialogAction.dismiss();
      }
    },
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: true,
    cornerRadius: 10,
    height:'100%',
    isModal:false
  })
  @LocalStorageLink('dialogController') controller:CustomDialogController | null = this.dialogController

build() {

    NavDestination() {
      Column() {
        Text()
          .bindSheet($$this.isPresent, this.popupModalLogin(), {
            height: this.sheetHeight, // 半模态窗口的高度
            dragBar: true,
            showClose: true,
            preferType: SheetType.POPUP,
            backgroundColor: '#F5F5F5',
            shouldDismiss: (sheetDismiss: SheetDismiss) => {
              sheetDismiss.dismiss()
              RouterMap.pop();

            }
          })

        //
        // Text()
        //   .bindContentCover($$this.captchaPageIsShow, CaptchaLogin)
      }
      .justifyContent(FlexAlign.Center)
      .size({ width: '100%', height: '100%' })
      .padding(12)
    }
    .mode(NavDestinationMode.DIALOG)
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathInfos = context.pathStack
    })
    .onBackPressed(() => {
      RouterMap.pop("pageInfos");
      return true;
    })

  }
}

@Builder
export
function LoginPageBuilder(value: object) {
  LoginPage()
}

if (!RouterMap.getBuilder("LoginPageBuilder")) {
  const builder: WrappedBuilder<[object]> = wrapBuilder(LoginPageBuilder);
  RouterMap.setBuilder("LoginPageBuilder", builder);
}
class MyInterceptorExecute implements InterceptorExecute{
  executeFunction(builderName: string, param?: object | undefined): boolean {
    return false;
  }
}
Interceptor.registerInterceptorFn('LoginPageBuilder',new MyInterceptorExecute())
