import { RouterMap } from 'common'

if(!RouterMap.getBuilder('navPage1har')){

  const b:WrappedBuilder<[object]> = wrapBuilder(Page1har)
  RouterMap.setBuilder('navPage1har',b)
}
@Builder export function Page1har(value:object){
  NavDestination(){
    Text('page1har')

    Button().onClick((event: ClickEvent) => {

    })
  }
  .onReady((data:NavDestinationContext)=>{

  })

}