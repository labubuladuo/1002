import { preferences } from "@kit.ArkData"

export class PreferencesToken{

  /**
   * 获取preferences首选项对象
   * @param context 上下文
   * @param preferencesFileName preferences文件名
   * @returns preferences对象
   */
  static getPreferences(context?:Context, preferencesFileName = "PreferencesUser"){
    context = context || getContext()
    let options: preferences.Options = { name: preferencesFileName }

    return preferences.getPreferencesSync(context, options);
  }


  /**
   * 通过preferences首选项设置token，也可以用来清空指定名字的token
   * @param tokenId
   * @param tokenValue
   * @param context
   */
  static async setToken(tokenId:string, tokenValue:string, context?:Context){
    const store = PreferencesToken.getPreferences(context);
    store.putSync(tokenId, tokenValue) //存入缓存
    // 持久化写入磁盘
    await store.flush()
  }

  /**
   * 获取指定tokenId的值
   * @param tokenId
   * @param context
   * @returns
   */
  static getToken(tokenId:string, context?:Context){
    const store = PreferencesToken.getPreferences(context);
    return store.getSync(tokenId, "") as string
  }

}