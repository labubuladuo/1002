export class ResultData <T> {
  code: number
  msg: string
  data: T | null

  constructor(code: number, msg: string, data: T | null) {
    this.code = code;
    this.msg = msg;
    this.data = data;
  }
}

export interface ResponseHeader{
  'Content-Type':string
  'authorization':string
  'Connection':string
}

export interface ReqPage{
  page:number
  size:number
}