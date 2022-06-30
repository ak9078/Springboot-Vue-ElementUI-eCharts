<template>
  <div class="dashboard-editor-container">
    <el-card class="box-card" :body-style="{ padding: '0px' }">
      <div slot="header" class="clearfix">
        <div class="fl">
          <span class="select-label">渠道选择</span>
          <el-select
            v-model="channelRangeValue"
            placeholder="请选择"
            @change="channelRangeChange($event)"
            multiple
            collapse-tags
          >
            <el-option
              value=""
              label="全部渠道"
              @click.native="dataRangeAll()"
            ></el-option>
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
    </el-card>

    <PanelGroup typeValue="online" />

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
        <el-tab-pane label="订单额" name="first" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">订单额趋势</div>
                <OnlineBarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">渠道排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="退款率" name="second" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">退款趋势</div>
                <OnlineBarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">退款排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="超时率" name="third" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">超时趋势</div>
                <OnlineBarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">超时排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="利润率" name="fourth" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">利润趋势</div>
                <OnlineBarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">利润排名</div>
                <RankingTable
                  :rankingLoading="rankingLoading"
                  :rankingTabList="rankingTabList"
                />
              </div>
            </el-col>
          </el-row>
        </el-tab-pane>
        <el-tab-pane label="渠道占比" name="fifth" :lazy="true">
          <el-row :gutter="32">
            <el-col :xs="24" :sm="24" :lg="16">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">渠道占比趋势</div>
                <OnlineBarChart :chartOptions="chartOptions" />
              </div>
            </el-col>
            <el-col :xs="24" :sm="24" :lg="8">
              <div class="chart-wrapper">
                <div class="chart-wrapper-title">渠道占比排名</div>
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
import {
  getByChannels,
  rankingData
} from "@/utils/tool/dataPlatform/statOrders";

import PanelGroup from "./components/PanelGroup";
import OnlineBarChart from "@/components/Common/BarChart";
import RankingTable from "@/components/Common/RankingTable";

export default {
  name: "OnlineDataAdmin",
  components: {
    PanelGroup,
    OnlineBarChart,
    RankingTable
  },
  data() {
    return {
      channelRangeOptions: [
        {
          value: "1",
          label: "译鱼"
        },
        {
          value: "2",
          label: "代客下单"
        },
        {
          value: "5",
          label: "百度"
        },
        {
          value: "6",
          label: "360"
        },
        {
          value: "7",
          label: "腾讯"
        },
        {
          value: "8",
          label: "公众号"
        }
      ], // 渠道选择选项
      channelRangeValue: [""], // 渠道选择值
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
          label: "文档订单（线上）"
        },
        {
          value: "4",
          label: "其他"
        }
      ], // 订单类型选项
      orderTypeRangeValue: "", // 订单类型值
      dateQuickValue: "", // 日期快捷选择值
      dateRangeValue: [], // 日期范围
      tabsActiveName: "first",
      rankingTabList: [], // 排名
      rankingLoading: false, // 排名loading
      chartOptions: {} // 饼图配置
    };
  },
  async mounted() {
    await this.dateQuickSelect("week");
  },
  methods: {
    // 点击全选
    async dataRangeAll() {
      let that = this;
      let options = that.channelRangeOptions;
      if (that.channelRangeValue.length < options.length) {
        // 全选上
        that.channelRangeValue = options.map(item => {
          if (item.value) {
            return item.value;
          }
        });
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
      } else {
        // 全取消
        that.channelRangeValue = [""];
      }
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
      that.channelRangeValue = $event.filter(value => {
        return value.length > 0;
      });
      console.log(that.channelRangeValue);
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
        case "fifth": {
          index = 5;
          break;
        }
      }

      let dateRangeValue = that.dateRangeValue || [];

      let startDate = dateRangeValue[0];
      let endDate = dateRangeValue[1];
      if (!startDate || !endDate) {
        that.$message("请选择日期区间");
        return false;
      }

      let _channelRangeValue = that.channelRangeValue;
      if (_channelRangeValue == "") {
        _channelRangeValue = ["1", "2", "5", "6", "7", "8"];
      }

      let params = {
        statType: index,
        startDate: startDate,
        endDate: endDate,
        channels: _channelRangeValue,
        orderType: that.orderTypeRangeValue
      };
      let response = await getByChannels(params);
      if (response.code == 0) {
        let responseData = response.data || [];
        let _xAxisData = responseData.xAxisData || [];
        let responseDataSeriesList = responseData.seriesList || [];
        let _seriesList = responseDataSeriesList.map(item => {
          return {
            name: item.channelName,
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
        case "fifth": {
          index = 5;
          break;
        }
      }

      that.rankingLoading = true;

      try {
        let dateRangeValue = that.dateRangeValue || [];

        let startDate = dateRangeValue[0];
        let endDate = dateRangeValue[1];
        if (!startDate || !endDate) {
          that.$message("请选择日期区间");
          return false;
        }

        let _channelRangeValue = that.channelRangeValue;
        if (_channelRangeValue == "") {
          _channelRangeValue = ["1", "2", "5", "6", "7", "8"];
        }

        let params = {
          statType: index,
          startDate: startDate,
          endDate: endDate,
          channels: _channelRangeValue,
          orderType: that.orderTypeRangeValue
        };
        let response = await rankingData(params);
        if (response.code == 0) {
          let responseData = response.data || [];
          that.rankingTabList = responseData.map(item => {
            return {
              statName: item.channelName,
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
        margin: 0 10px;

        &:nth-child(2n + 1) {
          color: #409eff;
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
