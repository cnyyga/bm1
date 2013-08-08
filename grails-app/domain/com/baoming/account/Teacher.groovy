package com.baoming.account

import com.baoming.City
import com.baoming.Department


class Teacher extends User{

    String name
    Date dateCreated
    Date lastUpdated
    City city
    String pinyin
    String yumu

    Department department
    Integer taskNumber = 0 //任务数

    static hasMany = [students:Student,teacherCitys:TeacherCity,teacherDistricts:TeacherDistrict]

    static constraints = {
        name(nullable: true)
        city nullable: true
        pinyin nullable: true
        yumu nullable: true
        department nullable: true
        taskNumber nullable: true
    }
}
