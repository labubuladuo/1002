export class FeatureModule{
  text: ResourceStr
  icon: ResourceStr
  url: string
  builderName:string
  param?:object

  constructor(text: ResourceStr, icon: ResourceStr, url: string, builderName: string) {
    this.text = text
    this.icon = icon
    this.url = url
    this.builderName = builderName
  }
}

export const mainFeatures:FeatureModule[] = [
  new FeatureModule("记事本", $r("app.media.ic_note"), "notesFeature/src/main/ets/views/MainPage", "notesFeature_MainPage"),
  new FeatureModule("录音笔", $r("app.media.ic_voice"), "audioFeature/src/main/ets/views/MainPage", "audioFeature_MainPage"),
  new FeatureModule("影像记忆", $r("app.media.ic_video"), "harAFeature/src/main/ets/components/pages/Page1", "harAFeature_Page1"),
  new FeatureModule("代办事项", $r("app.media.ic_todo"), "harAFeature/src/main/ets/components/pages/Page2", "harAFeature_Page2"),
  new FeatureModule("图片", $r("app.media.ic_image"), "harBFeature/src/main/ets/components/pages/Page1", "harBFeature_Page1"),
  new FeatureModule("归档", $r("app.media.ic_archive"), "harCFeature/src/main/ets/components/pages/Page1", "harCFeature_Page1"),
]

export const otherFeatures:FeatureModule[] = [
  new FeatureModule("收藏", $r("app.media.ic_collect"), "", ""),
  new FeatureModule("设置", $r("app.media.ic_setup"), "", ""),
  new FeatureModule("关于", $r("app.media.ic_info"), "", ""),
]

