import axios from "axios";
import VueAxios from "vue-axios";
import Vue from "vue";
Vue.use(VueAxios, axios);
// 创建axios 实例
const service = Vue.axios.create({
  baseURL: process.env.VUE_APP_BASE_URL,
  timeout: 15000 // 请求超时时间
});

// request 拦截器
service.interceptors.request.use(
  config => {
    // 这里可以自定义一些config 配置
    return config;
  },
  error => {
    //  这里处理一些请求出错的情况
    Promise.reject(error);
  }
);

// response 拦截器
service.interceptors.response.use(
  response => {
    // 这里处理一些response 正常放回时的逻辑
    const res = response.data;

    if (res && (res.code === 12 || res.code === 900 || res.msg == "未登陆")) {
      //1.获取session
      let token = sessionStorage.getItem("token");
      if (token) {
        //2.设置session
        sessionStorage.setItem("token", "");
        window.location.href = "http://www.xxx.com/";
      }
    }

    return res;
  },
  error => {
    // 这里处理一些response 出错时的逻辑
    if (error.message.indexOf('timeout') !== -1) {
      return Promise.reject('timeout')
    }
    return Promise.reject(error);
  }
);

export default service;
