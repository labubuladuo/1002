export { LoginPage } from './src/main/ets/components/loginPage';
export {LoginOfVerifyPage} from "./src/main/ets/components/LoginOfVerfiyPage"
export {NeedLoginPage} from"./src/main/ets/components/TestRouterMap"
export async function initMap(path:string){
  switch (path){
    case './src/main/ets/components/loginPage':
      await import('./src/main/ets/components/loginPage')
    break

    case './src/main/ets/components/LoginOfVerfiyPage':
      await import('./src/main/ets/components/LoginOfVerfiyPage')
    break

    case './src/main/ets/components/TestRouterMap':
      await import('./src/main/ets/components/TestRouterMap')
  }
}