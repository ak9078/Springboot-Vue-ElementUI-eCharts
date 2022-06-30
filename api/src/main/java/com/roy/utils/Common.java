package com.roy.utils;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

public class Common {
    /**
     * 比较两个日期相差的天数，生成2个日期中间的具体日期或月份
     * @param startDateStr
     * @param endDateStr
     * @return
     * @throws ParseException
     */
    public static JSONArray twoDays(String startDateStr, String endDateStr) throws ParseException {
        JSONArray resultArray = new JSONArray();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = sdf.parse(startDateStr);
        Date endDate = sdf.parse(endDateStr);

        // 按天返回
        resultArray.add(sdf.format(startDate));

        Calendar calBegin = Calendar.getInstance();
        // 使用给定的 Date 设置此 Calendar 的时间
        calBegin.setTime(startDate);
        Calendar calEnd = Calendar.getInstance();
        // 使用给定的 Date 设置此 Calendar 的时间
        calEnd.setTime(endDate);
        // 测试此日期是否在指定日期之后
        while (endDate.after(calBegin.getTime()))  {
            // 根据日历的规则，为给定的日历字段添加或减去指定的时间量
            calBegin.add(Calendar.DAY_OF_MONTH, 1);
            resultArray.add(sdf.format(calBegin.getTime()));
        }
        return resultArray;
    }

    /**
     * 比较两个日期相差的天数
     *
     * @param startDateStr 开始日期
     * @param endDateStr   结束日期
     * @return
     */
    public static long differentDaysByString(String startDateStr, String endDateStr) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        // 跨年不会出现问题
        // 如果时间为：2016-03-18 11:59:59 和 2016-03-19 00:00:01的话差值为 0
        Date startDate = sdf.parse(startDateStr);
        Date endDate = sdf.parse(endDateStr);
        long days = (endDate.getTime() - startDate.getTime()) / (1000 * 3600 * 24);
        return days;
    }

    /**
     * fastjson根据json数组中对象的某个字段进行排序
     *
     * @Description: is_desc:false升序列  is_desc:true降序 (排序字段为数字类型)
     */
    public static JSONArray jsonArraySort(JSONArray jsonArr, String sortKey, boolean is_desc) {

        JSONArray sortedJsonArray = new JSONArray();
        List<JSONObject> jsonValues = new ArrayList<JSONObject>();
        for (int i = 0; i < jsonArr.size(); i++) {
            jsonValues.add(jsonArr.getJSONObject(i));
        }
        Collections.sort(jsonValues, new Comparator<JSONObject>() {
            private final String KEY_NAME = sortKey;

            @Override
            public int compare(JSONObject a, JSONObject b) {
                int valA = 0;
                int valB = 0;
                try {
                    valA = a.getIntValue(KEY_NAME);
                    valB = b.getIntValue(KEY_NAME);
                } catch (JSONException e) {
                    e.printStackTrace();
                }

                if (is_desc) {
                    if (valA < valB) {
                        return 1;
                    }
                    if (valA == valB) {
                        return 0;
                    }
                    return -1;
                } else {
                    if (valA > valB) {
                        return 1;
                    }
                    if (valA == valB) {
                        return 0;
                    }
                    return -1;
                }

            }
        });
        for (int i = 0; i < jsonArr.size(); i++) {
            sortedJsonArray.add(jsonValues.get(i));
        }
        return sortedJsonArray;
    }

    /**
     * 判断字符串是否是日期
     * @param value 字符串
     * @param format 格式
     * @return
     */
    public static boolean isDate(String value, String format){
        SimpleDateFormat sdf = null;
        ParsePosition pos = new ParsePosition(0);// 指定从所传字符串的首位开始解析

        if(value == null || value.length() <= 0){
            return false;
        }
        try {
            sdf = new SimpleDateFormat(format);
            sdf.setLenient(false);
            Date date = sdf.parse(value,pos);
            if(date == null){
                return false;
            }else{
                // 更为严谨的日期,如2011-03-024认为是不合法的
                if(pos.getIndex() > sdf.format(date).length()){
                    return false;
                }
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
