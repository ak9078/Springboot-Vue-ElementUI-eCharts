<template>
  <div class="aside-wrapper">
    <div class="sidebar-top">
      <img src="@/assets/img/logo01.png" alt="logo" width="170" />
    </div>
    <div class="aside">
      <el-menu
        class="el-menu-vertical"
        :default-active="defaultActive"
        :unique-opened="true"
        :collapse="isCollapse"
        :background-color="variables.menuBg"
        :text-color="variables.menuText"
        :active-text-color="variables.menuActiveText"
        router
        :collapse-transition="false"
        mode="vertical"
      >
        <template v-for="item in items">
          <template v-if="item.subs">
            <el-submenu :index="item.index" :key="item.index">
              <template slot="title">
                <i :class="item.icon" v-show="iconFlag"></i>
                <span slot="title">{{ item.title }}</span>
              </template>
              <template>
                <template v-for="(subItem, index) in item.subs">
                  <el-submenu
                    v-if="subItem.subs"
                    :index="subItem.title"
                    :key="index"
                  >
                    <template slot="title">
                      <i :class="subItem.icon"></i>
                      <span slot="title">{{ subItem.title }}</span>
                    </template>
                    <!--三级菜单-->
                    <el-menu-item
                      v-for="(threeItem, i) in subItem.subs"
                      :key="i"
                      :index="threeItem.index"
                      >{{ threeItem.title }}</el-menu-item
                    >
                  </el-submenu>
                  <el-menu-item
                    v-else
                    :index="subItem.index"
                    :key="subItem.index"
                  >
                    <i class="iconfont icon-tuoyuanxing"></i>
                    {{ subItem.title }}
                  </el-menu-item>
                </template>
              </template>
            </el-submenu>
          </template>
          <template v-else>
            <el-menu-item :index="item.index" :key="item.index">
              <i :class="item.icon"></i>
              <span slot="title">{{ item.title }}</span>
            </el-menu-item>
          </template>
        </template>
      </el-menu>
    </div>
  </div>
</template>
<script>
import platformAccountTool from "@/utils/tool/dataPlatform/platformAccount";
import variables from "@/styles/variables.scss";
import { getToken } from "@/utils/auth";

export default {
  name: "Sidebar",
  components: {},
  props: {
    isCollapse: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      iconFlag: true,
      user: {
        userAvatar: "",
        roleName: "",
        accountCode: ""
      }
    };
  },
  mounted() {
    // 从缓存中获取用户的登录信息
    let platformAccountInfo = JSON.parse(getToken("platformAccountInfo")) || {};
    let platformAccountInfoRoleList = platformAccountInfo.roleList || [{}];
  },
  computed: {
    defaultActive: function() {
      return this.$route.path && this.$route.path != "/"
        ? this.$route.path
        : "/dashboard";
    },
    items: function() {
      return platformAccountTool.getMenuJson();
    },
    variables() {
      return variables;
    }
  },
  methods: {
    
  }
};
</script>
<style scoped lang="scss">
@import "@/styles/variables.scss";

.aside-wrapper {
  height: 100%;

  .sidebar-top {
    height: 73px;
    background: #fff;
    overflow: hidden;
    text-align: center;
    padding-top: 15px;
  }

  .aside {
    height: calc(100vh - 73px);
    overflow-x: auto;
    color: #fff;
  }
}
</style>
