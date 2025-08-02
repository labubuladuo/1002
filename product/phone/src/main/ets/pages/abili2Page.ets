import { router } from '@kit.ArkUI';
import { common, Want } from '@kit.AbilityKit';

@Entry
@Component
struct Abili2Page {
  @State message: string = 'Hello World232';

  aboutToAppear(): void {
    this.getUIContext().getHostContext()
  }
  private context:common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  build() {
    RelativeContainer() {
      Text(this.message)

        .onClick(() => {
          this.message = 'Welcome';
          let want:Want = {

          }
          this.context.startAbility(want)
        })
    }
    .height('100%')
    .width('100%')
  }
}

