import { RouterMap } from 'common'

// import {BuilderMap} from "./.."
if(!RouterMap.getBuilder('navPage1')){
  const builder:WrappedBuilder<[object]> = wrapBuilder(Page1)
  RouterMap.setBuilder('navPage1',builder)
}
@Builder export function Page1(value:object){
page1({value})
}

@Component
struct page1 {
 private pageInfos:NavPathStack = new NavPathStack()
  @Prop value:object
  build() {
    NavDestination(){
      Column(){
        Button('跳转Page22')
          .onClick(async ()=>{
            await import ('./page2')
            this.pageInfos.pushPath({
              name:'navPage2',
              param:new Object({name:'xiaoqiang'})
            })
          })
      }
    }
    .onReady((data:NavDestinationContext)=>{

      this.pageInfos = data.pathStack
    })
    .title(JSON.stringify(this.value))

  }
}