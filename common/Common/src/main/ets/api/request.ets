import { http } from '@kit.NetworkKit'
import { logger } from '../util/Logger'
import { ResponseHeader, ResultData } from './types'
import { promptAction } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import { PreferencesToken } from '../util/PreferencesToken'

const httpRequest = http.createHttp()

httpRequest.on("headersReceive", (header)=>{
  if((header as ResponseHeader).authorization){
    PreferencesToken.setToken("UserToken", (header as ResponseHeader).authorization)
  }
})

const BASE_URL = "https://study.duyiedu.com"

async function requestHandle<T>(
  url:string,
  method:http.RequestMethod = http.RequestMethod.GET,
  params?:object): Promise<T>{

  let full_url = BASE_URL + url

  // 如果是get请求，并且params不为空，那么需要将请求参数拼接到full_url
  if(method === http.RequestMethod.GET){
    if(params && Object.keys(params).length){
      full_url += "?" + Object.keys(params).map(key=>{
        if(params[key]){
          return `${key}=${params[key]}`
        }
        return ""
      }).join("&")
    }
  }

  logger.info("HttpRequest", full_url)


  const config:http.HttpRequestOptions = {
    method,
    header: {
      'Content-Type': 'application/json'
    },
    // post请求方式直接放入params对象
    extraData: method === http.RequestMethod.GET ? "" : params
  }

  try {
    const res = await httpRequest.request(full_url, config)

    if (res.responseCode === http.ResponseCode.UNAUTHORIZED) {
      // 没有权限 401
      return Promise.reject(new Error("请检查是否具有访问权限"))
    } else if (res.responseCode === http.ResponseCode.NOT_FOUND) {
      // 服务器没有相关资源 404
      return Promise.reject(new Error("服务器没有相关资源 404"))
    } else {

      if (res.responseCode === http.ResponseCode.OK) {
        const result = JSON.parse(res.result as string) as ResultData<T>

        // 因为ResultData中有其他属性，比如code，msg等，
        // 这里只想在Promise<T>中，返回具体的类型的值

        return result.data as T
      } else {
        return Promise.reject(new Error("网络异常波动"))
      }

    }
  } catch (e) {
    promptAction.showToast({
      message: (e as BusinessError).code + "---" + (e as BusinessError).message
    })
    return Promise.reject(e)
  }
}

class Request{
  // get
  get<T>(url:string, params?:object):Promise<T>{
    return requestHandle<T>(url, http.RequestMethod.GET, params)
  }

  // post
  post<T>(url:string, params?:object):Promise<T>{
    return requestHandle<T>(url, http.RequestMethod.POST, params)
  }
  // delete put
}

export const request = new Request()