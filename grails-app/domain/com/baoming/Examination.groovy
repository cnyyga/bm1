package com.baoming
import com.baoming.account.Student
/**
 * 考生会考成绩表
 */
class Examination {

    ScoreCode scoreCode // 成绩项代码
    String score //成绩
    static belongsTo = [student:Student]
    static constraints = {
    }
}
