package com.roy.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.entity.StatSalesByYear;
import com.roy.entity.StatSales;
import com.roy.entity.StatSalesByRank;
import com.roy.service.StatSalesService;
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
@RequestMapping("/api/statSales")
public class StatSalesController {

    @Autowired
    private StatSalesService statSalesService;

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
        StatSalesByYear statSalesByYear = statSalesService.findByYear();

        // 获取当前月份，用于求月均
        Calendar date = Calendar.getInstance();
        int currentMonth = date.get(Calendar.MONTH) + 1;

        JSONObject tempObject = new JSONObject();
        Long orderAmount = statSalesByYear.getCostPriceTotal();
        tempObject.put("orderAmount", orderAmount); // 年下单额
        tempObject.put("averageMonthlySales", orderAmount / currentMonth); // 月均销售额
        Long receivableAmount = statSalesByYear.getParTotal();
        tempObject.put("receivableAmount", statSalesByYear.getParTotal()); // 年应收额
        tempObject.put("averageMonthlyReceivable", receivableAmount / currentMonth); // 月均应收额
        Long refundAmount = statSalesByYear.getReturnedMoneyTotal();
        tempObject.put("refundAmount", refundAmount); // 年回款额
        tempObject.put("averageMonthlyRefund", refundAmount / currentMonth); // 月均回款额
        return Response.yes(tempObject);
    }

    /***
     * 超期未回款额度
     * @param token
     * @param params
     * @return
     */
    @PostMapping("/overdue")
    public Response overdue(@RequestHeader("token") String token, @RequestBody JSONObject params) {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        String days = params.getString("days");
        if (days == null || days.length() <= 0) {
            days = "30";
        }
        int intDays = Integer.parseInt(days);
        // 超期未回款额度
        Long result = statSalesService.unreturnedMoneyTotal(intDays);
        return Response.yes(result);
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
        if (diffDays > 365) {
            return Response.no("日期跨度不能超过365天！");
        }
        // 成员
        //String sysAccountIds = params.getString("sysAccountIds"); // 需要替换的字符多，舍弃
        JSONArray sysAccountIdsArray = params.getJSONArray("sysAccountIds");
        if (sysAccountIdsArray.size() == 0) {
            return Response.no("请选择成员！");
        }
        String sysAccountIds = sysAccountIdsArray.toString();
        sysAccountIds = sysAccountIds.replace("[", "");
        sysAccountIds = sysAccountIds.replace("]", "");
        //return Response.yes(sysAccountIds);

        // 排名
        List<StatSalesByRank> statSalesList = statSalesService.findRankData(statType, startDateStr, endDateStr, sysAccountIds);
        return Response.yes(statSalesList);
    }

    /***
     * 根据成员id获取时间段内的统计数据
     * @param token
     * @param params
     * @return
     */
    @PostMapping("/getBySysAccountIds")
    public Response getBySysAccountIds(@RequestHeader("token") String token, @RequestBody JSONObject params) throws ParseException {
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
        if (diffDays > 365) {
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
        if (sysAccountIdsArray.size() == 0) {
            return Response.no("请选择成员！");
        }
        String sysAccountIds = sysAccountIdsArray.toString();
        sysAccountIds = sysAccountIds.replace("[", "");
        sysAccountIds = sysAccountIds.replace("]", "");
        //return Response.yes(sysAccountIds);

        // 获取统计数据
        List<StatSales> statSalesList = statSalesService.findBySysAccountIds(statType, startDateStr, endDateStr, sysAccountIds);
        //return Response.yes(statSalesList);

        // 按accountCode分组
        Map<String, List<StatSales>> groupByAccountCode = statSalesList.stream().collect(Collectors.groupingBy(StatSales::getAccountCode));
        //return Response.yes(groupByAccountCode);

        JSONArray seriesList = new JSONArray();
        for (String key : groupByAccountCode.keySet()) {
            JSONObject jsonObjectStat = new JSONObject();
            jsonObjectStat.put("accountCode", key);

            List<StatSales> itemList = groupByAccountCode.get(key);
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
    private String _getStatResult(List<StatSales> itemList, String accountCode, String statDate) {
        String result = "0";
        for (int i = 0; i < itemList.size(); i++) {
            StatSales item = itemList.get(i);
            if (item.getAccountCode().equals(accountCode) && item.getStatDate().equals(statDate)) {
                result = item.getStatResult();
            }
        }
        return result;
    }
}
