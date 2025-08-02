import { RouterMap } from 'common'

if(!RouterMap.getBuilder('navPage2')){
  RouterMap.setBuilder('navPage2',wrapBuilder(Page2))
}

@Builder export function Page2(value:object){
  NavDestination(){
    Text('page2')
  }
  .title()
}
