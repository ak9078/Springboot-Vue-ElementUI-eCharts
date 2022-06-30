import Vue from "vue";

import Cookies from "js-cookie";
import "normalize.css/normalize.css"; // a modern alternative to CSS resets

import Element from "element-ui";
import "./styles/element-variables.scss";

import "@/styles/index.scss"; // global css

import "@/assets/iconfont/iconfont.css"; // 全局引用这个字体图标css样式

import App from "./App";
import store from "./store";
import router from "./router";

import * as filters from "./filters"; // global filters

Vue.use(Element, {
  size: Cookies.get("size") || "medium" // set element-ui default size
});

// register global utility filters
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key]);
});

/**
 * 时间格式化
 * @param {Date} date
 * @param {String} fmt 格式
 */
Vue.prototype.dateFormat = function(date, fmt) {
  let ret;
  const opt = {
    "y+": date.getFullYear().toString(), // 年
    "M+": (date.getMonth() + 1).toString(), // 月
    "d+": date.getDate().toString(), // 日
    "H+": date.getHours().toString(), // 时
    "m+": date.getMinutes().toString(), // 分
    "s+": date.getSeconds().toString() // 秒
    // 有其他格式化字符需求可以继续添加，必须转化成字符串
  };
  for (let k in opt) {
    ret = new RegExp("(" + k + ")").exec(fmt);
    if (ret) {
      fmt = fmt.replace(
        ret[1],
        ret[1].length == 1 ? opt[k] : opt[k].padStart(ret[1].length, "0")
      );
    }
  }
  return fmt;
};

Vue.config.productionTip = false;

new Vue({
  el: "#app",
  router,
  store,
  render: h => h(App)
});
