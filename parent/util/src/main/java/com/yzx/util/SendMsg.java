package com.yzx.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yzx.service.admin.Impl.LogServiceImpl;
import com.yzx.util.model.SendBack;
import com.yzx.service.admin.LogService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import static java.lang.Math.pow;

/*
pom.xml
<dependency>
  <groupId>com.aliyun</groupId>
  <artifactId>aliyun-java-sdk-core</artifactId>
  <version>4.0.3</version>
</dependency>
*/
@Component
public class SendMsg {
    private static LogService logService;

    private static String MOBILE_NUMBER_ILLEGAL="isv.MOBILE_NUMBER_ILLEGAL";
    private static String DAY_LIMIT_CONTROL="isv.DAY_LIMIT_CONTROL";
    private static String OUT_OF_SERVICE="isp.OUT_OF_SERVICE";

    @Autowired
    public SendMsg(LogService logService){
        SendMsg.logService=logService;
    }

    public static Map<String,String> sendmsg(String phoneNum){
        System.out.println(logService);
        logService.addLog("发送短信验证码回调：");

        DefaultProfile profile = DefaultProfile.getProfile("default", "LTAIpmmNQtAZrp8p", "Hq5ozK5rQ9UjsFgJLDKpW4jhl8kop3");
        IAcsClient client = new DefaultAcsClient(profile);
        int code=getRedomNum();

        CommonRequest request = new CommonRequest();
        //request.setProtocol(ProtocolType.HTTPS);
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("PhoneNumbers", phoneNum);
        request.putQueryParameter("SignName", "SSMHotel");
        request.putQueryParameter("TemplateCode", "SMS_167527459");
        request.putQueryParameter("TemplateParam", "{\"code\":"+code+"}");


        Map<String,String> ret=new HashMap<>();
        try {
            CommonResponse response = client.getCommonResponse(request);
            ObjectMapper mapper=new ObjectMapper();
            SendBack back=mapper.readValue(response.getData(), SendBack.class);
            System.out.println(back);
            logService.addLog("发送短信验证码回调："+back.toString());

            if(back.getCode().equals(MOBILE_NUMBER_ILLEGAL)){
                ret.put("type","error");
                ret.put("msg","号码输入错误");
                return ret;
            }
            if(back.getCode().equals(DAY_LIMIT_CONTROL)){
                ret.put("type","error");
                ret.put("msg","系统发送消息已达上限，请联系管理员");
                return ret;
            }
            if(back.getCode().equals(OUT_OF_SERVICE)){
                ret.put("type","error");
                ret.put("msg","业务已停机");
                return ret;
            }
            if(back.getCode().equals("OK")){
                ret.put("type","success");
                ret.put("code",String.valueOf(code));
                   return ret;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        ret.put("type","error");
        ret.put("msg","其他错误 请查看日志");
        return ret;
    }

    private static int getRedomNum(){
        Random random=new Random();
        int ret=0;
        for(int i=0;i<6;i++){
            ret= ret*10+random.nextInt(10);
            System.out.println(ret);
        }
       return ret;
    }
}
