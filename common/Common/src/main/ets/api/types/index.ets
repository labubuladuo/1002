import { common } from "@kit.AbilityKit";

export class ResultData<T> {
  code: number
  msg: string
  data: T | null

  constructor(code: number, msg: string, data: T | null) {
    this.code = code;
    this.msg = msg;
    this.data = data;
  }
}

export interface ResponseHeader {
  'Content-Type': string
  'authorization': string
  'Connection': string
}

export interface ReqPage {
  page: number
  size: number
}

export interface DataUserRegister {
  loginId: string;

  /**
   * 密码，不超过20个字符
   */
  loginPwd: string;

  /**
   * 昵称，可重复，不超过20个字符
   */
  nickname: string;
}

export interface DataUserRegisterResult {
  id: string;

  /**
   * 密码，不超过20个字符
   */
  loginId: string;

  /**
   * 昵称，可重复，不超过20个字符
   */
  nickname: string;
}

export interface LoginInfo{
  id: string;
  loginId: string;
  nickname: string;
}
