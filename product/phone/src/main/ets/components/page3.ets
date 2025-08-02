@Component
struct Page3Comp {
  @Prop param:Object = 1;
  build() {
    Column(){

      Text('page3')
    }
  }
}

@Builder export function Page3(value:object){
  NavDestination(){
    Page3Comp()
  }
}