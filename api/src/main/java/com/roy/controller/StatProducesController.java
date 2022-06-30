package com.roy.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.entity.StatProducesByYear;
import com.roy.entity.StatProduces;
import com.roy.entity.StatProducesByRank;
import com.roy.service.StatProducesService;
import com.roy.utils.Common;
import com.roy.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author roy
 * @date 2020-07-27
 */

@RestController
@RequestMapping("/api/statProduces")
public class StatProducesController {

    @Autowired
    private StatProducesService statProducesService;

    /***
     * 获取年度数据
     * @param token
     * @return
     */
    @PostMapping("/getByYear")
    public Response getByYear(@RequestHeader("token") String token) {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        StatProducesByYear statProducesByYear = statProducesService.findByYear();

        // 获取当前月份，用于求月均
        Calendar date = Calendar.getInstance();
        int currentMonth = date.get(Calendar.MONTH) + 1;

        JSONObject tempObject = new JSONObject();
        Long totalProfitMargin = statProducesByYear.getTotalProfitMargin();
        tempObject.put("orderAmount", totalProfitMargin); // 年利润/率
        tempObject.put("averageMonthlySales", totalProfitMargin / currentMonth); // 月均年利润
        Long annualExpenditure = statProducesByYear.getAnnualExpenditure();
        tempObject.put("receivableAmount", annualExpenditure); // 年支出
        tempObject.put("averageMonthlyReceivable", annualExpenditure / currentMonth); // 月均支出
        String returnRate = statProducesByYear.getReturnRate();
        tempObject.put("refundAmount", returnRate); // 返稿率
        tempObject.put("averageMonthlyRefund", Double.parseDouble(returnRate) / currentMonth); // 月均返稿率
        Long deliveryWords = statProducesByYear.getDeliveryWords();
        tempObject.put("deliveryWords", deliveryWords); // 交付字数
        tempObject.put("averageMonthlyDelivery", deliveryWords / currentMonth); // 月均交付字数
        return Response.yes(tempObject);
    }

    /***
     * 获取排名数据
     * @param token
     * @param params
     * @return
     */
    @PostMapping("/rankingData")
    public Response rankingData(@RequestHeader("token") String token, @RequestBody JSONObject params) throws ParseException {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        String statType = params.getString("statType");
        if (statType == null || statType.length() <= 0) {
            statType = "1";
        }
        String startDateStr = params.getString("startDate");
        String endDateStr = params.getString("endDate");
        if (startDateStr == null || startDateStr.length() <= 0 || endDateStr == null || endDateStr.length() <= 0) {
            return Response.no("请选择日期区间！");
        }
        Long diffDays = Common.differentDaysByString(startDateStr, endDateStr);
        if(diffDays > 365){
            return Response.no("日期跨度不能超过365天！");
        }
        // 成员
        //String sysAccountIds = params.getString("sysAccountIds"); // 需要替换的字符多，舍弃
        JSONArray sysAccountIdsArray = params.getJSONArray("sysAccountIds");
        String sysAccountIds = sysAccountIdsArray.toString();
        sysAccountIds = sysAccountIds.replace("[", "");
        sysAccountIds = sysAccountIds.replace("]", "");
        //return Response.yes(sysAccountIds);

        // 渠道
        String statChannel = params.getString("channel");
        if (statChannel == null || statChannel.length() <= 0) {
            statChannel = "'1','2','3','4','5','6','7','8'";
        }
        // 订单类型
        String orderType = params.getString("orderType");
        if (orderType == null || orderType.length() <= 0) {
            orderType = "'1','2','3','4'";
        }

        // 排名
        List<StatProducesByRank> statProducesList = null;
        if (sysAccountIds == null || sysAccountIds.length() <= 0) {
            // 全部
            statProducesList = statProducesService.findAllRankData(statChannel, orderType, statType, startDateStr, endDateStr);
        }else {
            // 按sysAccountIds
            statProducesList = statProducesService.findRankData(statChannel, orderType, statType, startDateStr, endDateStr, sysAccountIds);
        }

        return Response.yes(statProducesList);
    }

