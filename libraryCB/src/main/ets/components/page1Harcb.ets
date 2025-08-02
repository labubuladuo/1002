import { RouterMap } from "common"

@Builder export function page1Harcb(param:object){
  Index({
    value:param
  })
}

@Component
struct Index {

  @Prop value:object
  build() {
    NavDestination(){
      Text('harBc')
    }
  }
}

if(!RouterMap.getBuilder('page1Harcb')){
  RouterMap.setBuilder('page1Harcb',wrapBuilder(page1Harcb))
}