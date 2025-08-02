export { MainPage } from './src/main/ets/components/MainPage';

export { page1Harc } from './src/main/ets/components/page1Harc'

export async function initMap(path: string) {
  switch (path) {
    case './src/main/ets/components/page1Harc':
      await import('./src/main/ets/components/page1Harc')
      break;
    case '':
      await import('./src/main/ets/components/MainPage')
      break;
  }
}
