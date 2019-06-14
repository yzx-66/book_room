package com.yzx;

import static org.junit.Assert.assertTrue;

import org.junit.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Unit test for simple App.
 */
public class AppTest 
{
    /**
     * Rigorous Test :-)
     */
    @Test
    public void shouldAnswerWithTrue()
    {
        assertTrue( true );
    }

    @Test
    public void test() throws ParseException {
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        Date date1=format.parse("0000-00-00");
        Calendar rightNow = Calendar.getInstance();
        rightNow.setTime(date);
//        rightNow.add(Calendar.YEAR,-1);//日期减1年
//        rightNow.add(Calendar.MONTH,3);//日期加3个月
        rightNow.add(Calendar.DAY_OF_YEAR,30);//日期加10天
        System.out.println(rightNow.getTime());
        System.out.println(rightNow.getTime().compareTo(date));

    }

    @Test
    public void test1() throws ParseException {
        Date now=new Date();
        SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
        Date now_day=format.parse(format.format(now));
        Date date=format.parse("2019-6-16");
        System.out.println(now);
        System.out.println(now_day.compareTo(date));
    }
}
