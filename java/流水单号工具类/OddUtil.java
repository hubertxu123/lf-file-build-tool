package org.jingniu.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * 流水号生成管理：
 * <p>
 * 请购申请     QGSQ+日期+4位流水
 * 采购申请     CGSQ+日期+4位流水
 * 采购接收     CGRK+日期+4位流水
 * 采购 退货直接更新采购申请  不生成新单据
 **/
public class OddUtil {

    /**
     * 采购申请     CGSQ+日期+4位流水
     */
    public static final String ODDNUM_CGSQ = "CGSQ";
    /**
     * 采购接收     CGRK+日期+4位流水
     */
    public static final String ODDNUM_CGRK = "CGRK";
    /**
     * 请购申请     QGSQ+日期+4位流水
     */
    public static final String ODDNUM_QGSQ = "QGSQ";

    /**
     * 编写测试流水订单号
     * @param num
     * @return
     */
    public static String getBody(Integer num) {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String str = String.format("%04d", num);
        return sdf.format(new Date()).substring(0, 8) + str;

    }

    /**
     * 截取流水单号入库日期
     *
     * @param string
     * @return
     */
    public static int getOddSenttime(String string) {
        int oddSenttime = Integer.parseInt(string.substring(4, 12));
        return oddSenttime;

    }

    public static int getNowTimeCode() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMdd");
        int nowTimeCode = Integer.parseInt(simpleDateFormat.format(new Date()).substring(0, 8));
        return nowTimeCode;
    }

    public static void main(String[] args) {
        System.err.println(createOdd("QGSQ", "QGSQ202003210123"));
        System.err.println(createOdd("QGSQ", "QGSQ20200321ZZ23"));
        System.err.println(createOdd("QGSQ", "QGSQ20200321ZZZ3"));
        System.err.println(createOdd("QGSQ", "QGSQ20200321ZZ99"));
        System.err.println(createOdd("QGSQ", "QGSQ20200321A013"));
        String name1 = "9998";
        String name2 = "9999";
        String name3 = "A001";
        String name4 = "A998";
        String name5 = "Z001";
        String name6 = "Z999";
        String name7 = "ZA01";
        String name8 = "ZA99";
        String name9 = "ZZ09";
        String name10 = "ZZ99";
        String name11 = "ZZZ1";
        String name12 = "ZZZZ";

        System.err.println(splitNumNext(name1, 0));
        System.err.println(splitNumNext(name2, 0));
        System.err.println(splitNumNext(name3, 0));
        System.err.println(splitNumNext(name4, 0));
        System.err.println(splitNumNext(name5, 0));
        System.err.println(splitNumNext(name6, 0));
        System.err.println(splitNumNext(name7, 0));
        System.err.println(splitNumNext(name8, 0));
        System.err.println(splitNumNext(name9, 0));
        System.err.println(splitNumNext(name10, 0));
        System.err.println(splitNumNext(name11, 0));
        System.err.println(splitNumNext(name12, 0));

    }


    public static Map<String, String> splitNum(String str, int i) {
        HashMap<String, String> om = new HashMap<>();
        if (i <= str.toCharArray().length) {
            String suffix = str.substring(0, i);
            String currStr = str.substring(i);
            if (isNumeric(currStr)) {
                om.put("suffix", suffix);
                om.put("number", currStr);
                return om;
            } else {
                return splitNum(str, i + 1);
            }
        } else {
            return null;
        }
    }

    /**
     * 判断字符串并加一
     *
     * @param str
     * @param i
     * @return
     */
    public static String splitNumNext(String str, int i) {
        String suffix = str.substring(0, i);
        String currStr = str.substring(i);
        if (isNumeric(currStr)) {
            if (suffix.equals("")) {
                suffix = null;
            }
            if (currStr.equals("")) {
                currStr = null;
            }
            //9999
            if (suffix == null) {
                //头
                if (currStr.equals("9999")) {
                    return "A001";
                } else {
                    return getConvertNum(currStr);
                }
            } else if (currStr == null) {
                if (suffix.equals("ZZZZ")) {
                    //当天流水号已用完，返回null
                    return null;
                } else {//ZZZA-ZZZY 只剩25个加一
                    String s = getNextChar(suffix);
                    return s;
                }
            } else if (suffix != null && currStr != null) {
                //suffix长度为0或4的已经在上面处理，此处处理1-3
                return getNextOdd(suffix.length(), suffix, currStr);
            }
        } else {
            return splitNumNext(str, i + 1);
        }
        return null;
    }

    private static String getNextOdd(int length, String suffix, String currStr) {
        //前缀长度不可能为4，只处理1,2,3
        String zNum = length == 2 ? "Z" : length == 3 ? "ZZ" : "";
        suffix = suffix.substring(length - 1);
        //不是Z就是A-Y，取得是最后一个字母
        if (suffix.equals("Z")) {
            if (currStr.equals("999")) {
                return "ZA01";
            } else if (currStr.equals("99")) {
                return "ZZA1";
            } else if (currStr.equals("9")) {
                return "ZZZA";
            } else {
                String str = getConvertNum(currStr);
                return zNum + suffix + str;
            }
        } else {
            //如果不是Z，每个字母满999都要将前缀加一
            if (currStr.equals("999")) {
                return zNum + getNextChar(suffix) + "001";
            } else if (currStr.equals("99")) {
                return zNum + getNextChar(suffix) + "01";
            } else if (currStr.equals("9")) {
                return zNum + getNextChar(suffix) + "1";
            } else {
                String str = getConvertNum(currStr);
                return zNum + suffix + str;
            }
        }
    }

    private static String getConvertNum(String currStr) {
        return String.format("%0" + currStr.length() + "d", (Integer.parseInt(currStr) + 1));
    }

    private static String getNextChar(String suffix) {
        char[] chars = suffix.toCharArray();
        char last = (char) (chars[chars.length - 1] + 1);
        chars[chars.length - 1] = last;
        return String.valueOf(chars);
    }


    public static boolean isNumeric(String str) {
        Pattern pattern = Pattern.compile("[0-9]*");
        return pattern.matcher(str).matches();
    }


    /**
     * 生成流水单号
     *
     * @param suffix:     请购申请     QGSQ+日期+4位流水
     *                    采购申请     CGSQ+日期+4位流水
     *                    采购接收     CGRK+日期+4位流水
     * @param oddMaxCode: QGSQ202003010023
     * @return
     */
    public static String createOdd(String suffix, String oddMaxCode) {
        String nowOdd = null;
        //如果最大流水单号不为空
        if (oddMaxCode != null) {
            //如果当前时间不相同，例如：20181009=！20180809，重新开始以当天日期拼流水单号201810100001
            if (getNowTimeCode() != getOddSenttime(oddMaxCode)) {
                int number = 1;
                nowOdd = new StringBuffer(suffix).append(getBody(number)).toString();
                //相同，则加1，例如：201810100002
            } else {
                //TODO 处理当天超过9999，然后进位 为 A001-A999 B001-B999   ZA01-ZA99
                //获取最后四位流水号
                String odd = oddMaxCode.substring(12, 16);
                String s = splitNumNext(odd, 0);
                nowOdd = new StringBuffer(suffix).append(oddMaxCode.substring(4,12)).append(s).toString();
            }
        } else {
            //如果没有流水单号，以当前日期重新开始生成流水单号
            int number = 1;
            nowOdd = new StringBuffer(suffix).append(getBody(number)).toString();
        }
        return nowOdd;
    }

}

