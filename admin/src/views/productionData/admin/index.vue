<template>
  <div class="dashboard-editor-container">
    <el-card
      class="box-card"
      :body-style="{ padding: dataRangeLableList.length > 0 ? '20px' : '0px' }"
    >
      <div slot="header" class="clearfix">
        <div class="fl">
          <span class="select-label">数据范围</span>
          <el-select
            v-model="dataRangeValueList"
            @change="dataRangeChange($event)"
            placeholder="请选择"
            multiple
            collapse-tags
            style="width: 220px;"
          >
            <el-option
              value=""
              label="全部数据"
              @click.native="dataRangeAll()"
            ></el-option>
            <el-option
              v-for="item in dataRangeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </div>

        <div class="fr">
          <span class="select-label">渠道选择</span>
          <el-select
            v-model="channelRangeValue"
            placeholder="请选择"
            @change="channelRangeChange($event)"
          >
            <el-option
              v-for="item in channelRangeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>

          <span class="select-label margin-left-10">订单类型</span>
          <el-select
            v-model="orderTypeRangeValue"
            placeholder="请选择"
            @change="orderTypeRangeChange($event)"
          >
            <el-option
              v-for="item in orderTypeRangeOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </div>
      </div>
      <section class="text-item" v-if="dataRangeLableList">
        <div v-loading="dataRangeLableListLoading">
          <div
            v-for="(labelItem, labelIndex) in dataRangeLableList"
            :key="labelIndex"
          >
            {{ labelItem.label }}：
            <span
              v-for="(item, index) in labelItem.memberList"
              :key="index"
              @click="clickMember(item)"
              :class="item.isChecked === true ? '' : 'cancel'"
            >
              {{ item.accountCode }}
            </span>
            <el-divider
              v-if="labelIndex != dataRangeLableList.length - 1"
            ></el-divider>
          </div>
        </div>
      </section>
    </el-card>

    <PanelGroup />

    <el-card class="box-card chart-main">
      <div class="right-area">
        <el-button
          type="text"
          :class="dateQuickValue == 'week' ? 'checked' : ''"
          @click="dateQuickSelect('week')"
          >本周</el-button
        >
        <el-button
          type="text"
          :class="dateQuickValue == 'month' ? 'checked' : ''"
          @click="dateQuickSelect('month')"
          >本月</el-button
        >
        <el-button
          type="text"
          class="last-child"
          :class="dateQuickValue == 'year' ? 'checked' : ''"
          @click="dateQuickSelect('year')"
          >全年</el-button
        >

        <el-date-picker
          v-model="dateRangeValue"
          type="daterange"
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          format="yyyy-MM-dd"
          value-format="yyyy-MM-dd"
          @change="dateRangeChange($event)"
        >
        </el-date-picker>
      </div>
      <el-tabs v-model="tabsActiveName" @tab-click="handleClick">
        <el-tab-pane label="利润率" name="first" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">利润率趋势</div>
                <BarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">利润率排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="超时时长" name="second" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">超时时长趋势</div>
                <BarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">超时时长排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="返稿量" name="third" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">返稿量趋势</div>
                <BarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">返稿量排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="交付字数" name="fourth" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">交付字数趋势</div>
                <BarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">交付字数趋势</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { getAllTeam, getTeamMember } from "@/utils/tool/base/organization";
import {
  getProducesData,
  rankingData
} from "@/utils/tool/dataPlatform/statProduces";

import PanelGroup from "./components/PanelGroup";
import BarChart from "@/components/Common/BarChart";
import RankingTable from "@/components/Common/RankingTable";

