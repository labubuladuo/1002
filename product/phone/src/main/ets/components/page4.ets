@Component
struct pageComp {
  private pageInfos:NavPathStack = new NavPathStack()
  build() {
    NavDestination(){
      Text('page4')

      Button('跳转page2').onClick((event: ClickEvent) => {
        this.pageInfos.pushPath({
          name:'navPage2',
          param:new Object({
            name:'marry',
            age:98
          })
        })
      })

    }
    .onReady((data:NavDestinationContext)=>{
      this.pageInfos = data.pathStack;
    })
  }
}

@Builder export function Page4(value:object){
  pageComp()
}