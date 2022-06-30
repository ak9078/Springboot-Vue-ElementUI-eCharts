package com.roy.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.entity.StatOrdersByYear;
import com.roy.entity.StatOrders;
import com.roy.entity.StatOrdersByRank;
import com.roy.service.StatOrdersService;
import com.roy.utils.Common;
import com.roy.utils.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author roy
 * @date 2020-07-27
 */

@RestController
@RequestMapping("/api/statOrders")
public class StatOrdersController {

    @Autowired
    private StatOrdersService statOrdersService;

    /***
     * 获取年度数据
     * @param token
     * @return
     */
    @PostMapping("/getByYear")
    public Response getByYear(@RequestHeader("token") String token, @RequestBody JSONObject params) throws ParseException {
        if (Objects.equals(token, "null") || token == null || token.length() <= 0) {
            return Response.no("您还没有登录！");
        }
        // 订单类型
        String channels = params.getString("channels");
        channels = channels.replace("\"", "");
        channels = channels.replace("\"", "");
        // 订单类型
        String orderTypes = params.getString("orderTypes");
        orderTypes = orderTypes.replace("\"", "");
        orderTypes = orderTypes.replace("\"", "");

        StatOrdersByYear statOrdersByYear = statOrdersService.findByYear(channels, orderTypes);

        // 获取当前月份，用于求月均
        Calendar date = Calendar.getInstance();
        int currentMonth = date.get(Calendar.MONTH) + 1;

        JSONObject tempObject = new JSONObject();
        Long orderAmount = statOrdersByYear.getCostPriceTotal();
        tempObject.put("orderAmount", orderAmount); // 年下单额
        tempObject.put("averageMonthlySales", orderAmount / currentMonth); // 月均销售额
        Long receivableAmount = statOrdersByYear.getParTotal();
        tempObject.put("receivableAmount", statOrdersByYear.getParTotal()); // 年应收额
        tempObject.put("averageMonthlyReceivable", receivableAmount / currentMonth); // 月均应收额
        Long refundAmount = statOrdersByYear.getReturnedMoneyTotal();
        tempObject.put("refundAmount", refundAmount); // 年回款额
        tempObject.put("averageMonthlyRefund", refundAmount / currentMonth); // 月均回款额
        Long deliveryWords = statOrdersByYear.getDeliveryWords();
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
        // 渠道
        JSONArray channelsArray = params.getJSONArray("channels");
        String channels = channelsArray.toString();
        channels = channels.replace("[", "");
        channels = channels.replace("]", "");
        if (channels == null || channels.length() <= 0 || channels.equals("\"\"")) {
            channels = "1,2,3,4,5,6,7,8";
        }
        //return Response.yes(channels);

        // 订单类型
        String orderType = params.getString("orderType");
        if (orderType == null || orderType.length() <= 0) {
            if(channels.equals("1,2,3,4") || channels.equals("\"3\",\"4\"")){
                // 线下 渠道
                orderType = "'2','3','4'";
            }else{
                orderType = "'1','2','4'";
            }
        }

        // 排名
        List<StatOrdersByRank> statOrdersList = statOrdersService.findRankData(orderType, statType, startDateStr, endDateStr, channels);
        return Response.yes(statOrdersList);
    }

    /***
     * 根据渠道获取时间段内的统计数据
     * @param token
     * @param params
     * @return
     */
    @PostMapping("/getByChannels")
    public Response getByChannels(@RequestHeader("token") String token, @RequestBody JSONObject params) throws ParseException {
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

        // 渠道
        JSONArray channelsArray = params.getJSONArray("channels");
        String channels = channelsArray.toString();
        channels = channels.replace("[", "");
        channels = channels.replace("]", "");
        if (channels == null || channels.length() <= 0 || channels.equals("\"\"")) {
            channels = "1,2,3,4,5,6,7,8";
        }
        //return Response.yes(channels);

        // 订单类型
        String orderType = params.getString("orderType");
        if (orderType == null || orderType.length() <= 0) {
            if(channels.equals("1,2,3,4") || channels.equals("\"3\",\"4\"")){
                // 线下 渠道
                orderType = "'2','3','4'";
            }else{
                orderType = "'1','2','4'";
            }
        }

        // 获取统计数据
        List<StatOrders> statOrdersList = statOrdersService.findByChannels(orderType, statType, startDateStr, endDateStr, channels);
        //return Response.yes(statOrdersList);

        // 按statChannel分组
        Map<String, List<StatOrders>> groupByChannelName = statOrdersList.stream().collect(Collectors.groupingBy(StatOrders::getChannelName));
        //return Response.yes(groupByChannelName);

        JSONArray seriesList = new JSONArray();
        for (String key : groupByChannelName.keySet()) {
            JSONObject jsonObjectStat = new JSONObject();
            jsonObjectStat.put("channelName", key);

            List<StatOrders> itemList = groupByChannelName.get(key);
            //List<String> statChannelList = itemList.stream().map(i->i.getAccountCode()).collect(Collectors.toList());
            List<String> statDateList = itemList.stream().map(i -> i.getStatDate()).collect(Collectors.toList());
            //jsonObjectStat.put("statChannelList", statChannelList);
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

    /**
     * 根据channelName和statDate从itemList获取统计结果
     *
     * @param itemList
     * @param channelName
     * @param statDate
     * @return 统计结果
     */
    private String _getStatResult(List<StatOrders> itemList, String channelName, String statDate) {
        String result = "0";
        for (int i = 0; i < itemList.size(); i++) {
            StatOrders item = itemList.get(i);
            if (item.getChannelName().equals(channelName) && item.getStatDate().equals(statDate)) {
                result = item.getStatResult();
            }
        }
        return result;
    }
}
