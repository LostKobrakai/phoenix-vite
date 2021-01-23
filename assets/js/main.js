import 'vite/dynamic-import-polyfill'
import '../css/style.css'
import imgUrl from './../images/phoenix.png'

document.querySelector('#app').innerHTML = `
  <h1>Hello Vite!</h1>
  <img src="${imgUrl}">
  <a href="https://vitejs.dev/guide/features.html" target="_blank">Documentation</a>
`

console.log("ok")
