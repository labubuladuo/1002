export { MainPage } from './src/main/ets/components/MainPage';
export {page1Harcb} from "./src/main/ets/components/page1Harcb"
export async function  initMap(path:string){

  switch (path){
    case './src/main/ets/components/page1Harcb':
      await import ('./src/main/ets/components/page1Harcb')
    break;
  }
}