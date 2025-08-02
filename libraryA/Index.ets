export { MainPage } from './src/main/ets/components/MainPage';
export {Page1har}from './src/main/ets/pages/paga1har'
export async  function initImport(path:string){
  switch (path){
    case './src/main/ets/pages/paga1har':
      await import ('./src/main/ets/pages/paga1har')
    break;
      case '':
        await import('./src/main/ets/pages/paga1har')
    break

  }
}