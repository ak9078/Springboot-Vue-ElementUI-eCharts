<template>
  <ul class="chart-wrapper-list" v-loading="rankingLoading">
    <li class="no-data" v-if="rankingTabList.length == 0">
      暂无数据
    </li>
    <li class="list-li" v-for="(item, index) in rankingTabList" :key="index">
      <i class="no">{{ index + 1 }}</i>
      {{ item.statName }}
      <span>{{ item.statValue | toThousandFilter }}</span>
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    rankingLoading: {
      type: Boolean,
      default: false
    },
    rankingTabList: {
      type: Array,
      default: []
    }
  },
  data() {
    return {
      chart: null
    };
  },
  mounted() {},
  methods: {}
};
</script>

<style lang="scss" scoped>
.chart-wrapper-list {
  & .list-li {
    font-size: 12px;
    min-height: 20px;
    line-height: 20px;
    color: #000;
    padding: 5px 0;

    & .no {
      display: inline-block;
      font-style: normal;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      background: #dedede;
      margin-right: 3px;
      text-align: center;
      line-height: 20px;
      margin-right: 10px;
    }
    &:nth-child(-n + 3) .no {
      background: #333;
      color: #fff;
    }

    & span {
      display: inline-block;
      float: right;
    }
  }
}
</style>
