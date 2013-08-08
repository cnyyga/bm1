package com.baoming

/**
 * 区
 */
class District {
    String name
    String code
    Integer orderValue = 0
    String number //编号
    static belongsTo = [city:City]
    static constraints = {
        code()
        name()
        city()
        number(nullable: true)
    }
    static mapping = {
        version(false)
        id generator: 'assigned', name: 'code'
        sort orderValue:'desc'
        number(unique: true)
    }
}
