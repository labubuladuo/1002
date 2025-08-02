import { Interceptor, InterceptorExecute, RouterMap } from "common"

@Builder export function page1Harc(param:object){
  Index({value:param})
}

@Component
struct Index {
  @Prop value:object
  build() {
NavDestination(){    Text('page1Harc')
}
  }
}
if(!RouterMap.getNavPathInfo('page1Harc')){
  RouterMap.setBuilder('page1Harc',(wrapBuilder(page1Harc)))
}
export class MyPageInterceptorExecute implements InterceptorExecute{
  executeFunction(builderName: string, param: object): boolean {
    if(builderName!==undefined&& builderName==='page1Harc'){
      if(!AppStorage.get('login')){
        RouterMap.push('./src/main/ets/components/loginPage','loginfeature02','LoginPageBuilder',new Object({}))
        return true;
      }else{return false}

    }
    return false;
  }
}

Interceptor.registerInterceptorFn('page1Harc',new MyPageInterceptorExecute())

