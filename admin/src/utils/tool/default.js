import baseInterceptors from "@/utils/baseInterceptors";

import axios from "axios";

import {
  Message
} from "element-ui";

export default {
  // 1.状态的查询
  getStatus,
  // 请求
  queryApi,
  // 获取列表
  getList,
  // 获取列表
  getDetail,
  // 操作
  doSth,
  // 导出文件(文件流)
  download,
  // 导出文件
  downloadUrl,
  // 弹窗
  showMessage,
  // 上移
  zIndexUp,
  // 下移
  zIndexDown,
  // 置顶
  zIndexTop,
  // 置底
  zIndexBottom
};

function showMessage(msg, type = "warning") {
  if (type == "warning") {
    Message.warning({
      message: msg,
      customClass: "max-z-index"
    });
  } else {
    Message.success({
      message: msg,
      customClass: "max-z-index"
    });
  }
}
/**
 * @description 导入状态
 */
function getStatus(arr, status) {
  if (status == undefined) {
    return arr;
  }
  let res = "";
  arr.forEach(element => {
    if (element.value == status) {
      res = element.label;
    }
  });
  return res;
}
/**
 * @description 请求api
 */
function queryApi(query, url, method) {
  let data = {
    url: url,
    method: method,
    headers: {
      token: sessionStorage.getItem("token")
    }
  };
  if (method == "get") {
    data.params = query;
  } else {
    data.data = query;
  }
  return baseInterceptors(data);
}

/**
 * @description 获取列表
 * 1.query 请求对象
 * 2.url 请求url
 * 3.请求方法method
 * 4.回调函数listFunc
 * 5.成功的code  successCode
 * 6.消息的英文 msgKey
 */
async function getList(query, url, method, listFunc, successCode, msgKey) {
  let res = {};
  let data = {};
  if (successCode == undefined) {
    successCode = 0;
  }
  if (msgKey == undefined) {
    msgKey = "msg";
  }

  //筛选query去除空的内容
  for (var key in query) {
    if (query[key] !== "") {
      data[key] = query[key];
    }
  }
  //调用接口,获取返回内容
  await queryApi(data, url, method)
    .then(response => {
      if (response.code == successCode) {
        res = listFunc(response);
      } else {
        this.showMessage(
          response[msgKey] ? response[msgKey] : "获取列表失败",
          "warning"
        );
      }
    })
    .catch(error => {
      this.showMessage(error == 'timeout' ? "接口超时" : "接口异常", "warning");
    });

  return res;
}

/**
 * @description 获取详情
 * 1.query 请求对象
 * 2.url 请求url
 * 3.请求方法method
 */
async function getDetail(query, url, method) {
  let res = {};
  let data = {};

  //筛选query去除空的内容
  for (var key in query) {
    if (query[key] !== "") {
      data[key] = query[key];
    }
  }
  //调用接口,获取返回内容
  await queryApi(data, url, method)
    .then(response => {
      res = response;
    })
    .catch(error => {
      this.showMessage(error == 'timeout' ? "接口超时" : "接口异常", "warning");
    });
  return res;
}

/**
 * @description 操作
 * 1.query 请求对象
 * 2.url 请求url
 * 3.请求方法method
 * 4.操作名字optionName
 * 5.成功的code  successCode
 * 6.消息的英文 msgKey
 */
async function doSth(query, url, method, successCode, msgKey) {
  let res = false;
  if (successCode == undefined) {
    successCode = 0;
  }
  if (msgKey == undefined) {
    msgKey = "msg";
  }
  await queryApi(query, url, method)
    .then(response => {
      if (response.code == successCode) {
        res = true;
        this.showMessage("操作成功", "success");
      } else {
        this.showMessage(
          response[msgKey] ? response[msgKey] : "操作失败",
          "warning"
        );
      }
    })
    .catch(error => {
      this.showMessage(error == 'timeout' ? "接口超时" : "接口异常", "warning");
    });
  return res;
}
/**
 * @description 导出
 * 1.url 请求url
 * 2.请求参数params
 * 3.文件名fileName
 * 4.请求方法method
 * 5.消息的英文 msgKey
 */
function download(url, params, fileName, method, msgKey) {
  let that = this;
  if (method == undefined) {
    method = "post";
  }
  if (msgKey == undefined) {
    msgKey = "msg";
  }
  let data = {
    method: method,
    url: url,
    responseType: "blob",
    headers: {
      token: sessionStorage.getItem("token") || ""
    }
  };
  if (method == "post") {
    data.data = params;
  } else {
    data.params = params;
  }
  axios(data)
    .then(response => {
      //判断是否参数异常
      let blob = new Blob([response.data]);
      if (response.data.type == "application/json") {
        //将 Blob对象 读成字符串
        var reader = new FileReader();
        reader.readAsText(blob, "utf-8");
        reader.onload = function (e) {
          let resJson =
            e.target && e.target.result ? JSON.parse(e.target.result) : "";
          if (resJson && resJson[msgKey]) {
            that.showMessage(resJson[msgKey], "warning");
          } else {
            that.showMessage("导出失败", "warning");
          }
        };
      } else {
        const url = window.URL.createObjectURL(blob);
        const link = document.createElement("a");
        link.href = url;
        link.setAttribute("download", fileName);
        document.body.appendChild(link);
        link.click();
      }
    })
    .catch(function (error) {
      that.showMessage("导出失败", "warning");
    });
}

function downloadUrl(url) {
  const link = document.createElement("a");
  link.href = url;
  document.body.appendChild(link);
  link.click();
}
/**
* @description 数组元素位置移动 luofu 20200605
*/
// 置顶
function zIndexTop(arr, index) {
  if (index != 0) {
    arr.unshift(arr.splice(index, 1)[0]);
  } else {
    this.showMessage('已经处于置顶', 'warning');
  }
}
// 置底
function zIndexBottom(arr, index) {
  if (index != arr.length - 1) {
    arr.push(arr[index]);
    arr.splice(index, 1);
  } else {
    this.showMessage('已经处于置底', 'warning');
  }
}
// 上移
function zIndexUp(arr, index) {
  if (index != 0) {
    arr[index] = arr.splice(index - 1, 1, arr[index])[0];
  } else {
    this.showMessage('已经处于置顶，无法上移', 'warning');
  }
}
// 下移
function zIndexDown(arr, index) {
  if (index != arr.length - 1) {
    arr[index] = arr.splice(index + 1, 1, arr[index])[0];
  } else {
    this.showMessage('已经处于置底，无法下移', 'warning');
  }
}
