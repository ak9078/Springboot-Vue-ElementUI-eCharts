<template>
  <div class="dashboard-editor-container">
    <el-card class="box-card chart-main">
      <span>请选择要统计的日期区间</span>
      <el-date-picker
        v-model="dateRangeValue"
        type="daterange"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        format="yyyy-MM-dd"
        value-format="yyyy-MM-dd"
        class="date-picker"
      >
      </el-date-picker>
      <el-button type="danger" @click="timeSlot(0)" :loading="buttonLoading"
        >开始统计所有数据</el-button
      >
      <el-button type="primary" @click="timeSlot(1)" :loading="buttonLoading"
        >开始统计生产数据</el-button
      >
      <el-button type="warning" @click="timeSlot(2)" :loading="buttonLoading"
        >开始统计订单数据</el-button
      >
      <p class="tips">
        提示：选择的日期跨度大有可能完成不了统计，这个与服务器及数据库配置有关，如果没有完成统计，请尝试缩小跨度，谢谢！
      </p>
    </el-card>
  </div>
</template>

<script>
import defaultTool from "@/utils/tool/default";

export default {
  name: "Manual",
  data() {
    return {
      dateRangeValue: [], // 日期范围
      buttonLoading: false
    };
  },
  methods: {
    /**
     * @description 统计数据
     * 0: 所有数据
     * 1: 只统计生产数据
     * 2: 只统计订单数据
     */
    async timeSlot(typeVal = 0) {
      let that = this;

      that.buttonLoading = true;

      try {
        let dateRangeValue = that.dateRangeValue || [];
        let startDate = dateRangeValue[0];
        let endDate = dateRangeValue[1];
        if (!startDate || !endDate) {
          that.$message("请选择日期区间");
          return false;
        }

        let params = {
          startDate: startDate,
          endDate: endDate
        };
        let url = "/api/analyze/timeSlot";
        if (typeVal != 0) {
          url = "/api/analyze/timeSlot_" + typeVal;
        }
        let response = await defaultTool.getDetail(params, url, "get");
        let responseMessage = "";
        if (response.code == 0) {
          responseMessage = "您所选择日期区间已完成统计";
        } else {
          responseMessage = response.message ? response.message : "统计失败";
        }
        that.$message(responseMessage);
      } finally {
        that.buttonLoading = false;
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);

  .box-card {
    .date-picker {
      margin: 0 10px;
    }
    .tips {
      font-size: 12px;
    }
  }
}
</style>