    /***
     * 获取时间段内统计的生产数据
     * @param token
     * @param params
     * @return
     */
    @PostMapping("/getProducesData")
    public Response getProducesData(@RequestHeader("token") String token, @RequestBody JSONObject params) throws ParseException {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        // 定义返回
        JSONObject resultObjct = new JSONObject();

        String statType = params.getString("statType");
        if (statType == null || statType.length() <= 0) {
            statType = "1";
        }
        String startDateStr = params.getString("startDate");
        String endDateStr = params.getString("endDate");
        if (startDateStr == null || startDateStr.length() <= 0 || endDateStr == null || endDateStr.length() <= 0) {
            return Response.no("请选择日期区间！");
        }
        Long diffDays = Common.differentDaysByString(startDateStr, endDateStr);
        if(diffDays > 365){
            return Response.no("日期跨度不能超过365天！");
        }
        // 比较两个日期相差的天数，生成2个日期中间的具体日期或月份
        JSONArray xAxisData = Common.twoDays(startDateStr, endDateStr);
        //return Response.yes(xAxisData);
        resultObjct.put("xAxisData", xAxisData);
        //return Response.yes(resultObjct);
        // 成员
        //String sysAccountIds = params.getString("sysAccountIds"); // 需要替换的字符多，舍弃
        JSONArray sysAccountIdsArray = params.getJSONArray("sysAccountIds");
        String sysAccountIds = sysAccountIdsArray.toString();
        sysAccountIds = sysAccountIds.replace("[", "");
        sysAccountIds = sysAccountIds.replace("]", "");
        //return Response.yes(sysAccountIds);

        // 渠道
        String statChannel = params.getString("channel");
        if (statChannel == null || statChannel.length() <= 0) {
            statChannel = "'1','2','3','4','5','6','7','8'";
        }
        // 订单类型
        String orderType = params.getString("orderType");
        if (orderType == null || orderType.length() <= 0) {
            orderType = "'1','2','3','4'";
        }

        // 获取统计数据
        List<StatProduces> statProducesList = null;
        if (sysAccountIds == null || sysAccountIds.length() <= 0) {
            // 获取全部数据
            statProducesList = statProducesService.getAllData(statChannel, orderType, statType, startDateStr, endDateStr);
        }else {
            // 获取统计数据
            statProducesList = statProducesService.findBySysAccountIds(statChannel, orderType, statType, startDateStr, endDateStr, sysAccountIds);
        }
        //return Response.yes(statProducesList);

        // 按accountCode分组
        Map<String, List<StatProduces>> groupByAccountCode = statProducesList.stream().collect(Collectors.groupingBy(StatProduces::getAccountCode));
        //return Response.yes(groupByAccountCode);

        JSONArray seriesList = new JSONArray();
        for (String key : groupByAccountCode.keySet()) {
            JSONObject jsonObjectStat = new JSONObject();
            jsonObjectStat.put("accountCode", key);

            List<StatProduces> itemList = groupByAccountCode.get(key);
            //List<String> accountCodeList = itemList.stream().map(i->i.getAccountCode()).collect(Collectors.toList());
            List<String> statDateList = itemList.stream().map(i -> i.getStatDate()).collect(Collectors.toList());
            //jsonObjectStat.put("accountCodeList", accountCodeList);
            //jsonObjectStat.put("statDateList", statDateList);

            JSONArray seriesData = new JSONArray();

            for (int j = 0; j < xAxisData.size(); j++) {
                String jDateStr = xAxisData.getString(j);
                String statResult = "0";

                //JSONObject seriesObject = new JSONObject();
                //seriesObject.put("statDate", jDateStr);
                if (statDateList.contains(jDateStr)) {
                    statResult = _getStatResult(itemList, key, jDateStr);
                }
                //seriesObject.put("statResult", statResult);
                //seriesData.add(seriesObject);
                //Integer.parseInt(statResult);
                seriesData.add(statResult);
            }

            jsonObjectStat.put("seriesData", seriesData);
            seriesList.add(jsonObjectStat);
        }
        //return Response.yes(seriesList);
        resultObjct.put("seriesList", seriesList);
        return Response.yes(resultObjct);
    }

    @PostMapping("/getByGroupIds")
    public Response getByGroupIds(@RequestHeader("token") String token, @RequestBody JSONObject params) {
        return Response.no("暂不支持此方法！");
    }

    @PostMapping("/getByDepartmentIds")
    public Response getByDepartmentIds(@RequestHeader("token") String token, @RequestBody JSONObject params) {
        return Response.no("暂不支持此方法！");
    }

    /**
     * 根据accountCode和statDate从itemList获取统计结果
     *
     * @param itemList
     * @param accountCode
     * @param statDate
     * @return 统计结果
     */
    private String _getStatResult(List<StatProduces> itemList, String accountCode, String statDate) {
        String result = "0";
        for (int i = 0; i < itemList.size(); i++) {
            StatProduces item = itemList.get(i);
            if (item.getAccountCode().equals(accountCode) && item.getStatDate().equals(statDate)) {
                result = item.getStatResult();
            }
        }
        return result;
    }
}
