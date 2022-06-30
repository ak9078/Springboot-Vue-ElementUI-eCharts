<template>
  <el-row :gutter="20" class="panel-group">
    <el-col :xs="24" :sm="24" :lg="6" class="card-panel-col">
      <div class="card-panel bg-1">
        <div class="card-panel-description">
          <div class="card-panel-text">年下单额</div>
          <count-to
            :start-val="0"
            :end-val="yearData.orderAmount"
            :duration="2600"
            class="card-panel-num"
          />
          <div class="card-panel-remark">
            月均销售额 ¥ {{ yearData.averageMonthlySales | toThousandFilter }}
          </div>
        </div>
      </div>
    </el-col>
    <el-col :xs="24" :sm="24" :lg="6" class="card-panel-col">
      <div class="card-panel bg-2">
        <div class="card-panel-description">
          <div class="card-panel-text">年应收额</div>
          <count-to
            :start-val="0"
            :end-val="yearData.receivableAmount"
            :duration="3000"
            class="card-panel-num"
          />
          <div class="card-panel-remark">
            月均应收额 ¥
            {{ yearData.averageMonthlyReceivable | toThousandFilter }}
          </div>
        </div>
      </div>
    </el-col>
    <el-col :xs="24" :sm="24" :lg="6" class="card-panel-col">
      <div class="card-panel bg-3">
        <div class="card-panel-description">
          <div class="card-panel-text">年回款额</div>
          <count-to
            :start-val="0"
            :end-val="yearData.refundAmount"
            :duration="3200"
            class="card-panel-num"
          />
          <div class="card-panel-remark">
            月均回款额 ¥ {{ yearData.averageMonthlyRefund | toThousandFilter }}
          </div>
        </div>
      </div>
    </el-col>
    <el-col :xs="24" :sm="24" :lg="6" class="card-panel-col">
      <div class="card-panel bg-4">
        <div class="card-panel-description">
          <div class="card-panel-text">超期未回款额度</div>
          <count-to
            :start-val="0"
            :end-val="overdueData"
            :duration="3200"
            class="card-panel-num"
          />
          <div class="card-panel-remark">
            <el-select
              v-model="dataRangeValue"
              placeholder="超期阈值：预计回款时间"
              @change="dataRangeChange"
            >
              <el-option
                v-for="item in dataRangeOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
              >
              </el-option>
            </el-select>
          </div>
        </div>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import CountTo from "vue-count-to";
import { getByYear, overdue } from "@/utils/tool/dataPlatform/statSales";
import { param } from "@/utils";

export default {
  components: {
    CountTo
  },
  data() {
    return {
      dataRangeOptions: [
        {
          value: "30",
          label: "超期阈值：30日"
        },
        {
          value: "90",
          label: "超期阈值：90日"
        },
        {
          value: "180",
          label: "超期阈值：180日"
        },
        {
          value: "10",
          label: "预计回款日"
        },
        {
          value: "40",
          label: "预计回款日+30日"
        }
      ], // 数据范围选项
      dataRangeValue: "30", // 数据范围，默认获取30天的
      yearData: {}, // 年度数据
      overdueData: 0 // 超期未回款额度
    };
  },
  mounted() {
    this.getByYearData(); // 获取年度有关的数据
    this.getOverdueData(); // 获取超期未回款额度
  },
  methods: {
    // 获取年度有关的数据
    async getByYearData() {
      let that = this;
      let params = {};
      let response = await getByYear(params);
      if (response.code == 0) {
        that.yearData = response.data || {};
      } else {
        that.$message(
          response.message ? response.message : "年度有关数据获取失败"
        );
      }
    },
    dataRangeChange($event) {
      this.dataRangeValue = $event;
      this.getOverdueData();
    },
    // 获取超期未回款额度
    async getOverdueData() {
      let that = this;
      let params = {
        days: that.dataRangeValue
      };
      let response = await overdue(params);
      if (response.code == 0) {
        that.overdueData = response.data || 0;
      } else {
        that.$message(
          response.message ? response.message : "超期未回款额度有关数据获取失败"
        );
      }
    }
  }
};
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 18px;

  .card-panel-col {
    margin-bottom: 32px;
  }

  .card-panel {
    height: 174px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    background: #fff;
    color: #000;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, 0.05);
    border-color: rgba(0, 0, 0, 0.05);
    padding-left: 20px;

    &:hover {
      .card-panel-icon-wrapper {
      }
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }

    .card-panel-icon {
      float: left;
      font-size: 48px;
    }

    .card-panel-description {
      float: left;
      font-weight: bold;
      margin: 36px 26px 36px 6px;

      .card-panel-text {
        line-height: 18px;
        font-size: 16px;
        margin-bottom: 12px;
        color: #999;
      }

      .card-panel-num {
        font-size: 36px;
      }

      .card-panel-remark {
        margin-top: 12px;
        font-size: 14px;
        margin-bottom: 12px;
      }
    }
  }
}

@media (max-width: 550px) {
  .card-panel-description {
    /*display: none;*/
  }

  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
      float: none !important;
    }
  }
}
</style>
