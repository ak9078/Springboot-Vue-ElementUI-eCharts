<template>
  <div class="navbar">
    <hamburger
      id="hamburger-container"
      :is-active="sidebar.opened"
      class="hamburger-container"
      @toggleClick="toggleSideBar"
    />

    <breadcrumb id="breadcrumb-container" class="breadcrumb-container" />

    <div class="right-menu">
      <template v-if="device !== 'mobile'">
        <error-log class="errLog-container right-menu-item hover-effect" />

        <span class="right-menu-item">{{ accountCode }}</span>
        <span class="right-menu-item margin-right-25">
          <el-tag key="roleName" type="" effect="dark">
            {{ roleName }}
          </el-tag>
        </span>
      </template>
    </div>

    <el-dialog
      title="温馨提示"
      :visible.sync="dialogVisible"
      width="50%"
      :append-to-body="true"
      :close-on-click-modal="false"
      :show-close="false"
    >
      <span>您还没有登录</span>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="go2Login()">去登录</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
import Breadcrumb from "@/components/Breadcrumb";
import Hamburger from "@/components/Hamburger";
import ErrorLog from "@/components/ErrorLog";
import { getToken, removeToken } from "@/utils/auth";
import md5 from "js-md5";

export default {
  components: {
    Breadcrumb,
    Hamburger,
    ErrorLog
  },
  data() {
    return {
      accountCode: "",
      roleName: "",
      dialogVisible: false
    };
  },
  computed: {
    ...mapGetters(["sidebar", "avatar", "device"])
  },
  created() {
    let that = this;
    let platformAccountInfo = JSON.parse(getToken("platformAccountInfo")) || {};
    let platformAccountInfoRoleList = platformAccountInfo.roleList || [{}];
    if (!platformAccountInfo.accountCode) {
      // 未登录
      that.dialogVisible = true;
    } else {
      that.accountCode = platformAccountInfo.accountCode || "";
      that.roleName = platformAccountInfoRoleList[0].roleName || "";
    }
  },
  methods: {
    toggleSideBar() {
      this.$store.dispatch("app/toggleSideBar");
    },
    // 去登录
    go2Login() {
      this.dialogVisible = false;
      location.href = "http://www.xxx.com";
    }
  }
};
</script>

<style lang="scss" scoped>
.navbar {
  height: 73px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);

  .hamburger-container {
    line-height: 73px;
    height: 100%;
    float: left;
    cursor: pointer;
    transition: background 0.3s;
    -webkit-tap-highlight-color: transparent;
    color: #666;
    fill: #666;

    &:hover {
      background: rgba(0, 0, 0, 0.025);
    }
  }

  .breadcrumb-container {
    float: left;
  }

  .errLog-container {
    display: inline-block;
    vertical-align: top;
  }

  .right-menu {
    float: right;
    height: 100%;
    line-height: 73px;

    &:focus {
      outline: none;
    }

    .right-menu-item {
      display: inline-block;
      padding: 0 8px;
      height: 100%;
      font-size: 18px;
      color: #333;
      vertical-align: text-bottom;

      &.margin-right-5 {
        margin-right: 5px;
      }
      &.margin-right-25 {
        margin-right: 25px;
      }
      & .icon {
        display: inline-block;
        background: url("../../assets/img/tuichu.png") no-repeat;
        width: 16px;
        height: 26px;
        position: relative;
        top: 12px;
        background-size: 16px auto;
      }
      &.hover-effect {
        cursor: pointer;
        transition: background 0.3s;

        &:hover {
          background: rgba(0, 0, 0, 0.025);
        }
      }
    }

    .avatar-container {
      margin-right: 30px;

      .avatar-wrapper {
        margin-top: 5px;
        position: relative;

        .user-avatar {
          cursor: pointer;
          width: 40px;
          height: 40px;
          border-radius: 10px;
        }

        .el-icon-caret-bottom {
          cursor: pointer;
          position: absolute;
          right: -20px;
          top: 25px;
          font-size: 12px;
        }
      }
    }
  }
}
</style>
