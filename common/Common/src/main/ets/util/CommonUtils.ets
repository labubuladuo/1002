import { router } from "@kit.ArkUI"

export class RouterMap {
  static builderMap: Map<string, WrappedBuilder<[object]>> = new Map<string, WrappedBuilder<[object]>>()
  static navPathMap: Map<string, NavPathStack> = new Map<string, NavPathStack>()

  // static routerMapItem:Map<string,RouterMapItem> = new Map<string,RouterMapItem>()
  // public static setRouterMapItem(name:string,)
  //设置路由栈（navigation）
  public static setNavPathInfo(pathInfoName: string, pathInfo: NavPathStack) {
    RouterMap.navPathMap.set(pathInfoName, pathInfo)
  }

  //删除当前路由
  public static pop(navPathName: string='pageInfos') {

    RouterMap.navPathMap.get(navPathName)?.pop()
  }

  //全部删除当前路由栈
  public static clear(navPathName: string) {
    RouterMap.navPathMap.get(navPathName)?.clear()
  }

  //获取pathInfo
  public static getNavPathInfo(pathInfoName: string): NavPathStack {
    return RouterMap.navPathMap.get(pathInfoName) as NavPathStack;
  }

  //获取builder
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    return RouterMap.builderMap.get(builderName) as WrappedBuilder<[object]>
  }

  //设置builder
  public static setBuilder(builderName: string, builder: WrappedBuilder<[object]>) {
    RouterMap.builderMap.set(builderName, builder)
  }

  //   跳转指定地址
  public static async push(path: string, bundleName: string, builderName: string, param?: object, routerName?: string) {
    if (!RouterMap.builderMap.has(builderName)) {
      const esModule: ESObject = await import(bundleName)
      esModule.initMap(path)
    }
    if( Interceptor.interceptor(builderName)){
      return;
    }
    RouterMap.navPathMap.get('pageInfos')!.pushPath({
      name: builderName,
      param
    })
  }
}


export class Interceptor {
  public static interceptor(builderName: string,param?:object): boolean {
    if(Interceptor.listInterceptorExecute.get(builderName)){
      return Interceptor.listInterceptorExecute.get(builderName)!.executeFunction(builderName,param)
    }
    return false;
  }

  public static listInterceptorExecute: Map<string,InterceptorExecute> = new Map<string,InterceptorExecute>()

  public static registerInterceptorFn(key:string,interceptorFn: InterceptorExecute) {
    Interceptor.listInterceptorExecute.set(key,interceptorFn)
  }
}

export interface InterceptorExecute {
  executeFunction(builderName: string, param?: object): boolean
}

export class CommonUtils {
  public static getRandomColor() {
    let color = "#"
    // RGB 红绿蓝
    for (let i = 0; i < 3; i++) {
      const part = Math.floor(Math.random() * 256).toString(16);
      color += part.padStart(2, "0");
    }

    return color;
  }

  public static getRandom(min: number = 150, max: number = 200) {
    return Math.ceil(Math.random() * (max - min + 1) + min);
  }

  public static generatorArray(initNumber: number, increment: number = 0, initValue: number = 0) {
    let arr: number[] = Array(initNumber).fill(initValue).map((_: number, index: number) => index + increment)
    return arr;
  }

  public static formatDate(date: Date): string {
    if (isNaN(date.getTime())) {
      throw new Error("错误的日期格式")
    }

    const pad = (num: number): string => num < 10 ? '0' + num.toString() : num.toString();

    const year = date.getFullYear(); // 获取年份
    const month = pad(date.getMonth() + 1) // 获取月份，从0-11
    const day = pad(date.getDate());
    const hour = pad(date.getHours());
    const minute = pad(date.getMinutes());
    const second = pad(date.getSeconds());

    return `${year}-${month}-${day} ${hour}:${minute}:${second}`
  }
}

class RouterMapItem {
  auth: boolean
  builder: WrappedBuilder<[object]>

  constructor(auth: boolean, builder: WrappedBuilder<[object]>) {
    this.auth = auth;
    this.builder = builder;
  }
}