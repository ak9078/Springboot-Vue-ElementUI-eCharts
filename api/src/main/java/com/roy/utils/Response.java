package com.roy.utils;

public class Response<T> {

    private Boolean success;

    private Integer code;

    private String message;

    private T data;

    public Response() {
    }

    public Response(Boolean success, Integer code) {
        this.success = success;
        this.code = code;
    }

    public Response(Boolean success, Integer code, String message) {
        this.success = success;
        this.code = code;
        this.message = message;
    }

    public Response(Boolean success, Integer code, String message, T data) {
        this.success = success;
        this.code = code;
        this.message = message;
        this.data = data;
    }

    public static <T> Response<T> yes() {
        return new Response(true, 0, "操作成功");
    }

    public static <T> Response<T> yes(String message,T data) {
        return new Response(true, 0, message, data);
    }

    public static <T> Response<T> yes(T data) {
        return new Response(true, 0, "", data);
    }

    public static <T> Response<T> no() {
        return new Response(false, 1, "操作失败");
    }

    public static <T> Response<T> no(String message) {
        return new Response(false, 1, message);
    }

    public Boolean isSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public Integer getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
