package com.baoming

/**
 * 民族代码
 */
class Nation {
    String code // 代码
    String name //名称
    Integer orderValue = 0
    static constraints = {
    }
    static mapping = {
        version(false)
        sort orderValue:'desc'
    }
}
