package com.baoming

/**
 *   政治面貌
 */
class PoliticalStatus {
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
