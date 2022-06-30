<template>
  <div
    id="barChart"
    :class="className"
    :style="{ height: height, width: width }"
    :chartOptions="chartOptions"
  />
</template>

<script>
import echarts from "echarts";
require("echarts/theme/macarons"); // echarts theme
import resize from "./mixins/resize";

export default {
  mixins: [resize],
  props: {
    className: {
      type: String,
      default: "chart"
    },
    width: {
      type: String,
      default: "100%"
    },
    height: {
      type: String,
      default: "300px"
    },
    chartOptions: {
      type: Object,
      default: {}
    }
  },
  data() {
    return {
      chart: null
    };
  },
  mounted() {
    this.$nextTick(() => {
      this.initChart();
      this.setOptions();
    });
  },
  watch: {
    chartOptions: function(newValue) {
      this.chart && this.chart.dispose();
      this.chart = null;
      this.initChart();
      this.chartOptions = newValue;
      this.chart.showLoading({
        text: "数据正在努力加载...",
        textStyle: { fontSize: 30, color: "#444" },
        effectOption: { backgroundColor: "rgba(0, 0, 0, 0)" }
      });

      let that = this;
      that.$nextTick(() => {
        setTimeout(() => {
          that.setOptions();
        }, 2000);
      });
    }
  },
  beforeDestroy() {
    if (!this.chart) {
      return;
    }
    this.chart.dispose();
    this.chart = null;
  },
  methods: {
    initChart() {
      this.chart = echarts.init(this.$el, "macarons");
    },
    setOptions() {
      let _seriesList = this.chartOptions.seriesList || [];
      if (_seriesList.length > 0) {
        this.chart.setOption({
          tooltip: {
            trigger: "axis",
            axisPointer: {
              // 坐标轴指示器，坐标轴触发有效
              type: "shadow" // 默认为直线，可选为：'line' | 'shadow'
            },
            formatter: function(params) {
              let isShow = false;

              let relVal = params[0].name;
              let value = 0;
              for (let i = 0, l = params.length; i < l; i++) {
                value += parseFloat(params[i].value);
              }

              for (let i = 0, l = params.length; i < l; i++) {
                let _value = params[i].value;
                let _data = params[i].data;

                if (_data != 0) {
                  relVal += "<br/>";
                  relVal += params[i].seriesName + ": " + _data + " ";
                  // 验证除数是否为0
                  //if (parseInt(value) != 0) {
                  //console.log(103, _value, value);
                  relVal +=
                    ((100 * parseFloat(_value)) / parseFloat(value)).toFixed(
                      2
                    ) + "%";
                  //}
                }

                if (_value != 0) {
                  isShow = true;
                }
              }

              if (isShow) {
                return relVal;
              }
            },
            // https://echarts.apache.org/zh/option.html#tooltip.confine
            position: function(p) {
              //其中p为当前鼠标的位置
              return [p[0] + 10, p[1] - 10];
            },
            enterable: true,
            extraCssText: "height: 200px; overflow: auto;",
            confine: true
          },
          grid: {
            top: 10,
            left: "2%",
            right: "2%",
            bottom: "3%",
            containLabel: true
          },
          xAxis: [
            {
              type: "category",
              data: this.chartOptions.xAxisData,
              axisTick: {
                alignWithLabel: true
              }
            }
          ],
          yAxis: [
            {
              type: "value",
              axisTick: {
                show: false
              }
            }
          ],
          series: this.chartOptions.seriesList
        });
      } else {
        this.chart.setOption({
          title: {
            text: "暂无数据",
            x: "center",
            y: "center",
            textStyle: {
              color: "#f56c6c",
              fontWeight: "normal",
              fontSize: 12
            }
          }
        });
      }
      this.chart.hideLoading();
    }
  }
};
</script>
