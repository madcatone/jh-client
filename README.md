# 使用說明

## gem依賴
```
gem install 'awesome_print'
gem install 'rest-client'
gem install 'yaml'
gem install 'roo'  #非必要
```

## 使用方式
`> ruby eyes-client.rb 1 0 0 'dev' 3`
第一個1代表報警
第二個1代表`無`心跳上傳
第三個1代表`無`log上傳
第四個dev代表development
第五個3代表上傳三個thread

`> ruby eyes-client.rb 0 1 1 'pro' 2`
第一個0代表`無`報警
第二個1代表心跳上傳
第三個1代表log上傳
第四個pro代表production
第五個2代表上傳2個thread

## 參數
編輯`data.yml`
```
log: [
  "升级结束, 已经是最新版本, 退出升级",
  "发现新版本， 开始升级， 请保持无线信号稳定",
  "发现新版本， 开始升级应用1",
  "移动网络已连接",
  "解压成功",
  "start full apk down!",
  ]
platform:
  dev: 'http://localhost:3000/'
  pro: 'http://123.123.234.234/'
sim:
  dev: '460019913509999'
  pro: '460015620783000'
location:
  lng: "121.4808893486593"
  lat: "31.229565891634657"
```
