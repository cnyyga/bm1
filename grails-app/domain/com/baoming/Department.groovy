package com.baoming

class Department {

    String code // 代码
    String name //名称
    Integer orderValue = 0 //排序值
    Integer taskNumber = 0 //任务数
    static constraints = {
        name blank: false
        code nullable: true,blank: false
    }

    static mapping = {
        version(false)
        sort orderValue:'asc'
    }
}
