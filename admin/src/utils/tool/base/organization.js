import defaultTool from "@/utils/tool/default";
import Vue from "vue";
let v = new Vue();

export {
  // 获取所有团队
  getAllTeam,
  // 根据团队ID获取成员
  getTeamMember
};

// 获取所有团队
async function getAllTeam(params) {
  let url = "/api/sysOrganization/allTeam";
  return await defaultTool.getDetail(params, url, "post");
}
// 根据团队ID获取成员
async function getTeamMember(params){
  let url = "/api/sysOrganizationMember/findByOrgId";
  return await defaultTool.getDetail(params, url, "post");
}
