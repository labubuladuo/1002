// const pageInfos:NavPathStack = AppStorage.get('pageInfos') as NavPathStack;
@Builder
export function page36(value: object) {
  Appstorage()
}

@Component
struct Appstorage {
  pageInfos: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    this.pageInfos = AppStorage.get('pageInfos') as NavPathStack
  }

  build() {
    NavDestination() {
      Text('appStorage')

      Button('跳转到page3').onClick((event: ClickEvent) => {

        this.pageInfos.pushPath({
          name: 'navPage3',
        })
      })
    }
  }
}