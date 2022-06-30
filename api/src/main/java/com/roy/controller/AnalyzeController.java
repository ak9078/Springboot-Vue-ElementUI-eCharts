package com.roy.controller;

import com.roy.service.StatOrdersService;
import com.roy.service.StatProducesService;
import com.roy.service.StatSalesService;
import com.roy.utils.Common;
import com.roy.utils.Response;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author roy
 * @date 2020-12-28
 */

@RestController
@RequestMapping("/api/analyze")
public class AnalyzeController {

    @Autowired
    private StatSalesService statSalesService;

    @Autowired
    private StatProducesService statProducesService;

    @Autowired
    private StatOrdersService statOrdersService;

    /***
     * 手动触发统计
     * @param dateStr
     * @return
     */
    @GetMapping("/auto")
    public Response auto(@RequestParam(value = "dateStr", required = false) String dateStr) {
        if (dateStr == null || dateStr.length() <= 0) {
            return Response.no("请输入要统计的日期！");
        }
        try {
            if(Common.isDate(dateStr, "yyyy-MM-dd")){
                _timingStatistics(dateStr);
                return Response.yes("完成");
            }else{
                return Response.no("请输入正确的日期！");
            }
        } catch (Exception e) {
            System.out.println(e.toString());
            return Response.no("程序异常了");
        }
    }

    // 统计所有数据
    @GetMapping("/timeSlot")
    public Response timeSlot(@RequestParam(value = "startDate", required = false) String startDateStr,
                             @RequestParam(value = "endDate", required = false) String endDateStr) {
        if (startDateStr == null || startDateStr.length() <= 0) {
            return Response.no("请输入要统计的开始日期！");
        }
        if (endDateStr == null || endDateStr.length() <= 0) {
            return Response.no("请输入要统计的结束日期！");
        }

        try {
            Long diffDays = Common.differentDaysByString(startDateStr, endDateStr);
            if(diffDays > 31){
                return Response.no("日期跨度不能超过31天！");
            }

//            List<String> dateList = new ArrayList<String>();

            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            // 起始日期
            Date startDate = sdf.parse(startDateStr);
            // 结束日期
            Date endDate = sdf.parse(endDateStr);

            Date tmp = startDate;
            Calendar startCalendar = Calendar.getInstance();
            startCalendar.setTime(startDate);

            // 打印日期
            while(tmp.getTime() < endDate.getTime()){
                tmp = startCalendar.getTime();
                // 天数加1
                startCalendar.add(Calendar.DAY_OF_MONTH,1);
                String dateStr = sdf.format(tmp);
//                dateList.add(dateStr);
                _timingStatistics(dateStr);
            }
//            return Response.yes(dateList);
            return Response.yes("完成");
        } catch (Exception e) {
            System.out.println(e.toString());
            return Response.no("程序异常了");
        }
    }

    // 只统计生产数据
    @GetMapping("/timeSlot_1")
    public Response timeSlot_1(@RequestParam(value = "startDate", required = false) String startDateStr,
                             @RequestParam(value = "endDate", required = false) String endDateStr) {
        if (startDateStr == null || startDateStr.length() <= 0) {
            return Response.no("请输入要统计的开始日期！");
        }
        if (endDateStr == null || endDateStr.length() <= 0) {
            return Response.no("请输入要统计的结束日期！");
        }

        try {
            Long diffDays = Common.differentDaysByString(startDateStr, endDateStr);
            if(diffDays > 31){
                return Response.no("日期跨度不能超过31天！");
            }

//            List<String> dateList = new ArrayList<String>();

            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            // 起始日期
            Date startDate = sdf.parse(startDateStr);
            // 结束日期
            Date endDate = sdf.parse(endDateStr);

            Date tmp = startDate;
            Calendar startCalendar = Calendar.getInstance();
            startCalendar.setTime(startDate);

            // 打印日期
            while(tmp.getTime() < endDate.getTime()){
                tmp = startCalendar.getTime();
                // 天数加1
                startCalendar.add(Calendar.DAY_OF_MONTH,1);
                String dateStr = sdf.format(tmp);
//                dateList.add(dateStr);
                // 只统计生产数据
                // 统计类型 1：利润率，2：超时时长，3：返稿量，4：交付字数
                statProducesService.timingStatistics_1_lr("update", dateStr);
                statProducesService.timingStatistics_2_cs("update", dateStr);
                statProducesService.timingStatistics_3_fg("update", dateStr);
                statProducesService.timingStatistics_4_jf("update", dateStr);
            }
//            return Response.yes(dateList);
            return Response.yes("完成");
        } catch (Exception e) {
            System.out.println(e.toString());
            return Response.no("程序异常了");
        }
    }

