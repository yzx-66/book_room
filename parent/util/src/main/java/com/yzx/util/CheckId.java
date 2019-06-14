package com.yzx.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import com.yzx.service.admin.LogService;
import net.sf.json.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 *身份证查询调用示例代码 － 聚合数据
 *在线接口文档：http://www.juhe.cn/docs/38
 **/
@Component
public class CheckId {
    public static final String DEF_CHATSET = "UTF-8";
    public static final int DEF_CONN_TIMEOUT = 30000;
    public static final int DEF_READ_TIMEOUT = 30000;
    public static String userAgent =  "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36";
    //配置您申请的KEY
    public static final String APPKEY ="ce534bcf858022c664abc97dc7e3a1c2";


    private static LogService logService;

    @Autowired
    public CheckId(LogService logService){
        CheckId.logService=logService;
    }

    //1.身份证信息查询
    public static Map<String ,String> getRequest1(String idNum,String username) {
        Map<String, String> ret = new HashMap<>();

        String result = null;
        String url = "http://apis.juhe.cn/idcard/index";//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("cardno", "610103200006203613");//身份证号码
        params.put("dtype", "json");//返回数据格式：json或xml,默认json
        params.put("key", APPKEY);//你申请的key

        try {
            result = net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if (object.getInt("error_code") == 0) {
                System.out.println(object.get("result"));
                ret.put("type", "success");
                logService.addLog("用户名："+username+"实名认证成功");
            } else {
                System.out.println(object.get("error_code") + ":" + object.get("reason"));
                ret.put("type", "error");
                ret.put("msg", (String) object.get("reason"));
                logService.addLog("用户名："+username+"实名认证失败"+"，原因："+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }

    //2.身份证泄漏查询
    public static void getRequest2(){
        String result =null;
        String url ="http://apis.juhe.cn/idcard/leak";//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("cardno","");//身份证号码
        params.put("dtype","");//返回数据格式：json或xml,默认json
        params.put("key",APPKEY);//你申请的key

        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //3.身份证挂失查询
    public static void getRequest3(){
        String result =null;
        String url ="http://apis.juhe.cn/idcard/loss";//请求接口地址
        Map params = new HashMap();//请求参数
        params.put("cardno","");//身份证号码
        params.put("dtype","");//返回数据格式：json或xml,默认json
        params.put("key",APPKEY);//你申请的key

        try {
            result =net(url, params, "GET");
            JSONObject object = JSONObject.fromObject(result);
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     *
     * @param strUrl 请求地址
     * @param params 请求参数
     * @param method 请求方法
     * @return  网络请求字符串
     * @throws Exception
     */
    public static String net(String strUrl, Map params,String method) throws Exception {
        HttpURLConnection conn = null;
        BufferedReader reader = null;
        String rs = null;
        try {
            StringBuffer sb = new StringBuffer();
            if(method==null || method.equals("GET")){
                strUrl = strUrl+"?"+urlencode(params);
            }
            URL url = new URL(strUrl);
            conn = (HttpURLConnection) url.openConnection();
            if(method==null || method.equals("GET")){
                conn.setRequestMethod("GET");
            }else{
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
            }
            conn.setRequestProperty("User-agent", userAgent);
            conn.setUseCaches(false);
            conn.setConnectTimeout(DEF_CONN_TIMEOUT);
            conn.setReadTimeout(DEF_READ_TIMEOUT);
            conn.setInstanceFollowRedirects(false);
            conn.connect();
            if (params!= null && method.equals("POST")) {
                try {
                    DataOutputStream out = new DataOutputStream(conn.getOutputStream());
                    out.writeBytes(urlencode(params));
                } catch (Exception e) {
                    // TODO: handle exception
                }
            }
            InputStream is = conn.getInputStream();
            reader = new BufferedReader(new InputStreamReader(is, DEF_CHATSET));
            String strRead = null;
            while ((strRead = reader.readLine()) != null) {
                sb.append(strRead);
            }
            rs = sb.toString();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
        return rs;
    }

    //将map型转为请求参数型
    public static String urlencode(Map<String,Object>data) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry i : data.entrySet()) {
            try {
                sb.append(i.getKey()).append("=").append(URLEncoder.encode(i.getValue()+"","UTF-8")).append("&");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }
}
