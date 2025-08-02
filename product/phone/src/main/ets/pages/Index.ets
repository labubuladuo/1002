import { logger, RouterMap } from 'common'
import { PromptAction, promptAction } from '@kit.ArkUI'
import { FeatureModule, mainFeatures, otherFeatures} from "../DataModel/FeatureModule"

@Extend(Image)
function imageStyle() {
  .width(30)
  .height(30)
  .margin(15)
}

@Extend(Row)
function routerOnClick(url: string, builderName: string) {
  .clickEffect({ level: ClickEffectLevel.HEAVY })
  .onClick(() => {
    if(url === "" || builderName === ""){
      promptAction.showToast({ message: "该功能还在努力研发中..." });
      return;
    }

    RouterMap.push(url,builderName,"SimpleNotes");
  })
}

@Entry
@Component
struct Index {
  @Provide("pageInfos")
  pageInfos:NavPathStack = new NavPathStack();
  routerName:string = "pageInfos";
  @State loginUser:boolean | undefined = undefined
  @State opacityIndex:number  = 1;

  aboutToAppear(): void {
    this.loginUser = AppStorage.get('login')
    RouterMap.setNavPathInfo(this.routerName, this.pageInfos);
  }

  @Builder userInfoItem(){
    Row(){
      Image($r("app.media.ic_logo_duyi"))
        .width(80)
        .height(80)
        .margin({
          top: -50,
          left: 15
        })
        .borderRadius(5)
        .clip(true)


      Text("登录/注册")
        .fontSize(18)
        .margin(15)
        .fontWeight(FontWeight.Bold)
        .onClick(()=>{
          RouterMap.push('./src/main/ets/components/loginPage','loginfeature02','LoginPageBuilder')
        })

    }
    .width("100%")
  }

  /**
   * 功能组件。
   * @param icon 图标
   * @param text 标签名称
   * @param url 路由地址
   * @param builderName builder名称
   */
  @Builder featureItem(text: ResourceStr, icon: ResourceStr, url: string, builderName:string) {
    Row() {
      Image(icon).imageStyle()
      Text(text)
        .fontSize(18)
        .margin(15)
    }
    .width("100%")
    .routerOnClick(url,builderName)
  }

  @Builder
  pageMap(name:string, params:object){
    RouterMap.getBuilder(name).builder(params);
  }


  build() {
    Navigation(this.pageInfos){
      List({initialIndex:0, space:20}){
        // 占位组件
        ListItem().height(40).selectable(false)

        // 用户登录信息
        ListItemGroup({ style: ListItemGroupStyle.CARD }) {
          ListItem({ style: ListItemStyle.CARD }) {
            this.userInfoItem()
          }.height(60)

          ListItem({ style: ListItemStyle.CARD }) {
            Text("这个人很懒，没有设置签名")
              .width("100%")
              .fontSize(14)
              .fontColor(Color.Grey)
              .margin(15)
              .clickEffect({ level: ClickEffectLevel.HEAVY })
              .onClick(() => {
                promptAction.showToast({ message: "该功能还在开发中" });
              })
          }.height(60)

        }
        .divider({ strokeWidth: 1, color: "#F1F3F5" })

        // 主要功能列表
        ListItemGroup({ style: ListItemGroupStyle.CARD }) {
          ForEach(mainFeatures,(feature:FeatureModule)=>{
            ListItem({ style: ListItemStyle.CARD }) {
              this.featureItem(
                feature.text,
                feature.icon,
                feature.url,
                feature.builderName
              )
            }.height(60)
          })
        }
        .divider({
          strokeWidth: 1,
          color: "#F1F3F5",
          startMargin: 60
        })

        // 其他功能列表
        ListItemGroup({ style: ListItemGroupStyle.CARD }) {
          ForEach(otherFeatures,(feature:FeatureModule)=>{
            ListItem({ style: ListItemStyle.CARD }) {
              this.featureItem(
                feature.text,
                feature.icon,
                feature.url,
                feature.builderName
              )
            }.height(60)
          })
        }
        .divider({
          strokeWidth: 1,
          color: "#F1F3F5",
          startMargin: 60
        })

        if(this.loginUser){
          // 页脚
          ListItemGroup({ style: ListItemGroupStyle.CARD }) {
            ListItem({ style: ListItemStyle.CARD }) {
              Row(){
                Text("退出登录")
                  .fontSize(18)
                  .fontColor(Color.Red)
                  .margin(15)
                  .textAlign(TextAlign.Center)
              }
              .clickEffect({ level: ClickEffectLevel.HEAVY })
              .onClick(() => {
                AlertDialog.show(
                  {
                    message: '确定要退出吗？',
                    autoCancel: true,
                    alignment: DialogAlignment.Bottom,
                    gridCount: 4,
                    offset: { dx: 0, dy: -20 },
                    primaryButton: {
                      value: '取消',
                      action: () => {
                        logger.info("点击了取消")
                      }
                    },
                    secondaryButton: {
                      enabled: true,
                      defaultFocus: true,
                      style: DialogButtonStyle.HIGHLIGHT,
                      backgroundColor:"#40",
                      value: '退出',
                      action: () => {
                        // todo 退出登录
                        logger.info("点击了退出登录")
                        AppStorage.set("login","");
                      }
                    },
                    onWillDismiss:(dismissDialogAction: DismissDialogAction)=> {
                      // 点击如果点击弹出层外部和点击回退取消弹出层
                      if (dismissDialogAction.reason == DismissReason.PRESS_BACK) {
                        dismissDialogAction.dismiss()
                      }
                      if (dismissDialogAction.reason == DismissReason.TOUCH_OUTSIDE) {
                        dismissDialogAction.dismiss()
                      }
                    }
                  }
                )

              })
              .justifyContent(FlexAlign.Center)
            }.height(60)
          }
        }
      }
      .layoutWeight(1)
      .listDirection(Axis.Vertical)
      .edgeEffect(EdgeEffect.Spring)
      .backgroundColor("#F5F5F5")
      .width("100%")
      .height("100%")
    }
    .navDestination(this.pageMap)
    .hideNavBar(false)
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .backgroundColor("#F5F5F5")
    .opacity(this.opacityIndex)
  }
}