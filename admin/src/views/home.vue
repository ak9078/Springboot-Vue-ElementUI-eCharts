<template>
  <div class="dashboard-container">
    <h1 style="text-align: center;">某某数据平台</h1>
  </div>
</template>

<script>
import platformAccount from "@/utils/tool/dataPlatform/platformAccount";

export default {
  name: "Home",
  async mounted() {
    let that = this;
    let accountId = that.$route.query.accountId;
    let accountMd5 = that.$route.query.accountMd5;
    if (accountId && accountMd5) {
      let response = await platformAccount.getPlatformAccountInfo(
        accountId,
        accountMd5
      );
      console.log(response);
      if (response) {
        that.$router.push("/salesData/salesDashboard");
      }
    }
  },
  watch: {
    "$route.query.accountMd5"(newVal, oldVal) {
      // 带accountMd5参数 重新加载
      this.$router.go(0);
    }
  }
};
</script>
