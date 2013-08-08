package com.baoming

/**
 * 考生类别
 */
class StudentType {
    String code // 代码
    String name //名称
    Integer orderValue = 0
    static constraints = {

    }

    static mapping = {
        sort orderValue:'desc'
    }
}