    // 只统计订单数据
    @GetMapping("/timeSlot_2")
    public Response timeSlot_2(@RequestParam(value = "startDate", required = false) String startDateStr,
                               @RequestParam(value = "endDate", required = false) String endDateStr) {
        if (startDateStr == null || startDateStr.length() <= 0) {
            return Response.no("请输入要统计的开始日期！");
        }
        if (endDateStr == null || endDateStr.length() <= 0) {
            return Response.no("请输入要统计的结束日期！");
        }

        try {
            Long diffDays = Common.differentDaysByString(startDateStr, endDateStr);
            if(diffDays > 31){
                return Response.no("日期跨度不能超过31天！");
            }

//            List<String> dateList = new ArrayList<String>();

            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            // 起始日期
            Date startDate = sdf.parse(startDateStr);
            // 结束日期
            Date endDate = sdf.parse(endDateStr);

            Date tmp = startDate;
            Calendar startCalendar = Calendar.getInstance();
            startCalendar.setTime(startDate);

            // 打印日期
            while(tmp.getTime() < endDate.getTime()){
                tmp = startCalendar.getTime();
                // 天数加1
                startCalendar.add(Calendar.DAY_OF_MONTH,1);
                String dateStr = sdf.format(tmp);
//                dateList.add(dateStr);
                // 只统计订单数据
                // 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道占比
                statOrdersService.timingStatistics_1_dd("update", dateStr);
                statOrdersService.timingStatistics_2_tk("update", dateStr);
                statOrdersService.timingStatistics_3_cs("update", dateStr);
                statOrdersService.timingStatistics_4_lr("update", dateStr);
                statOrdersService.timingStatistics_5_qd("update", dateStr);
            }
//            return Response.yes(dateList);
            return Response.yes("完成");
        } catch (Exception e) {
            System.out.println(e.toString());
            return Response.no("程序异常了");
        }
    }

    @GetMapping("/annual")
    public Response annual(@RequestParam(value = "yearStr", required = false) String yearStr) {
        if (yearStr == null || yearStr.length() <= 0) {
            return Response.no("请输入要统计的年份！");
        }
        try {
            if(StringUtils.isNumeric(yearStr) == false){
                return Response.no("请输入正确的年份！");
            }

            Calendar calendar = Calendar.getInstance();
            Date today = new Date();
            calendar.setTime(today);

            if(calendar.get(Calendar.YEAR) < Integer.parseInt(yearStr)){
                return Response.no("未来可期，但不可欺");
            }

            if(calendar.get(Calendar.YEAR) - Integer.parseInt(yearStr) > 30){
                return Response.no("爱莫能助啊");
            }

//            List<String> dateList = new ArrayList<String>();

            DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            // 起始日期
            Date startDate = sdf.parse(yearStr + "-01-01");
            // 结束日期
            Date endDate = null;

            if(calendar.get(Calendar.YEAR) == Integer.parseInt(yearStr)){
                // 是今年 (这里取昨天的日期即可）
                endDate = new Date(System.currentTimeMillis() - 1000 * 60 * 60 * 24);
            }else{
                // 不是今年
                endDate = sdf.parse(yearStr + "-12-31");
            }
            Date tmp = startDate;
            Calendar startCalendar = Calendar.getInstance();
            startCalendar.setTime(startDate);

            // 打印日期
            while(tmp.getTime() < endDate.getTime()){
                tmp = startCalendar.getTime();
                // 天数加1
                startCalendar.add(Calendar.DAY_OF_MONTH,1);
                String dateStr = sdf.format(tmp);
//                dateList.add(dateStr);
                _timingStatistics(dateStr);
            }
//            return Response.yes(dateList);
            return Response.yes("完成");
        } catch (Exception e) {
            System.out.println(e.toString());
            return Response.no("程序异常了");
        }
    }

    /**
     * 定时统计
     * @param dateStr
     */
    private void _timingStatistics(String dateStr){
        // 定时统计销售数据
        // region 统计类型 1：下单额，2：开票额，3：回款额，4：超期未回
        statSalesService.timingStatistics_1_xd("update", dateStr);
        statSalesService.timingStatistics_2_kp("update", dateStr);
        statSalesService.timingStatistics_3_hk("update", dateStr);
        statSalesService.timingStatistics_4_cq("update", dateStr);
        // endregion

        // 定时统计生产数据
        // region 统计类型 1：利润率，2：超时率/时长，3：返稿率/量，4：交付字数
        statProducesService.timingStatistics_1_lr("update", dateStr);
        statProducesService.timingStatistics_2_cs("update", dateStr);
        statProducesService.timingStatistics_3_fg("update", dateStr);
        statProducesService.timingStatistics_4_jf("update", dateStr);
        // endregion

        // 定时统计订单数据
        // region 统计类型 1：订单额，2：退款率，3：超时率，4：利润率，5：渠道占比
        statOrdersService.timingStatistics_1_dd("update", dateStr);
        statOrdersService.timingStatistics_2_tk("update", dateStr);
        statOrdersService.timingStatistics_3_cs("update", dateStr);
        statOrdersService.timingStatistics_4_lr("update", dateStr);
        statOrdersService.timingStatistics_5_qd("update", dateStr);
        // endregion
    }
}
