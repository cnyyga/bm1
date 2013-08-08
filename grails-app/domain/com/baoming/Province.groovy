package com.baoming

class Province {
    String code // 代码 id
    String number //编号
    String name //名称
    Integer orderValue = 0
    static hasMany = [citys:City]
    static constraints = {
        code()
        name()
        number(nullable: true)
    }
    static mapping = {
        version(false)
        id generator: 'assigned', name: 'code'
        sort orderValue:'desc'
        citys(sort: 'orderValue',order: 'desc')
        number(unique: true)
    }
}
