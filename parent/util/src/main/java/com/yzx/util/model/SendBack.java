package com.yzx.util.model;
import com.fasterxml.jackson.annotation.JsonProperty;

public class SendBack {
//    "Message": "OK",
//    "RequestId": "873043ac-bcda-44db-9052-2e204c6ed20f",
//            "BizId": "607300000000000000^0",
//            "Code": "OK"

    @JsonProperty("Message")
    private String Message;
    @JsonProperty("RequestId")
    private String RequestId;
    @JsonProperty("BizId")
    private String BizId;
    @JsonProperty("Code")
    private String Code;

    public SendBack() {
    }

    public SendBack(String Message, String RequestId, String BizId, String Code) {
        this.Message = Message;
        this.RequestId = RequestId;
        this.BizId = BizId;
        this.Code = Code;
    }

    @JsonProperty("Message")
    public String getMessage() {
        return Message;
    }

    @JsonProperty("Message")
    public void setMessage(String Message) {
        this.Message = Message;
    }

    @JsonProperty("RequestId")
    public String getRequestId() {
        return RequestId;
    }

    @JsonProperty("RequestId")
    public void setRequestId(String RequestId) {
        this.RequestId = RequestId;
    }

    @JsonProperty("BizId")
    public String getBizId() {
        return BizId;
    }

    @JsonProperty("BizId")
    public void setBizId(String BizId) {
        this.BizId = BizId;
    }

    @JsonProperty("Code")
    public String getCode() {
        return Code;
    }

    @JsonProperty("Code")
    public void setCode(String Code) {
        this.Code = Code;
    }

    @Override
    public String toString() {
        return "SendBack{" +
                "Message='" + Message + '\'' +
                ", RequestId='" + RequestId + '\'' +
                ", BizId='" + BizId + '\'' +
                ", Code='" + Code + '\'' +
                '}';
    }
}
