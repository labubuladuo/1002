@Entry
@Component
struct I2 {
  @State isShow:boolean = false
  @Builder
  builder(){

    Index({isShow:this.isShow})
  }
  build() {
    Text('1221')
      .onClick(()=>{
        this.isShow = true;
      })
      .bindContentCover($$this.isShow,this.builder)
  }
}

@Component
struct Index {
  @Link isShow:boolean
  build() {
    Column(){
      Text('2323')
        .onClick(()=>{
          this.isShow = false;
        })
    }
  }
}