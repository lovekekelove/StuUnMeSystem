package com.stumesystem.util;

import java.util.Random;

/**
 */
public class RandomUtil {
    //产生随机6位验证码
    //public static final char arry[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

    public static String getyzm(int len) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < len; i++) {
            String strRand = String.valueOf(random.nextInt(9));
            sb.append(strRand);
        }
//        System.out.println(sb.toString());
        return sb.toString();

    }

    public static void main(String[] args) {
        System.out.println(RandomUtil.getyzm(6));
    }

}
