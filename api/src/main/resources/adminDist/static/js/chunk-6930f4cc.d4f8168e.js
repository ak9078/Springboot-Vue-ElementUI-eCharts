(window["webpackJsonp"]=window["webpackJsonp"]||[]).push([["chunk-6930f4cc"],{"0f7b":function(e,t,a){},"413e":function(e,t,a){"use strict";a.d(t,"a",(function(){return i})),a.d(t,"b",(function(){return l}));a("96cf");var n=a("1da1"),r=a("14b2"),s=a("2b0e");new s["default"];function i(e){return c.apply(this,arguments)}function c(){return c=Object(n["a"])(regeneratorRuntime.mark((function e(t){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a="/api/sysOrganization/allTeam",e.next=3,r["a"].getDetail(t,a,"post");case 3:return e.abrupt("return",e.sent);case 4:case"end":return e.stop()}}),e)}))),c.apply(this,arguments)}function l(e){return u.apply(this,arguments)}function u(){return u=Object(n["a"])(regeneratorRuntime.mark((function e(t){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a="/api/sysOrganizationMember/findByOrgId",e.next=3,r["a"].getDetail(t,a,"post");case 3:return e.abrupt("return",e.sent);case 4:case"end":return e.stop()}}),e)}))),u.apply(this,arguments)}},"764b":function(e,t,a){"use strict";var n=a("0f7b"),r=a.n(n);r.a},a4e8:function(e,t,a){"use strict";var n=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{class:e.className,style:{height:e.height,width:e.width},attrs:{id:"barChart",chartOptions:e.chartOptions}})},r=[],s=(a("b0c0"),a("b680"),a("313e")),i=a.n(s),c=a("ed08"),l={data:function(){return{$_sidebarElm:null,$_resizeHandler:null}},mounted:function(){var e=this;this.$_resizeHandler=Object(c["a"])((function(){e.chart&&e.chart.resize()}),100),this.$_initResizeEvent(),this.$_initSidebarResizeEvent()},beforeDestroy:function(){this.$_destroyResizeEvent(),this.$_destroySidebarResizeEvent()},activated:function(){this.$_initResizeEvent(),this.$_initSidebarResizeEvent()},deactivated:function(){this.$_destroyResizeEvent(),this.$_destroySidebarResizeEvent()},methods:{$_initResizeEvent:function(){window.addEventListener("resize",this.$_resizeHandler)},$_destroyResizeEvent:function(){window.removeEventListener("resize",this.$_resizeHandler)},$_sidebarResizeHandler:function(e){"width"===e.propertyName&&this.$_resizeHandler()},$_initSidebarResizeEvent:function(){this.$_sidebarElm=document.getElementsByClassName("sidebar-container")[0],this.$_sidebarElm&&this.$_sidebarElm.addEventListener("transitionend",this.$_sidebarResizeHandler)},$_destroySidebarResizeEvent:function(){this.$_sidebarElm&&this.$_sidebarElm.removeEventListener("transitionend",this.$_sidebarResizeHandler)}}};a("817d");var u={mixins:[l],props:{className:{type:String,default:"chart"},width:{type:String,default:"100%"},height:{type:String,default:"300px"},chartOptions:{type:Object,default:{}}},data:function(){return{chart:null}},mounted:function(){var e=this;this.$nextTick((function(){e.initChart(),e.setOptions()}))},watch:{chartOptions:function(e){this.chart&&this.chart.dispose(),this.chart=null,this.initChart(),this.chartOptions=e,this.chart.showLoading({text:"数据正在努力加载...",textStyle:{fontSize:30,color:"#444"},effectOption:{backgroundColor:"rgba(0, 0, 0, 0)"}});var t=this;t.$nextTick((function(){setTimeout((function(){t.setOptions()}),2e3)}))}},beforeDestroy:function(){this.chart&&(this.chart.dispose(),this.chart=null)},methods:{initChart:function(){this.chart=i.a.init(this.$el,"macarons")},setOptions:function(){var e=this.chartOptions.seriesList||[];e.length>0?this.chart.setOption({tooltip:{trigger:"axis",axisPointer:{type:"shadow"},formatter:function(e){for(var t=!1,a=e[0].name,n=0,r=0,s=e.length;r<s;r++)n+=parseFloat(e[r].value);for(var i=0,c=e.length;i<c;i++){var l=e[i].value,u=e[i].data;0!=u&&(a+="<br/>",a+=e[i].seriesName+": "+u+" ",a+=(100*parseFloat(l)/parseFloat(n)).toFixed(2)+"%"),0!=l&&(t=!0)}if(t)return a},position:function(e){return[e[0]+10,e[1]-10]},enterable:!0,extraCssText:"height: 200px; overflow: auto;",confine:!0},grid:{top:10,left:"2%",right:"2%",bottom:"3%",containLabel:!0},xAxis:[{type:"category",data:this.chartOptions.xAxisData,axisTick:{alignWithLabel:!0}}],yAxis:[{type:"value",axisTick:{show:!1}}],series:this.chartOptions.seriesList}):this.chart.setOption({title:{text:"暂无数据",x:"center",y:"center",textStyle:{color:"#f56c6c",fontWeight:"normal",fontSize:12}}}),this.chart.hideLoading()}}},o=u,d=a("2877"),p=Object(d["a"])(o,n,r,!1,null,null,null);t["a"]=p.exports},a66c:function(e,t,a){},b48b:function(e,t,a){"use strict";a.r(t);var n=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"dashboard-container"},[a(e.currentRole,{tag:"component"})],1)},r=[],s=a("5530"),i=a("2f62"),c=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("div",{staticClass:"dashboard-editor-container"},[a("el-card",{staticClass:"box-card",attrs:{"body-style":{padding:e.dataRangeLableList.length>0?"20px":"0px"}}},[a("div",{staticClass:"clearfix",attrs:{slot:"header"},slot:"header"},[a("div",{staticClass:"fl"},[a("span",{staticClass:"select-label"},[e._v("数据范围")]),a("el-select",{staticStyle:{width:"220px"},attrs:{placeholder:"请选择",multiple:"","collapse-tags":""},on:{change:function(t){return e.dataRangeChange(t)}},model:{value:e.dataRangeValueList,callback:function(t){e.dataRangeValueList=t},expression:"dataRangeValueList"}},[a("el-option",{attrs:{value:"",label:"全部数据"},nativeOn:{click:function(t){return e.dataRangeAll()}}}),e._l(e.dataRangeOptions,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})}))],2)],1),a("div",{staticClass:"fr"},[a("span",{staticClass:"select-label"},[e._v("渠道选择")]),a("el-select",{attrs:{placeholder:"请选择"},on:{change:function(t){return e.channelRangeChange(t)}},model:{value:e.channelRangeValue,callback:function(t){e.channelRangeValue=t},expression:"channelRangeValue"}},e._l(e.channelRangeOptions,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1),a("span",{staticClass:"select-label margin-left-10"},[e._v("订单类型")]),a("el-select",{attrs:{placeholder:"请选择"},on:{change:function(t){return e.orderTypeRangeChange(t)}},model:{value:e.orderTypeRangeValue,callback:function(t){e.orderTypeRangeValue=t},expression:"orderTypeRangeValue"}},e._l(e.orderTypeRangeOptions,(function(e){return a("el-option",{key:e.value,attrs:{label:e.label,value:e.value}})})),1)],1)]),e.dataRangeLableList?a("section",{staticClass:"text-item"},[a("div",{directives:[{name:"loading",rawName:"v-loading",value:e.dataRangeLableListLoading,expression:"dataRangeLableListLoading"}]},e._l(e.dataRangeLableList,(function(t,n){return a("div",{key:n},[e._v(" "+e._s(t.label)+"： "),e._l(t.memberList,(function(t,n){return a("span",{key:n,class:!0===t.isChecked?"":"cancel",on:{click:function(a){return e.clickMember(t)}}},[e._v(" "+e._s(t.accountCode)+" ")])})),n!=e.dataRangeLableList.length-1?a("el-divider"):e._e()],2)})),0)]):e._e()]),a("PanelGroup"),a("el-card",{staticClass:"box-card chart-main"},[a("div",{staticClass:"right-area"},[a("el-button",{class:"week"==e.dateQuickValue?"checked":"",attrs:{type:"text"},on:{click:function(t){return e.dateQuickSelect("week")}}},[e._v("本周")]),a("el-button",{class:"month"==e.dateQuickValue?"checked":"",attrs:{type:"text"},on:{click:function(t){return e.dateQuickSelect("month")}}},[e._v("本月")]),a("el-button",{staticClass:"last-child",class:"year"==e.dateQuickValue?"checked":"",attrs:{type:"text"},on:{click:function(t){return e.dateQuickSelect("year")}}},[e._v("全年")]),a("el-date-picker",{attrs:{type:"daterange","range-separator":"至","start-placeholder":"开始日期","end-placeholder":"结束日期",format:"yyyy-MM-dd","value-format":"yyyy-MM-dd"},on:{change:function(t){return e.dateRangeChange(t)}},model:{value:e.dateRangeValue,callback:function(t){e.dateRangeValue=t},expression:"dateRangeValue"}})],1),a("el-tabs",{on:{"tab-click":e.handleClick},model:{value:e.tabsActiveName,callback:function(t){e.tabsActiveName=t},expression:"tabsActiveName"}},[a("el-tab-pane",{attrs:{label:"利润率",name:"first",lazy:!0}},[a("el-row",{attrs:{gutter:32}},[a("el-col",{attrs:{xs:24,sm:24,lg:16}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("利润率趋势")]),a("BarChart",{attrs:{chartOptions:e.chartOptions}})],1)]),a("el-col",{attrs:{xs:24,sm:24,lg:8}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("利润率排名")]),a("RankingTable",{attrs:{rankingLoading:e.rankingLoading,rankingTabList:e.rankingTabList}})],1)])],1)],1),a("el-tab-pane",{attrs:{label:"超时时长",name:"second",lazy:!0}},[a("el-row",{attrs:{gutter:32}},[a("el-col",{attrs:{xs:24,sm:24,lg:16}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("超时时长趋势")]),a("BarChart",{attrs:{chartOptions:e.chartOptions}})],1)]),a("el-col",{attrs:{xs:24,sm:24,lg:8}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("超时时长排名")]),a("RankingTable",{attrs:{rankingLoading:e.rankingLoading,rankingTabList:e.rankingTabList}})],1)])],1)],1),a("el-tab-pane",{attrs:{label:"返稿量",name:"third",lazy:!0}},[a("el-row",{attrs:{gutter:32}},[a("el-col",{attrs:{xs:24,sm:24,lg:16}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("返稿量趋势")]),a("BarChart",{attrs:{chartOptions:e.chartOptions}})],1)]),a("el-col",{attrs:{xs:24,sm:24,lg:8}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("返稿量排名")]),a("RankingTable",{attrs:{rankingLoading:e.rankingLoading,rankingTabList:e.rankingTabList}})],1)])],1)],1),a("el-tab-pane",{attrs:{label:"交付字数",name:"fourth",lazy:!0}},[a("el-row",{attrs:{gutter:32}},[a("el-col",{attrs:{xs:24,sm:24,lg:16}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("交付字数趋势")]),a("BarChart",{attrs:{chartOptions:e.chartOptions}})],1)]),a("el-col",{attrs:{xs:24,sm:24,lg:8}},[a("div",{staticClass:"chart-wrapper"},[a("div",{staticClass:"chart-wrapper-title"},[e._v("交付字数趋势")]),a("RankingTable",{attrs:{rankingLoading:e.rankingLoading,rankingTabList:e.rankingTabList}})],1)])],1)],1)],1)],1)],1)},l=[],u=(a("4de4"),a("c740"),a("caad"),a("d81d"),a("b0c0"),a("2532"),a("96cf"),a("1da1")),o=a("413e"),d=a("14b2"),p=a("2b0e");new p["default"];function g(e){return h.apply(this,arguments)}function h(){return h=Object(u["a"])(regeneratorRuntime.mark((function e(t){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a="/api/statProduces/getByYear",e.next=3,d["a"].getDetail(t,a,"post");case 3:return e.abrupt("return",e.sent);case 4:case"end":return e.stop()}}),e)}))),h.apply(this,arguments)}function b(e){return v.apply(this,arguments)}function v(){return v=Object(u["a"])(regeneratorRuntime.mark((function e(t){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a="/api/statProduces/getProducesData",e.next=3,d["a"].getDetail(t,a,"post");case 3:return e.abrupt("return",e.sent);case 4:case"end":return e.stop()}}),e)}))),v.apply(this,arguments)}function m(e){return f.apply(this,arguments)}function f(){return f=Object(u["a"])(regeneratorRuntime.mark((function e(t){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a="/api/statProduces/rankingData",e.next=3,d["a"].getDetail(t,a,"post");case 3:return e.abrupt("return",e.sent);case 4:case"end":return e.stop()}}),e)}))),f.apply(this,arguments)}var k=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("el-row",{staticClass:"panel-group",attrs:{gutter:20}},[a("el-col",{staticClass:"card-panel-col",attrs:{xs:24,sm:24,lg:6}},[a("div",{staticClass:"card-panel bg-1"},[a("div",{staticClass:"card-panel-description"},[a("div",{staticClass:"card-panel-text"},[e._v("年利润率")]),a("count-to",{staticClass:"card-panel-num",attrs:{"start-val":0,"end-val":e.yearData.orderAmount,duration:2600,decimals:2}}),a("div",{staticClass:"card-panel-remark"},[e._v(" 月均利润率 "+e._s(e.yearData.averageMonthlySales)+" ")])],1)])]),a("el-col",{staticClass:"card-panel-col",attrs:{xs:24,sm:24,lg:6}},[a("div",{staticClass:"card-panel bg-2"},[a("div",{staticClass:"card-panel-description"},[a("div",{staticClass:"card-panel-text"},[e._v("年支出")]),a("count-to",{staticClass:"card-panel-num",attrs:{"start-val":0,"end-val":e.yearData.receivableAmount,duration:3e3}}),a("div",{staticClass:"card-panel-remark"},[e._v(" 月均支出 ¥ "+e._s(e._f("toThousandFilter")(e.yearData.averageMonthlyReceivable))+" ")])],1)])]),a("el-col",{staticClass:"card-panel-col",attrs:{xs:24,sm:24,lg:6}},[a("div",{staticClass:"card-panel bg-3"},[a("div",{staticClass:"card-panel-description"},[a("div",{staticClass:"card-panel-text"},[e._v("返稿率")]),a("count-to",{staticClass:"card-panel-num",attrs:{"start-val":0,"end-val":1*e.yearData.refundAmount,duration:3200,decimals:2}}),a("div",{staticClass:"card-panel-remark"},[e._v(" 月均返稿率 "+e._s(e.yearData.averageMonthlyRefund)+" ")])],1)])]),a("el-col",{staticClass:"card-panel-col",attrs:{xs:24,sm:24,lg:6}},[a("div",{staticClass:"card-panel bg-4"},[a("div",{staticClass:"card-panel-description"},[a("div",{staticClass:"card-panel-text"},[e._v("交付字数")]),a("count-to",{staticClass:"card-panel-num",attrs:{"start-val":0,"end-val":e.yearData.deliveryWords,duration:3200}})],1)])])],1)},R=[],x=a("ec1b"),y=a.n(x),w=(a("ed08"),{components:{CountTo:y.a},data:function(){return{yearData:{}}},mounted:function(){this.getByYearData()},methods:{getByYearData:function(){var e=this;return Object(u["a"])(regeneratorRuntime.mark((function t(){var a,n,r;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return a=e,n={},t.next=4,g(n);case 4:r=t.sent,0==r.code?a.yearData=r.data||{}:a.$message(r.message?r.message:"年度有关数据获取失败");case 6:case"end":return t.stop()}}),t)})))()}}}),C=w,L=(a("764b"),a("2877")),_=Object(L["a"])(C,k,R,!1,null,"0c15d524",null),O=_.exports,D=a("a4e8"),T=a("e2bc"),V={name:"DashboardAdmin",components:{PanelGroup:O,BarChart:D["a"],RankingTable:T["a"]},data:function(){return{dataRangeOptions:[],dataRangeValueList:[],channelRangeOptions:[{value:"",label:"全部渠道"},{value:"1,2,5,6,7,8",label:"线上"},{value:"1,2,3,4",label:"线下"}],channelRangeValue:"",orderTypeRangeOptions:[{value:"",label:"全部类型"},{value:"1",label:"快速翻译（线上）"},{value:"2",label:"文档订单（线上、线下）"},{value:"3",label:"口译服务（线下）"},{value:"4",label:"其他"}],orderTypeRangeValue:"",dataRangeLableList:[],dataRangeLableListLoading:!1,dateQuickValue:"",dateRangeValue:[],tabsActiveName:"first",rankingTabList:[],rankingLoading:!1,chartOptions:{}}},mounted:function(){var e=this;return Object(u["a"])(regeneratorRuntime.mark((function t(){var a,n,r,s;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:return a=e,n={code:"XM"},t.next=4,Object(o["a"])(n);case 4:r=t.sent,0==r.code?(s=r.data||[],a.dataRangeOptions=s.map((function(e){return{label:e.name,value:e.id}}))):a.$message(r.message?r.message:"团队数据获取失败");case 6:case"end":return t.stop()}}),t)})))()},methods:{getTeamMemberList:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function a(){var n,r,s;return regeneratorRuntime.wrap((function(a){while(1)switch(a.prev=a.next){case 0:return n=t,r=[],a.next=4,Object(o["b"])({orgId:e.value});case 4:return s=a.sent,0==s.code?(r=s.data||[],r.map((function(e){e.isChecked=!0})),n.dataRangeLableList.findIndex((function(t){return t.label==e.label}))<0&&n.dataRangeLableList.push({label:e.label,memberList:r})):n.$message(s.message?s.message:"团队成员数据获取失败"),a.abrupt("return",r);case 7:case"end":return a.stop()}}),a)})))()},dataRangeChange:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function a(){var n,r,s,i,c;return regeneratorRuntime.wrap((function(a){while(1)switch(a.prev=a.next){case 0:if(n=t,r=0,e.includes("")&&1==e.length?r=1:(r=0,n.dataRangeValueList=n.dataRangeValueList.filter((function(e){return e}))),n.dataRangeLableListLoading=!0,n.dataRangeLableList=[],0!=r){a.next=30;break}s=0;case 7:if(!(s<n.dataRangeOptions.length)){a.next=21;break}i=n.dataRangeOptions[s],c=0;case 10:if(!(c<e.length)){a.next=18;break}if(i.value!=e[c]){a.next=15;break}return a.next=14,n.getTeamMemberList(i);case 14:return a.abrupt("break",18);case 15:c++,a.next=10;break;case 18:s++,a.next=7;break;case 21:if(!n.dateRangeValue){a.next=28;break}return a.next=24,n.getBarChartData();case 24:return a.next=26,n.getRankingData();case 26:a.next=30;break;case 28:n.dateQuickValue=n.dateQuickValue?n.dateQuickValue:"week",n.dateQuickSelect(n.dateQuickValue);case 30:n.$nextTick((function(){n.dataRangeLableListLoading=!1}));case 31:case"end":return a.stop()}}),a)})))()},dataRangeAll:function(){var e=this;return Object(u["a"])(regeneratorRuntime.mark((function t(){var a;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:if(a=e,a.dataRangeValueList=[""],!a.dateRangeValue){t.next=9;break}return t.next=5,a.getBarChartData();case 5:return t.next=7,a.getRankingData();case 7:t.next=11;break;case 9:a.dateQuickValue=a.dateQuickValue?a.dateQuickValue:"week",a.dateQuickSelect(a.dateQuickValue);case 11:case"end":return t.stop()}}),t)})))()},clickMember:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function a(){var n;return regeneratorRuntime.wrap((function(a){while(1)switch(a.prev=a.next){case 0:return n=t,e.isChecked=!e.isChecked,a.next=4,n.getBarChartData();case 4:return a.next=6,n.getRankingData();case 6:case"end":return a.stop()}}),a)})))()},dateQuickSelect:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function a(){var n,r,s,i,c,l;return regeneratorRuntime.wrap((function(a){while(1)switch(a.prev=a.next){case 0:n=t,n.dateQuickValue=e,r=new Date,s=new Date,a.t0=e,a.next="week"===a.t0?7:"month"===a.t0?10:"year"===a.t0?12:15;break;case 7:return i=r.getDay()||7,r.setDate(r.getDate()-i+1),a.abrupt("break",15);case 10:return r.setDate(1),a.abrupt("break",15);case 12:return r.setDate(1),r.setMonth(0),a.abrupt("break",15);case 15:return c=n.dateFormat(r,"yyyy-MM-dd"),l=n.dateFormat(s,"yyyy-MM-dd"),n.dateRangeValue=[c,l],a.next=20,n.getBarChartData();case 20:return a.next=22,n.getRankingData();case 22:case"end":return a.stop()}}),a)})))()},channelRangeChange:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function e(){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a=t,e.next=3,a.getBarChartData();case 3:return e.next=5,a.getRankingData();case 5:case"end":return e.stop()}}),e)})))()},orderTypeRangeChange:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function e(){var a;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return a=t,e.next=3,a.getBarChartData();case 3:return e.next=5,a.getRankingData();case 5:case"end":return e.stop()}}),e)})))()},dateRangeChange:function(e){var t=this;return Object(u["a"])(regeneratorRuntime.mark((function a(){var n;return regeneratorRuntime.wrap((function(a){while(1)switch(a.prev=a.next){case 0:return n=t,n.dateQuickValue="",n.dateRangeValue=e,a.next=5,n.getBarChartData();case 5:return a.next=7,n.getRankingData();case 7:case"end":return a.stop()}}),a)})))()},handleClick:function(e,t){var a=this;return Object(u["a"])(regeneratorRuntime.mark((function e(){var t;return regeneratorRuntime.wrap((function(e){while(1)switch(e.prev=e.next){case 0:return t=a,e.next=3,t.getBarChartData();case 3:return e.next=5,t.getRankingData();case 5:case"end":return e.stop()}}),e)})))()},getBarChartData:function(){var e=this;return Object(u["a"])(regeneratorRuntime.mark((function t(){var a,n,r,s,i,c,l,u,o,d,p,g;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:a=e,a.chartOptions={},n=0,t.t0=a.tabsActiveName,t.next="first"===t.t0?6:"second"===t.t0?8:"third"===t.t0?10:"fourth"===t.t0?12:14;break;case 6:return n=1,t.abrupt("break",14);case 8:return n=2,t.abrupt("break",14);case 10:return n=3,t.abrupt("break",14);case 12:return n=4,t.abrupt("break",14);case 14:if(r=a.dateRangeValue||[],s=a.getCheckedMemberList(),i=r[0],c=r[1],i&&c){t.next=21;break}return a.$message("请选择日期区间"),t.abrupt("return",!1);case 21:return l={statType:n,startDate:i,endDate:c,sysAccountIds:s,channel:a.channelRangeValue,orderType:a.orderTypeRangeValue},t.next=24,b(l);case 24:u=t.sent,0==u.code?(o=u.data||[],d=o.xAxisData||[],p=o.seriesList||[],g=p.map((function(e){return{name:e.accountCode,type:"bar",stack:"vistors",barWidth:"60%",data:e.seriesData,animationDuration:3e3}})),a.chartOptions={xAxisData:d,seriesList:g}):a.$message(u.message?u.message:"饼图数据获取失败");case 26:case"end":return t.stop()}}),t)})))()},getRankingData:function(){var e=this;return Object(u["a"])(regeneratorRuntime.mark((function t(){var a,n,r,s,i,c,l,u,o;return regeneratorRuntime.wrap((function(t){while(1)switch(t.prev=t.next){case 0:a=e,a.rankingTabList=[],n=0,t.t0=a.tabsActiveName,t.next="first"===t.t0?6:"second"===t.t0?8:"third"===t.t0?10:"fourth"===t.t0?12:14;break;case 6:return n=1,t.abrupt("break",14);case 8:return n=2,t.abrupt("break",14);case 10:return n=3,t.abrupt("break",14);case 12:return n=4,t.abrupt("break",14);case 14:if(a.rankingLoading=!0,t.prev=15,r=a.dateRangeValue||[],s=a.getCheckedMemberList(),i=r[0],c=r[1],i&&c){t.next=23;break}return a.$message("请选择日期区间"),t.abrupt("return",!1);case 23:return l={statType:n,startDate:i,endDate:c,sysAccountIds:s,channel:a.channelRangeValue,orderType:a.orderTypeRangeValue},t.next=26,m(l);case 26:u=t.sent,0==u.code?(o=u.data||[],a.rankingTabList=o.map((function(e){return{statName:e.accountCode,statValue:e.statResult}}))):a.$message(u.message?u.message:"排名数据获取失败");case 28:return t.prev=28,a.rankingLoading=!1,t.finish(28);case 31:case"end":return t.stop()}}),t,null,[[15,,28,31]])})))()},getCheckedMemberList:function(){for(var e=this,t=[],a=0;a<e.dataRangeLableList.length;a++)for(var n=e.dataRangeLableList[a],r=0;r<n.memberList.length;r++){var s=n.memberList[r];s.isChecked&&t.push(s.userId)}return t}}},$=V,z=(a("bdbb"),Object(L["a"])($,c,l,!1,null,"ad6bfd34",null)),j=z.exports,E={name:"ProductionDashboard",components:{adminDashboard:j},data:function(){return{currentRole:"adminDashboard"}},computed:Object(s["a"])({},Object(i["b"])(["roles"]))},M=E,S=Object(L["a"])(M,n,r,!1,null,null,null);t["default"]=S.exports},bdbb:function(e,t,a){"use strict";var n=a("dce9"),r=a.n(n);r.a},dce9:function(e,t,a){},dee2:function(e,t,a){"use strict";var n=a("a66c"),r=a.n(n);r.a},e2bc:function(e,t,a){"use strict";var n=function(){var e=this,t=e.$createElement,a=e._self._c||t;return a("ul",{directives:[{name:"loading",rawName:"v-loading",value:e.rankingLoading,expression:"rankingLoading"}],staticClass:"chart-wrapper-list"},[0==e.rankingTabList.length?a("li",{staticClass:"no-data"},[e._v(" 暂无数据 ")]):e._e(),e._l(e.rankingTabList,(function(t,n){return a("li",{key:n,staticClass:"list-li"},[a("i",{staticClass:"no"},[e._v(e._s(n+1))]),e._v(" "+e._s(t.statName)+" "),a("span",[e._v(e._s(e._f("toThousandFilter")(t.statValue)))])])}))],2)},r=[],s={props:{rankingLoading:{type:Boolean,default:!1},rankingTabList:{type:Array,default:[]}},data:function(){return{chart:null}},mounted:function(){},methods:{}},i=s,c=(a("dee2"),a("2877")),l=Object(c["a"])(i,n,r,!1,null,"8612973a",null);t["a"]=l.exports}}]);