export default {
  name: "DashboardAdmin",
  components: {
    PanelGroup,
    BarChart,
    RankingTable
  },
  data() {
    return {
      dataRangeOptions: [], // 数据范围选项
      dataRangeValueList: [], // 数据范围值
      channelRangeOptions: [
        {
          value: "",
          label: "全部渠道"
        },
        {
          value: "1,2,5,6,7,8",
          label: "线上"
        },
        {
          value: "1,2,3,4",
          label: "线下"
        }
      ], // 渠道选择选项
      channelRangeValue: "", // 渠道选择值
      orderTypeRangeOptions: [
        {
          value: "",
          label: "全部类型"
        },
        {
          value: "1",
          label: "快速翻译（线上）"
        },
        {
          value: "2",
          label: "文档订单（线上、线下）"
        },
        {
          value: "3",
          label: "口译服务（线下）"
        },
        {
          value: "4",
          label: "其他"
        }
      ], // 订单类型选项
      orderTypeRangeValue: "", // 订单类型值
      dataRangeLableList: [], // 数据范围值对应的 label
      dataRangeLableListLoading: false,
      dateQuickValue: "", // 日期快捷选择值
      dateRangeValue: [], // 日期范围
      tabsActiveName: "first",
      rankingTabList: [], // 排名
      rankingLoading: false, // 排名loading
      chartOptions: {} // 饼图配置
    };
  },
  async mounted() {
    let that = this;

    // 获取所有 项目 团队
    let params = {
      code: "XM"
    };
    let response = await getAllTeam(params);
    if (response.code == 0) {
      let responseData = response.data || [];
      that.dataRangeOptions = responseData.map(item => {
        return {
          label: item.name,
          value: item.id
        };
      });
    } else {
      that.$message(response.message ? response.message : "团队数据获取失败");
    }
  },
  methods: {
    // 获取组员
    async getTeamMemberList(item) {
      let that = this;
      let result = [];
      let responseMember = await getTeamMember({
        orgId: item.value
      });
      if (responseMember.code == 0) {
        result = responseMember.data || [];
        // 默认选中
        result.map(item2 => {
          item2.isChecked = true;
        });
        if (that.dataRangeLableList.findIndex(n => n.label == item.label) < 0) {
          that.dataRangeLableList.push({
            label: item.label,
            memberList: result
          });
        }
      } else {
        that.$message(
          responseMember.message
            ? responseMember.message
            : "团队成员数据获取失败"
        );
      }
      return result;
    },
    // 数据范围切换
    async dataRangeChange($event) {
      //console.log($event, this.dataRangeValueList);
      let that = this;
      let isCheckAll = 0;
      if ($event.includes("") && $event.length == 1) {
        console.log("全选");
        isCheckAll = 1;
      } else {
        console.log("选择了其他项");
        isCheckAll = 0;
        that.dataRangeValueList = that.dataRangeValueList.filter(item => {
          return item;
        });
      }

      that.dataRangeLableListLoading = true;
      // 先清空
      that.dataRangeLableList = [];
      // 再循环获取
      if (isCheckAll == 0) {
        // 部分循环
        for (let i = 0; i < that.dataRangeOptions.length; i++) {
          let item = that.dataRangeOptions[i];
          for (let j = 0; j < $event.length; j++) {
            if (item.value == $event[j]) {
              await that.getTeamMemberList(item);
              break;
            }
          }
        }
        if (that.dateRangeValue) {
          // 获取饼图
          await that.getBarChartData();
          // 获取排名
          await that.getRankingData();
        } else {
          console.log("默认获取“本周”的数据");
          // 默认获取“本周”的数据
          that.dateQuickValue = that.dateQuickValue
            ? that.dateQuickValue
            : "week";
          that.dateQuickSelect(that.dateQuickValue);
        }
      }

      that.$nextTick(() => {
        that.dataRangeLableListLoading = false;
      });
    },
    // 点击全选
    async dataRangeAll() {
      let that = this;
      // 全取消
      that.dataRangeValueList = [""];
      if (that.dateRangeValue) {
        // 获取饼图
        await that.getBarChartData();
        // 获取排名
        await that.getRankingData();
      } else {
        console.log("默认获取“本周”的数据");
        // 默认获取“本周”的数据
        that.dateQuickValue = that.dateQuickValue
          ? that.dateQuickValue
          : "week";
        that.dateQuickSelect(that.dateQuickValue);
      }
    },
    // 成员选择
    async clickMember(item) {
      let that = this;
      item.isChecked = !item.isChecked;
      console.log(120, "成员选择");
      // 获取饼图
      await that.getBarChartData();
      // 获取排名
      await that.getRankingData();
    },
    // 周期选择
    async dateQuickSelect(timeString) {
      let that = this;
      that.dateQuickValue = timeString;
      const start = new Date();
      const end = new Date();
      switch (timeString) {
        case "week": {
          let weekday = start.getDay() || 7; // 获取星期几,getDay()返回值是 0（周日） 到 6（周六） 之间的一个整数。0||7为7，即weekday的值为1-7
          start.setDate(start.getDate() - weekday + 1); // 往前算（weekday-1）天，年份、月份会自动变化
          break;
        }
        case "month": {
          start.setDate(1);
          break;
        }
        case "year": {
          start.setDate(1);
          start.setMonth(0);
          break;
        }
      }
      let startDateFmt = that.dateFormat(start, "yyyy-MM-dd");
      let endDateFmt = that.dateFormat(end, "yyyy-MM-dd");
      that.dateRangeValue = [startDateFmt, endDateFmt];
      console.log(130, "周期选择");
      // 获取饼图
      await that.getBarChartData();
      // 获取排名
      await that.getRankingData();
    },
    // 渠道选择
    async channelRangeChange($event) {
      let that = this;
      console.log(160, "渠道选择");
      // 获取饼图
      await that.getBarChartData();
      // 获取排名
      await that.getRankingData();
    },
    // 订单类型
    async orderTypeRangeChange($event) {
      let that = this;
      console.log(170, "渠道选择");
      // 获取饼图
      await that.getBarChartData();
      // 获取排名
      await that.getRankingData();
    },
    // 数据范围切换
    async dateRangeChange(val) {
      let that = this;
      that.dateQuickValue = "";
      that.dateRangeValue = val;
      console.log(140, "数据范围切换");
      // 获取饼图
      await that.getBarChartData();
      // 获取排名
      await that.getRankingData();
    },
    // tab选项
    async handleClick(tab, event) {
      let that = this;
      console.log(150, "tab选项");
      // 获取饼图
      await that.getBarChartData();
      // 获取排名
      await that.getRankingData();
    },
    // 获取饼图数据
    async getBarChartData() {
      let that = this;
      // 先置空
      that.chartOptions = {};

      let index = 0;
      switch (that.tabsActiveName) {
        case "first": {
          index = 1;
          break;
        }
        case "second": {
          index = 2;
          break;
        }
        case "third": {
          index = 3;
          break;
        }
        case "fourth": {
          index = 4;
          break;
        }
      }

      let dateRangeValue = that.dateRangeValue || [];
      // 获取选中的成员
      let checkedMemberList = that.getCheckedMemberList();

      let startDate = dateRangeValue[0];
      let endDate = dateRangeValue[1];
      if (!startDate || !endDate) {
        that.$message("请选择日期区间");
        return false;
      }

      let params = {
        statType: index,
        startDate: startDate,
        endDate: endDate,
        sysAccountIds: checkedMemberList,
        channel: that.channelRangeValue,
        orderType: that.orderTypeRangeValue
      };
      let response = await getProducesData(params);
      if (response.code == 0) {
        let responseData = response.data || [];
        let _xAxisData = responseData.xAxisData || [];
        let responseDataSeriesList = responseData.seriesList || [];
        let _seriesList = responseDataSeriesList.map(item => {
          return {
            name: item.accountCode,
            type: "bar",
            stack: "vistors",
            barWidth: "60%",
            data: item.seriesData,
            animationDuration: 3000
          };
        });
        that.chartOptions = {
          xAxisData: _xAxisData,
          seriesList: _seriesList
        };
      } else {
        that.$message(response.message ? response.message : "饼图数据获取失败");
      }
    },
    // 获取排名数据
    async getRankingData() {
      let that = this;
      // 先置空
      that.rankingTabList = [];

      let index = 0;
      switch (that.tabsActiveName) {
        case "first": {
          index = 1;
          break;
        }
        case "second": {
          index = 2;
          break;
        }
        case "third": {
          index = 3;
          break;
        }
        case "fourth": {
          index = 4;
          break;
        }
      }

      that.rankingLoading = true;

      try {
        let dateRangeValue = that.dateRangeValue || [];
        // 获取选中的成员
        let checkedMemberList = that.getCheckedMemberList();

        let startDate = dateRangeValue[0];
        let endDate = dateRangeValue[1];
        if (!startDate || !endDate) {
          that.$message("请选择日期区间");
          return false;
        }

        let params = {
          statType: index,
          startDate: startDate,
          endDate: endDate,
          sysAccountIds: checkedMemberList,
          channel: that.channelRangeValue,
          orderType: that.orderTypeRangeValue
        };
        let response = await rankingData(params);
        if (response.code == 0) {
          let responseData = response.data || [];
          that.rankingTabList = responseData.map(item => {
            return {
              statName: item.accountCode,
              statValue: item.statResult
            };
          });
        } else {
          that.$message(
            response.message ? response.message : "排名数据获取失败"
          );
        }
      } finally {
        that.rankingLoading = false;
      }
    },
    // 获取选中的成员
    getCheckedMemberList() {
      let that = this;
      // 先取消所有
      let checkedMemberList = [];
      for (var i = 0; i < that.dataRangeLableList.length; i++) {
        let item1 = that.dataRangeLableList[i];
        for (var j = 0; j < item1.memberList.length; j++) {
          let item2 = item1.memberList[j];
          if (item2.isChecked) {
            checkedMemberList.push(item2.userId);
          }
        }
      }
      return checkedMemberList;
    }
  }
};
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  padding: 32px;
  background-color: rgb(240, 242, 245);
  position: relative;

  .margin-left-10 {
    margin-left: 10px;
  }

  .box-card {
    position: relative;

    .select-label {
      color: #999;
    }
    .el-select {
      margin-left: 10px;
    }
    .text-item {
      span {
        font-size: 14px;
        margin-right: 10px;
        color: #409eff;
        cursor: pointer;

        &.cancel {
          color: #909399;
        }
      }
    }
    .right-area {
      position: absolute;
      right: 20px;
      top: 12px;
      z-index: 8;

      .el-button {
        margin: 0 10px;
        color: #909399;

        &.checked {
          color: #409eff;
        }
        &.last-child {
          margin-right: 30px;
        }
      }
    }
  }

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;

    & .chart-wrapper-title {
      font-size: 14px;
      font-weight: bold;
      padding-bottom: 18px;
    }
  }
}

@media (max-width: 1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}
</style>
