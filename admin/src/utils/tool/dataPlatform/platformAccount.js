import defaultTool from "@/utils/tool/default";
import { getToken, setToken } from "@/utils/auth";
import { Notification } from "element-ui";
import md5 from "js-md5";

export default {
  // 获取管理员信息
  async getPlatformAccountInfo(accountId, accountMd5) {
    let query = {
      accountId: accountId,
      accountMd5: accountMd5
    };

    let response =
      (await defaultTool.queryApi(
        query,
        "/api/platformAccount/bridging",
        "get"
      )) || {};
    if (response.code == 0) {
      let responseData = response.data || {};
      setToken("token", responseData.accountCode);
      setToken("platformAccountInfo", JSON.stringify(responseData)); // 添加到sessionStorage
      return 1;
    } else {
      Notification.warning({
        message: response.msg ? response.msg : "鉴权失败"
      });
      return 0;
    }
  },
  // 获取菜单
  getMenuJson() {
    let menuJson = [
      {
        // icon: "el-icon-star-on",
        index: "/",
        title: "首页"
      }
    ];
    // 菜单先写死
    // menuJson = [
    //   {
    //     index: "1",
    //     icon: "el-icon-odometer",
    //     title: "销售数据",
    //     subs: [
    //       {
    //         index: "/salesData/salesDashboard",
    //         title: "销售仪表盘"
    //       }
    //     ]
    //   },
    //   {
    //     index: "2",
    //     icon: "el-icon-edit-outline",
    //     title: "生产数据",
    //     subs: [
    //       {
    //         index: "/productionData/productionDashboard",
    //         title: "生产仪表盘"
    //       }
    //     ]
    //   },
    //   {
    //     index: "3",
    //     icon: "el-icon-s-grid",
    //     title: "订单数据",
    //     subs: [
    //       {
    //         index: "/ordersData/onlineData",
    //         title: "线上数据"
    //       },
    //       {
    //         index: "/ordersData/offlineData",
    //         title: "线下数据"
    //       }
    //     ]
    //   }
    // ];

    let platformAccountInfo = JSON.parse(getToken("platformAccountInfo")) || {}; // 从sessionStorage中读取状态
    let platformAccountInfoRoleMenuList = platformAccountInfo.roleMenuList || {};
    if (platformAccountInfo && platformAccountInfoRoleMenuList.length > 0) {
      platformAccountInfoRoleMenuList.forEach(item => {
        let itemJson = {};
        itemJson = {
          index: item.menuCode,
          title: item.menuName,
          subs: []
        };
        item.children.forEach(child => {
          let childJson = {
            index: child.menuUrl == "" ? item.menuCode : child.menuUrl,
            title: child.menuName
          };
          // 判断是否有children
          if (child.children && child.children.length > 0) {
            childJson.subs = [];
            child.children.forEach(child2 => {
              childJson.subs.push({
                index: child2.menuUrl == "" ? item.menuCode : child2.menuUrl,
                title: child2.menuName
              });
            });
          }
          itemJson.subs.push(childJson);
        });
        menuJson.push(itemJson);
      });
    }
    return menuJson;
  }
};
