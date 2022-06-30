import defaultTool from "@/utils/tool/default";
import Vue from "vue";
let v = new Vue();

export {
  // 获取年度数据
  getByYear,
  // 超期未回款额度
  overdue,
  // 获取饼图数据
  getBySysAccountIds,
  // 获取排名数据
  rankingData
};

// 获取年度数据
async function getByYear(params) {
  let url = "/api/statSales/getByYear";
  return await defaultTool.getDetail(params, url, "post");
}
// 超期未回款额度
async function overdue(params){
  let url = "/api/statSales/overdue";
  return await defaultTool.getDetail(params, url, "post");
}
// 获取饼图数据
async function getBySysAccountIds(params){
  let url = "/api/statSales/getBySysAccountIds";
  return await defaultTool.getDetail(params, url, "post");
}
// 获取排名数据
async function rankingData(params){
  let url = "/api/statSales/rankingData";
  return await defaultTool.getDetail(params, url, "post");
}
